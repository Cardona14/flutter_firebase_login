import 'package:final_project_pmsn2023/pages/address_search.dart';
import 'package:final_project_pmsn2023/pages/place_services.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  final _controller = TextEditingController();
  String? _ubicationName = '';
  double? _lat = 0;
  double? _lot = 0;
  final String title = "Map Sample";
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              readOnly: true,
              onTap: () async {
                // generate a new token here
                final sessionToken = Uuid().v4();
                final Suggestion? result = await showSearch(
                  context: context,
                  delegate: AddressSearch(sessionToken),
                );
                // This will change the text displayed in the TextField
                if (result != null) {
                  final placeDetails = await PlaceApiProvider(sessionToken)
                      .getPlaceDetailFromId(result.placeId);
                  setState(() {
                    _controller.text = result.description;
                    _ubicationName = placeDetails.ubicationName;
                    _lat = placeDetails.lat;
                    _lot = placeDetails.lot;
                  });
                }
              },
              decoration: InputDecoration(
                icon: Container(
                  width: 10,
                  height: 10,
                  child: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                ),
                hintText: "Enter your shipping address",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
              ),
            ),
            SizedBox(height: 20.0),
            Text('Name: $_ubicationName'),
            Text('lat: $_lat'),
            Text('lot: $_lot'),
          ],
        ),
      ),
    );
  }
}
