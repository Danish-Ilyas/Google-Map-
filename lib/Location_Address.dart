import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String stAddress = '', stAdd = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(stAddress),
            Text(stAdd),
            GestureDetector(
              onTap: () async {
                List<Location> locations =
                    await locationFromAddress("Islamabad, Pakistan");
                List<Placemark> placemarks = await placemarkFromCoordinates(31.8626, 70.9019);

                setState(() {
                  stAddress = locations.last.longitude.toString() +
                      " " +
                      locations.last.latitude.toString();
                  stAdd = placemarks.reversed.last.administrativeArea.toString() +
                      " " +
                  placemarks.reversed.last.country.toString();
                });
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Center(
                    child: Text('Convert'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
