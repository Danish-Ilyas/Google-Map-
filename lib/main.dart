import 'package:flutter/material.dart';
import 'package:google_map_api/Home_Screen.dart';
import 'package:google_map_api/Location_Address.dart';
import 'package:google_map_api/Location_Current.dart';
import 'package:google_map_api/Places_Api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurrentLocation(),
    );
  }
}
