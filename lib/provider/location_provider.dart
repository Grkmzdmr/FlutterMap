import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  BitmapDescriptor _pinLocationIcon;
  BitmapDescriptor _pinLocationIcon1;
  
  Map<MarkerId, Marker> _markers;
  Map<MarkerId, Marker> get markers => _markers;
  final MarkerId markerId = MarkerId("1");
  final MarkerId marker1Id = MarkerId("2");
  final MarkerId marker2Id = MarkerId("3");

  GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  Location _location;
  Location _otherLocation;
  Location _otherLocation1;
  Location get otherLocation => _otherLocation;
  Location get location => _location;
  BitmapDescriptor get pinLocationIcon => _pinLocationIcon;
  BitmapDescriptor get pinLocationIcon1 => _pinLocationIcon1;
  
  LatLng _otherLocationPosition1;
  LatLng get otherLocationPosition1 => _otherLocationPosition1;
  LatLng _otherLocationPosition;
  LatLng get otherLocationPosition => _otherLocationPosition;
  LatLng _locationPosition;
  LatLng get locationPosition => _locationPosition;

  bool locationServiceActive = true;

  LocationProvider() {
    _location = new Location();
    _otherLocation = new Location();
    _otherLocation1 = new Location();
    _markers = <MarkerId, Marker>{};
  }

  initialization() async {
    await getUserLocation();
    await setCustomMapPin();
    await SetCustomMap1Pin();
    
  }

  getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return;
      }
    }
    location.onLocationChanged().listen(
      (LocationData currentLocation) {
        _locationPosition = LatLng(
          currentLocation.latitude,
          currentLocation.longitude,
        );
        _otherLocationPosition = LatLng(37.50, -121.50);
        print("Diğer pozisyon : $_otherLocationPosition");
        _otherLocationPosition1 = LatLng(37.41199, -122.050);

        print(_locationPosition);

        _markers.clear();
        Marker marker1 = Marker(
          markerId: marker1Id,
          position: LatLng(_otherLocationPosition.latitude,
              _otherLocationPosition.longitude),
          icon: pinLocationIcon1,
          draggable: true,
        );
        Marker marker2 = Marker(
          markerId: marker1Id,
          position: LatLng(_otherLocationPosition1.latitude,
              _otherLocationPosition1.longitude),
          icon: pinLocationIcon1,
          draggable: true,
        );

        Marker marker = Marker(
          markerId: markerId,
          position: LatLng(
            _locationPosition.latitude,
            _locationPosition.longitude,
          ),
          icon: pinLocationIcon,
          draggable: true,
          onDragEnd: ((newPosition) {
            _locationPosition = LatLng(
              newPosition.latitude,
              newPosition.longitude,
            );

            notifyListeners();
          }),
        );

        _markers[markerId] = marker;
        _markers[marker1Id] = marker1;
        _markers[marker2Id] = marker2;

        notifyListeners();
      },
    );
  }

  setMapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  setCustomMapPin() async {
    _pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/images/destination_map_marker.png',
    );
  }

  SetCustomMap1Pin() async {
    _pinLocationIcon1 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/car_icon.png');
  }

  
  takeSnapshot() {
    return _mapController.takeSnapshot();
  }
}
