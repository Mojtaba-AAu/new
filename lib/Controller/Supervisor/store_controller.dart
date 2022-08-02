import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:project101/Model/Supervisor/stores.dart';
import 'package:project101/theme_helper.dart';

class StoreController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentLocation();
    _store.bindStream(getStores());
  }

//Display Firebase data in a Listview without DUPLICATES in it
  final Rx<List<StoresModel>> _store = Rx<List<StoresModel>>([]);

  List<StoresModel> get store => _store.value;

  final CollectionReference storeReference =
      FirebaseFirestore.instance.collection("storeManager");
  var docID = [];

  Stream<List<StoresModel>> getStores() {
    return storeReference.snapshots().map((event) {
      List<StoresModel> retVal = [];
      event.docs.forEach((element) {
        retVal.add(StoresModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  var name = TextEditingController();
  var desc = TextEditingController();

  bool? storeName;
  bool? storeDesc;
void onChangeName(String value){
  if(store.contains(value) && value.length<=3){
    storeName=false;
  }
  update();
}
void onChangeDesc(String value){
 if(value.length <= 3){
   storeDesc=false;
 }
 update();
}
  void addStore() {
    storeReference.doc().set({
      "name": name.text,
      "description": desc.text,
      "latitude":latitude,
      "longitude":longitude
    }).then((value){
    name.text="";
    desc.text="";
    latitude=null;
    longitude=null;
    });
  }


  Completer<GoogleMapController> googleMapController = Completer();
  late GoogleMapController newGoogleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Position? position;
  String addressLocation = "";
  String? latitude,longitude;


  void getMarkers(double lat, double lang) {
    MarkerId markerId = MarkerId(lat.toString() + lang.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, lang),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: InfoWindow(snippet: addressLocation));
    markers[markerId] = _marker;
    update();
  }

  Future<void> getCurrentLocation() async {
    var per = await Geolocator.checkPermission();
    print(per);
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    print(per);
    if (per == LocationPermission.always) {
      Position currentPosition =
          await GeolocatorPlatform.instance.getCurrentPosition();
      position = currentPosition;
    }
    update();
  }

  onPressed(tapped) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(tapped.latitude, tapped.longitude);
      // getMarkers(tapped.latitude, tapped.longitude);
      Placemark place = placeMarks[0];
      addressLocation =
          "${place.locality}, ${place.subLocality}, ${place.country}";
      latitude=tapped.latitude;
      longitude=tapped.longitude;
      update();
    } catch (e) {
      Get.defaultDialog(
          cancel: MaterialButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("ok")),
          title: "title",
          content: Text(e.toString()));
    }
  }

  void mapController(mapController) {
    newGoogleMapController = mapController;
    googleMapController.complete(mapController);
    update();
  }

  Future<void> locatePosition() async {
    Position myPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    position = myPosition;
    LatLng latLngPosition = LatLng(myPosition.latitude, myPosition.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    newGoogleMapController.setMapStyle("normal");
    update();
  }

  MapType defaultMapType = MapType.normal;

  void changeMapType() {
    defaultMapType =
        defaultMapType == MapType.normal ? MapType.satellite : MapType.normal;
    update();
  }
  Future<void> showSearchDialog(context) async {
   try{
     var p = await PlacesAutocomplete.show(
         context: context,
         apiKey: "AIzaSyCuHs2pgQ0iCHvJWiQe_kerLN3dyPPK96U",
         mode: Mode.overlay,
         offset: 0,
         hint: "إبحث هنا",
         types: [],
         radius: 1000,
         strictbounds: false,
         components: [Component(Component.country, "ar")]);
     getLocationFromPlaceId(p!.placeId!);
   }catch(e){
     print(e);
   }
   update();
  }

  Future<void> getLocationFromPlaceId(String? placeId) async {
    GoogleMapsPlaces _places =GoogleMapsPlaces(
      apiKey: "AIzaSyCuHs2pgQ0iCHvJWiQe_kerLN3dyPPK96U",
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail=await _places.getDetailsByPlaceId(placeId.toString());
    _animateCamera(LatLng(detail.result.geometry!.location.lat,
        detail.result.geometry!.location.lng));
    update();
  }
  Future<void> _animateCamera(LatLng _location) async {
    final GoogleMapController controller = await googleMapController.future;
    CameraPosition _cameraPosition = CameraPosition(
      target: _location,
      zoom: 13.00,
    );
    print(
        "animating camera to (lat: ${_location.latitude}, long: ${_location.longitude}");
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
    update();
  }
}
