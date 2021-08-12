

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


class mapView extends StatefulWidget {
  const mapView({Key key}) : super(key: key);

  @override
  _mapViewState createState() => _mapViewState();
}

class _mapViewState extends State<mapView> {
 
  
  

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            width: 500,
            height: 400,
            child: GoogleMap(
              initialCameraPosition: initialLocation,

            ),
            ),
      
             
        ],
      ),
    );
  }
}
