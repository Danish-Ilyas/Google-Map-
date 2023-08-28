import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();

}

class _CurrentLocationState extends State<CurrentLocation> {

  final Completer<GoogleMapController> _controller = Completer() ;

  static const CameraPosition _kGooglePlex = CameraPosition(

      target: LatLng(33.6844, 73.0479),
      zoom: 14,
  );

  List<Marker> _marker =  <Marker>[
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(33.6844, 73.0479),
      infoWindow: InfoWindow(
        title: 'Position'
      )
    )
  ];

  Future<Position> UsersCurrentLocation() async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace){
      print("error" + error.toString());
    });

    return await Geolocator.getCurrentPosition();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Find Our Location"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(

        onPressed: (){

          UsersCurrentLocation().then((value)async{
            print('My Current Location');
            print(value.latitude.toString() + " " + value.longitude.toString());
            
            _marker.add(
              Marker(
                markerId: MarkerId('2'),
                position: LatLng(value.latitude , value.longitude),
                infoWindow: InfoWindow(
                  title: 'My Current Location',
                )
              ),
            );

            CameraPosition cameraPosition = CameraPosition(
              zoom: 14,
              target: LatLng(value.latitude, value.longitude),
            );

            final GoogleMapController controller = await _controller.future ;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

            setState(() {

            });

          });

        },
        child: Icon(Icons.local_activity),

      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
