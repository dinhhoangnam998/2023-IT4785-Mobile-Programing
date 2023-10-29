// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_2023_it4785/pages/cell_towers/model/cell_tower.model.dart';
import 'package:flutter_2023_it4785/pages/map_tel/helper.dart';
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
  final Completer<GoogleMapController> _controller = Completer();
  final CameraPosition _initPosition = const CameraPosition(
      target: LatLng(21.006125886435946, 105.84324355419052), // HUST
      zoom: 9.0);
  // Maker Cluster
  late ClusterManager _manager;
  Set<Marker> markers = {};
  Set<Marker> additionalMarkers = {};
  Set<Circle> additionalCircles = {};
  // Telephony
  final _flutterTelephonyInfoPlugin = TelephonyAPI();
  String? errorMessage;

  // custom marker icon
  BitmapDescriptor? connectingTowerIcon;

  @override
  void initState() {
    super.initState();
    _manager = _initClusterManager();
    getBytesFromAsset('assets/images/cell_tower.png', 128).then((bytes) {
      setState(() {
        connectingTowerIcon = BitmapDescriptor.fromBytes(bytes);
      });
    });
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<CellTower>(widget.cellTowers, _updateMarkers,
        markerBuilder: ClusteringMakersHelper.markerBuilder,
        stopClusteringZoom: 14);
  }

  void _updateMarkers(Set<Marker> markers) {
    setState(() {
      this.markers = markers;
    });
  }

  void notify(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }

  Future<List<ParsedTelephonyInfo>> getParsedTelephonyInfo() async {
    try {
      List<TelephonyInfo?>? telInfoList =
          await _flutterTelephonyInfoPlugin.getInfo();
      if (telInfoList == null) {
        notify("No telephony info was found!", Colors.blue);
        return Future.value([]);
      }
      List<ParsedTelephonyInfo> parsedTelInfos = [];
      for (var rawTelephonyInfo in telInfoList) {
        if (rawTelephonyInfo != null) {
          try {
            parsedTelInfos.add(parseRawTelephonyInfo(rawTelephonyInfo));
          } catch (e) {}
        }
      }
      notify(
          "Parsed successfully: ${parsedTelInfos.length}/${telInfoList.length}!",
          Colors.blue);
      return parsedTelInfos;
    } on PlatformException catch (e) {
      notify(e.toString(), Colors.red);
      return Future.value([]);
    }
  }

  Future<List<ParsedTelephonyInfo>> getMockupParsedTelephonyInfo() async {
    List<ParsedTelephonyInfo> parsedTelInfos = [
      ParsedTelephonyInfo(
          mcc: 452,
          mnc: 2,
          lac: 12059,
          cellId: 78983792,
          signalStrengthLevel: 2),
      ParsedTelephonyInfo(
          mcc: 452,
          mnc: 2,
          lac: 12059,
          cellId: 78983341,
          signalStrengthLevel: 4)
    ];
    return parsedTelInfos;
  }

  List<(ParsedTelephonyInfo, CellTower)> findAccordingCellTower(
      List<ParsedTelephonyInfo> parsedTelInfos) {
    List<(ParsedTelephonyInfo, CellTower)> foundRecords = [];
    List<ParsedTelephonyInfo> notFoundTelInfos = [];
    for (var telInfo in parsedTelInfos) {
      try {
        var tower = widget.cellTowers.firstWhere(
          (cellTower) =>
              telInfo.mcc == cellTower.mcc &&
              telInfo.mnc == cellTower.mnc &&
              telInfo.lac == cellTower.lac &&
              telInfo.cellId == cellTower.cellId,
        );
        foundRecords.add((telInfo, tower));
      } catch (e) {
        notFoundTelInfos.add(telInfo);
      }
    }
    if (notFoundTelInfos.isNotEmpty) {
      notify(
          '${notFoundTelInfos.length}/${parsedTelInfos.length} parsedTelInfos were not found according cell towers!',
          Colors.orange);
    }
    return foundRecords;
  }

  void visualizeConnectingCellTowers(
      List<(ParsedTelephonyInfo, CellTower)> records) async {
    if (records.isEmpty) return;

    Set<Marker> markers = records.map(
      (record) {
        CellTower tower = record.$2;
        return Marker(
            markerId: MarkerId(tower.id.toString()),
            position: LatLng(tower.lat, tower.long),
            icon: connectingTowerIcon ?? BitmapDescriptor.defaultMarker);
      },
    ).toSet();

    Set<Circle> circles = records.map(
      (record) {
        ParsedTelephonyInfo tel = record.$1;
        CellTower tower = record.$2;
        return Circle(
            circleId: CircleId(tower.id.toString()),
            center: LatLng(tower.lat, tower.long),
            radius: tower.radiusInMeters.toDouble(),
            strokeWidth: 2,
            strokeColor: Colors.green,
            fillColor: const Color.fromARGB(255, 3, 161, 87)
                .withOpacity(0.15 * tel.signalStrengthLevel));
      },
    ).toSet();

    CameraPosition newPosition = CameraPosition(
        target: LatLng(
            records.first.$2.lat, records.first.$2.long),
        zoom: 15);
    (await _controller.future)
        .animateCamera(CameraUpdate.newCameraPosition(newPosition));

    setState(() {
      additionalMarkers = markers;
      additionalCircles = circles;
    });
  }

  void findMyLocation() async {
    // List<ParsedTelephonyInfo> parsedTels = await getParsedTelephonyInfo();
    List<ParsedTelephonyInfo> parsedTels = await getMockupParsedTelephonyInfo();
    List<(ParsedTelephonyInfo, CellTower)> records =
        findAccordingCellTower(parsedTels);
    List<CellTower> connectingCells = records.map((item) => item.$2).toList();
    List<CellTower> remainCells = widget.cellTowers
        .where((cell) => !connectingCells.contains(cell))
        .toList();
    _manager.setItems(remainCells);
    visualizeConnectingCellTowers(records);
  }

  @override
  Widget build(BuildContext context) {
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
          onPressed: findMyLocation,
          mini: true,
          child: const Icon(Icons.gps_fixed_outlined),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
