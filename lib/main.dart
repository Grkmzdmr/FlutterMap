import 'package:flutter/material.dart';
import 'package:flutter_gmaps/google_map.dart';
import 'package:flutter_gmaps/model/loadData.dart';
import 'package:flutter_gmaps/provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

/*Future<LoadData> apiCall() async {
  final response = await http.get(


    
  );
}*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
          child: LocationMap(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.green,
        ),
        title: 'Map App',
        home: LocationMap(),
      ),
    );
  }
}
