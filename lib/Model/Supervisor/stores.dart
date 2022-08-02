import 'package:cloud_firestore/cloud_firestore.dart';

class StoresModel{
  String? name;
  double? lat;
  double? long;
  String? Description;

  StoresModel({this.name, this.lat, this.long, this.Description});

  StoresModel.fromDocumentSnapshot(DocumentSnapshot  snapshot){
    name=snapshot["name"];
    lat=snapshot["latitude"];
    long=snapshot["longitude"];
    Description=snapshot["description"];
  }
}