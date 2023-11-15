// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_2023_it4785/pages/cell_towers/model/cell_tower.model.dart';
import 'package:flutter_2023_it4785/pages/map_tel/helper.dart';
import 'package:flutter_2023_it4785/pages/map_tel/model/ParsedTelephonyInfo.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_telephony_info/flutter_telephony_info.dart';
import 'package:geolocator/geolocator.dart';
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
  Set<RippleMarker> additionalMarkers = {};
  Set<Circle> additionalCircles = {};
  // Telephony
  final _flutterTelephonyInfoPlugin = TelephonyAPI();
  String? errorMessage;

  // custom marker icon
  BitmapDescriptor? connectingTowerIcon;
  BitmapDescriptor? currentLocationIcon;

  // Geolocator
  LatLng? _currentLocation;
  StreamSubscription<Position>? _positionStream;

  @override
  void initState() {
    super.initState();
    _manager = _initClusterManager();
    getBytesFromAsset('assets/images/cell_tower.png', 128).then((bytes) {
      setState(() {
        connectingTowerIcon = BitmapDescriptor.fromBytes(bytes);
      });
    });
    ClusteringMakersHelper.getMarkerBitmapCurrentPosition(75)
        .then((BitmapDescriptor currentIcon) {
      setState(() {
        currentLocationIcon = currentIcon;
      });
    });
    // _trackLocation();
    _updateCurrentLocationGPS();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
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

  Future<void> _updateCurrentLocationGPS() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> _trackLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position != null) {
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
        });
      }
    });

    setState(() {
      _positionStream = positionStream;
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
            print(rawTelephonyInfo.cellId);
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

    additionalMarkers = records.map(
      (record) {
        CellTower tower = record.$2;
        return RippleMarker(
            markerId: MarkerId(tower.id.toString()),
            position: LatLng(tower.lat, tower.long),
            icon: connectingTowerIcon ?? BitmapDescriptor.defaultMarker,
            ripple: true);
      },
    ).toSet();

    additionalCircles = records.map(
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
        target: LatLng(records.first.$2.lat, records.first.$2.long), zoom: 15);
    (await _controller.future)
        .animateCamera(CameraUpdate.newCameraPosition(newPosition));

    setState(() {});
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
    Set<Marker> allMarkers = {...markers, ...additionalMarkers};
    if (_currentLocation != null && currentLocationIcon != null) {
      allMarkers.add(Marker(
          markerId: const MarkerId('_currentLocation'),
          icon: currentLocationIcon!,
          position: _currentLocation!));
    }
    return Scaffold(
        body: Animarker(
          mapId: _controller.future.then<int>((value) => value.mapId),
          curve: Curves.bounceInOut,
          duration: const Duration(seconds: 10),
          rippleColor: Colors.green,
          rippleRadius: 0.3,
          markers: allMarkers,
          child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _initPosition,
              // markers: {...markers, ...additionalMarkers},
              circles: additionalCircles,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                _manager.setMapId(controller.mapId);
              },
              onCameraMove: _manager.onCameraMove,
              onCameraIdle: _manager.updateMap),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            findMyLocation();
            _updateCurrentLocationGPS();
          },
          mini: true,
          child: const Icon(Icons.gps_fixed_outlined),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
