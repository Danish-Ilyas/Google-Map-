import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart'as http;
import 'package:google_map_api/Places_Api.dart';

class PlacesApi extends StatefulWidget {
  const PlacesApi({super.key});

  @override
  State<PlacesApi> createState() => _PlacesApiState();


}

class _PlacesApiState extends State<PlacesApi> {

  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '11223344';

  List<dynamic> _placesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.addListener(() {
      onChange();
    });
  }

  void onChange(){
    if(_sessionToken == null){

      setState(() {
        _sessionToken = uuid.v4();
      });

    }

    getSuggestion(_controller.text);
  }

  void getSuggestion(String input)async{

    String kPLACES_API_KEY = "AIzaSyAkP7qwR4d583-cUgw1qC1XGHMCY_BwYiA";
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString() ;


    if(response.statusCode == 200){
        setState(() {
          _placesList = jsonDecode(response.body.toString()) ['predictions'];
        });
    }else{
      throw Exception("Failed");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Search Place API'),
      ),
      body:  Padding(
        padding: EdgeInsets.symmetric(vertical: 12 , horizontal: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search Places',
              ),
            ),

            Expanded(
                child: ListView.builder(
                    itemCount: _placesList.length,
                    itemBuilder: (context, index){
                    return ListTile(
                      title: Text(_placesList[index] ['description']),
                    );
            }))
          ],
        ),
      ),
    );
  }
}
