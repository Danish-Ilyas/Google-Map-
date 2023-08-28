import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex =const CameraPosition(
      target: LatLng(33.6844, 73.0479),
      zoom: 14.4746,

  );

  List<Marker> _marker = [];
  List<Marker> _list = [
    Marker(markerId: MarkerId('1'),
      position: LatLng(33.6844, 73.0479),
      infoWindow: InfoWindow(
        title: 'My Position',
      )
    ),
    Marker(markerId: MarkerId('2'),
      position: LatLng(33.7380 , 73.084488),
      infoWindow: InfoWindow(
        title: 'sec E-11',
      )

    )
  ];


  @override
  void initState(){
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Google Map"),
        ),
        body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
