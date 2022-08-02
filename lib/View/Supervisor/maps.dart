import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MapSample());
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake =  CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);



  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Position? position;
  late String addressLocation;
  late String country;
  late String postalCode;

  void getMarkers(double lat, double lang) {
    MarkerId markerId = MarkerId(lat.toString() + lang.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, lang),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: InfoWindow(snippet: "Umm Huwayds"));
    setState(() {
      markers[markerId] = _marker;
    });
  }
//15.101739281212884, 32.65042936236013
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        onTap: (tapped) async {
        try{
          // GeoData data = await Geocoder2.getDataFromCoordinates(
          //     latitude: 15.101739281212884,
          //     longitude: 32.65042936236013,
          //     googleMapApiKey:
          //     "AIzaSyCuHs2pgQ0iCHvJWiQe_kerLN3dyPPK96U");
         getMarkers(tapped.latitude, tapped.longitude);
         //  country = data.country;
         //  postalCode = data.postalCode;
         //  addressLocation = data.address;
         //
        }catch(error){
          print(error);
        }
        },
        initialCameraPosition: _kGooglePlex,
        compassEnabled: true,
        trafficEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
       markers:
          Set<Marker>.of(markers.values),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:(){
        },
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}