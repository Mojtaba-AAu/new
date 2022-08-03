import 'package:cloud_firestore/cloud_firestore.dart';

class StoresModel{
  String? name;
  double? lat;
  double? long;
  String? description;
  String? storeID;

  StoresModel({this.name, this.lat, this.long, this.description, this.storeID});

  StoresModel.fromDocumentSnapshot(DocumentSnapshot  snapshot){
    name=snapshot["name"];
    lat=snapshot["latitude"];
    long=snapshot["longitude"];
    description=snapshot["description"];
    storeID=snapshot.id;
  }
}