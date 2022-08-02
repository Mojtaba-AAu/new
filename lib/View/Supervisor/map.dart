import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project101/Controller/Supervisor/store_controller.dart';

class GoogleMaps extends GetWidget<StoreController> {
  GoogleMaps({Key? key}) : super(key: key);

  StoreController storeController = Get.put(StoreController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
        init: Get.put<StoreController>(StoreController()),
        builder: (StoreController storeController) => Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: (){
                      storeController.showSearchDialog(context);
                    },
                    icon: const Icon(Icons.search_outlined))
              ],
            ),
            body:storeController.position!=null? Container(
                child: Stack(
                  children: [
                    GoogleMap(
                      onTap: (tapped) {
                        storeController.onPressed(tapped);
                      },
                      mapType: storeController.defaultMapType,
                      myLocationEnabled: true,
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: true,
                      onMapCreated: (GoogleMapController mapController) {
                        storeController.mapController(mapController);
                        storeController.locatePosition();
                        storeController.changeMapType();
                      },
                      initialCameraPosition: CameraPosition(
                          bearing: 192.8334901395799,
                          target: LatLng(storeController.position!.longitude,
                              storeController.position!.longitude),
                          zoom: 19.151926040649414),
                      markers: Set<Marker>.of(storeController.markers.values),
                    ),
                    Positioned(
                        top: Get.height / 1.7,
                        right: 10,
                        left: 10,
                        child: Container(
                          color: Colors.white.withOpacity(0.5),
                          child: Column(
                            children: [
                              Text(storeController.addressLocation),
                              ElevatedButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                      cancel: MaterialButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("ok")),
                                      title: "title",
                                      content: Text(
                                          "${storeController.latitude} ${storeController.longitude}"));
                                },
                                child: const Text(
                                  "Select",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 80, right: 15),
                      alignment: Alignment.topRight,
                      child: Column(children: <Widget>[
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: FloatingActionButton(
                              child: const Icon(
                                Icons.my_location,
                                color: Colors.black45,
                              ),
                              elevation: 5,
                              backgroundColor: Colors.white.withOpacity(0.7),
                              shape: const RoundedRectangleBorder(),
                              onPressed: () {
                                storeController.locatePosition();
                              }),
                        ),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 120, right: 15),
                      alignment: Alignment.topRight,
                      child: Column(children: <Widget>[
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: FloatingActionButton(
                              child: const Icon(
                                Icons.layers,
                                color: Colors.black,
                              ),
                              elevation: 5,
                              backgroundColor: Colors.white,
                              // shape: const RoundedRectangleBorder(),
                              onPressed: () {
                                storeController.changeMapType();
                              }),
                        ),
                      ]),
                    ),
                  ],
                ),
              ): const Center(
              child: CircularProgressIndicator(),
            ),
      )
    );
  }


}

//AIzaSyCuHs2pgQ0iCHvJWiQe_kerLN3dyPPK96U
