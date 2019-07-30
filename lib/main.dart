import 'dart:async';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  int currentPage = 0;
  Completer<GoogleMapController> _controller = Completer();
 // Set<Marker> markers = Set();
  final Set<Marker> _markers = Set();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(16.7860299, 96.1545012),
    zoom: 14.4746,

      );


  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: GoogleMap(
          markers: _markers,
          mapType: MapType.normal,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _markers.add(
              Marker(
                markerId: MarkerId('newyork'),
                position: LatLng(16.7860299, 96.1545012),
              ),
            );
            },
        ),
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.directions_bus, title: "Bus"),
            TabData(iconData: Icons.child_care, title: "Child Info"),
            TabData(iconData: Icons.settings, title: "Setting")
          ],
          circleColor: Colors.orange,
          barBackgroundColor: Colors.white70,
          onTabChangedListener: (position) {
            switch(position){
              case 1:
                print("Clicked $position");
                SecondRoute();
                break;
            }
           // print("Clicked $position");
            setState(() {
              currentPage = position;
            });
          },
        )
//      floatingActionButton: FloatingActionButton.extended(
//      onPressed: _goToTheLake,
//      label: Text('To the lake!'),
//      icon: Icon(Icons.directions_boat),
//    ),
        );
  }
}


class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
