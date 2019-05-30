import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class MapSample extends StatefulWidget {
  var locationState;
  MapSample({this.locationState});
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _kGooglePlex;

  static CameraPosition _kLake;

  @override
  void initState() {
    print('MAPA location');
    print(widget.locationState.toString());
    setState(() {
      _kLake = CameraPosition(
          // bearing: 192.8334901395799,
          target: LatLng(
            widget.locationState['latitude'],
            widget.locationState['longitude'],
          ),
          tilt: 59.440717697143555,
          zoom: 19.0);
      _kGooglePlex = CameraPosition(
        target: LatLng(
          widget.locationState['latitude'],
          widget.locationState['longitude'],
        ),
        zoom: 14.4746,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: _goToTheLake,
        label: Text('Mi zona'),
        icon: Icon(
          Icons.my_location,
          size: 30,
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
