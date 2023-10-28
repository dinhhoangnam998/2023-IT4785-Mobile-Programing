import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_2023_it4785/pages/cell_towers/cubit/cell_towers_cubit.dart';
import 'package:flutter_2023_it4785/pages/cell_towers/model/cell_tower.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Set<Marker> getMarkers(CellTowersState state, LatLng currentLocation) {
  Set<Marker> markers = state.when(
      initial: () => {},
      error: (message) => {},
      loaded: (cellTowers) => cellTowers.map((cell) {
            return Marker(
                markerId: MarkerId(cell.id.toString()),
                icon: getMarkerIcon(cell, currentLocation),
                position: LatLng(cell.lat, cell.long));
          }).toSet());
  return markers;
}

BitmapDescriptor getMarkerIcon(CellTower cell, LatLng currentLocation) {
  double distanceInMeters = Geolocator.distanceBetween(
      cell.lat, cell.long, currentLocation.latitude, currentLocation.longitude);
  return distanceInMeters <= cell.radiusInMeters
      ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
      : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
}

Set<Circle> getCircles(CellTowersState state, LatLng currentLocation) {
  Set<Circle> circles = state.when(
      initial: () => {},
      error: (message) => {},
      loaded: (cellTowers) => cellTowers.where((cell) {
            double distanceInMeters = Geolocator.distanceBetween(cell.lat,
                cell.long, currentLocation.latitude, currentLocation.longitude);
            return distanceInMeters < 2 * cell.radiusInMeters;
          }).map((cell) {
            return Circle(
                circleId: CircleId(cell.id.toString()),
                center: LatLng(cell.lat, cell.long),
                radius: cell.radiusInMeters.toDouble(),
                strokeWidth: 2,
                fillColor: getCircleColor(cell, currentLocation));
          }).toSet());
  return circles;
}

Color getCircleColor(CellTower cell, LatLng currentLocation) {
  double distanceInMeters = Geolocator.distanceBetween(
      cell.lat, cell.long, currentLocation.latitude, currentLocation.longitude);
  int cellRadius = cell.radiusInMeters;
  if (distanceInMeters > 2 * cellRadius) {
    return Colors.transparent;
  }
  if (distanceInMeters > cellRadius) {
    return const Color.fromARGB(255, 2, 107, 156).withOpacity(0.1);
  }
  return const Color.fromARGB(255, 3, 161, 87).withOpacity(0.4);
}

class MapGPSPage extends StatefulWidget {
  const MapGPSPage({super.key});

  @override
  State<MapGPSPage> createState() => _MapGPSPageState();
}

class _MapGPSPageState extends State<MapGPSPage> {
  LatLng? _currentLocation;
  StreamSubscription<Position>? _positionStream;
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

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
      distanceFilter: 1,
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

  @override
  void initState() {
    super.initState();
    _trackLocation();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CellTowersCubit, CellTowersState>(
      builder: (context, state) {
        if (_currentLocation == null) {
          return const Center(child: Text('Locating current location...'));
        }

        Set<Marker> markers = getMarkers(state, _currentLocation!);
        Set<Circle> circles = getCircles(state, _currentLocation!);
        Marker currentLocationMarker = Marker(
            markerId: const MarkerId('_currentLocation'),
            icon: BitmapDescriptor.defaultMarker,
            position: _currentLocation!);
        return GoogleMap(
          onMapCreated: (controller) => _mapController.complete(controller),
          initialCameraPosition:
              CameraPosition(target: _currentLocation!, zoom: 14),
          markers: {...markers, currentLocationMarker},
          circles: circles,
        );
      },
    );
  }
}
