import 'package:flutter/material.dart';
import 'package:flutter_gmaps/pop_up.dart';
import 'package:flutter_gmaps/provider/location_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class LocationMap extends StatefulWidget {
  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initialization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.green,
            selectedFontSize: 16,
            unselectedFontSize: 16,
            
            
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "Anasayfa"),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Ayarlar"),

            ],
          ),
      
      appBar: AppBar(
         actions: [popUp()],
            title: Title(
              child: Text(
                "Navigasyon",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              color: Colors.green,
            ),
            centerTitle: true,
        
        
      ),
      body: googleMapUI(),
      
    );
  }

  Widget googleMapUI() {
    return Consumer<LocationProvider>(builder: (consumerContext, model, child) {
      if (model.locationPosition != null) {
        return Column(
          children: [
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: model.locationPosition,
                  zoom: 18,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: Set<Marker>.of(model.markers.values),
                onMapCreated: (GoogleMapController controller) async {
                  Provider.of<LocationProvider>(context, listen: false)
                      .setMapController(controller);
                },
              ),
            ),
          ],
        );
      }

      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
