import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Completer<GoogleMapController> _controlgooglemapcompliter = Completer();
  GoogleMapController _googleMapController ;
  Position  currentposition;
  var geolocaator = Geolocator();

  void mydevicelocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentposition = position;
    LatLng latLng = LatLng(currentposition.latitude, currentposition.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: latLng,zoom: 14);
    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  static final CameraPosition _mirpurlocation = CameraPosition(target: LatLng(23.8223,90.3654),zoom: 14.4746);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GoogleMap(

        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        initialCameraPosition: _mirpurlocation,
        onMapCreated: (GoogleMapController controller){
          _controlgooglemapcompliter.complete(controller);
          _googleMapController=controller;
          mydevicelocation();
        },

      ),
    );

  }
}


