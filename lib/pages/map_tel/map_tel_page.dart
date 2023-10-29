import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_2023_it4785/pages/cell_towers/model/cell_tower.model.dart';
import 'package:flutter_2023_it4785/pages/map_tel/model/ParsedTelephonyInfo.dart';
import 'package:flutter_telephony_info/flutter_telephony_info.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTelPage extends StatefulWidget {
  final List<CellTower> cellTowers;

  const MapTelPage({super.key, required this.cellTowers});

  @override
  State<MapTelPage> createState() => _MapTelPageState();
}

class _MapTelPageState extends State<MapTelPage> {
  // GG Maps
  Completer<GoogleMapController> _controller = Completer();
  final CameraPosition _initPosition = const CameraPosition(
      target: LatLng(21.006125886435946, 105.84324355419052), zoom: 9.0);

  // Maker Cluster
  late ClusterManager _manager;
  Set<Marker> markers = Set();

  // Telephony
  final _flutterTelephonyInfoPlugin = TelephonyAPI();
  List<ParsedTelephonyInfo>? _currentConnectingTelInfo;
  String? errorMessage;

  @override
  void initState() {
    _manager = _initClusterManager();
    super.initState();
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<CellTower>(widget.cellTowers, _updateMarkers,
        markerBuilder: _markerBuilder, stopClusteringZoom: 14);
  }

  void _updateMarkers(Set<Marker> markers) {
    // print('Updated ${markers.length} markers');
    setState(() {
      this.markers = markers;
    });
  }

  void _updateLocation() async {
    try {
      List<TelephonyInfo?>? telInfoList =
          await _flutterTelephonyInfoPlugin.getInfo();

      if (telInfoList == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("No telephony info found!"),
          backgroundColor: Colors.blue,
        ));
      } else {
        List<TelephonyInfo> telInfos = telInfoList
            .where((element) => element != null)
            .toList() as List<TelephonyInfo>;

        var errors = [];
        List<ParsedTelephonyInfo> parsedTelInfos = [];
        telInfos.forEach((rawTelephonyInfo) {
          try {
            ParsedTelephonyInfo parsedTelInfo =
                parseRawTelephonyInfo(rawTelephonyInfo);
            parsedTelInfos.add(parsedTelInfo);
          } catch (e) {
            errors.add(e.toString());
          }
        });
        _currentConnectingTelInfo = parsedTelInfos;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Parsed successfully: ${parsedTelInfos.length}/${telInfos.length}!"),
          backgroundColor: Colors.blue,
        ));
      }
    } on PlatformException catch (e) {
      errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage!),
        backgroundColor: Colors.orange,
      ));
    }
    setState(() {});
  }

  (Set<Marker>, Set<Circle>) _getMarkersAndCircles() {
    if (_currentConnectingTelInfo == null) return ({}, {});

    Set<CellTower> currentConnectingCellTowers = {};
    _currentConnectingTelInfo!.forEach((telInfo) {
      try {
        var tower = widget.cellTowers.firstWhere(
          (cellTower) =>
              telInfo.mcc == cellTower.mcc &&
              telInfo.mnc == cellTower.mnc &&
              telInfo.lac == cellTower.lac &&
              telInfo.cellId == cellTower.cellId,
        );
        currentConnectingCellTowers.add(tower);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Cannot find tel info in cell towers list'),
          backgroundColor: Colors.orange,
        ));
      }
    });

    return ({}, {});
  }

  @override
  Widget build(BuildContext context) {
    var (Set<Marker> additionalMarkers, Set<Circle> additionalCircles) =
        _getMarkersAndCircles();

    return Scaffold(
        body: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initPosition,
            markers: {...markers, ...additionalMarkers},
            circles: additionalCircles,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _manager.setMapId(controller.mapId);
            },
            onCameraMove: _manager.onCameraMove,
            onCameraIdle: _manager.updateMap),
        floatingActionButton: FloatingActionButton(
          onPressed: _updateLocation,
          mini: true,
          child: const Icon(Icons.gps_fixed_outlined),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  Future<Marker> Function(Cluster<CellTower>) get _markerBuilder =>
      (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            print('---- $cluster');
            cluster.items.forEach((p) => print(p));
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.isMultiple ? cluster.count.toString() : null),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
    // if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.orange;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }
}
