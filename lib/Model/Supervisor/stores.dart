import 'package:cloud_firestore/cloud_firestore.dart';

class StoresModel {
  String? name;
  double? lat;
  double? long;
  String? description;
  String? storeID;
  String? coorID;
  bool? check;

  StoresModel(
      {this.name,
      this.lat,
      this.long,
      this.description,
      this.storeID,
      this.coorID,
      this.check});

  StoresModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    name = snapshot["name"];
    lat = snapshot["latitude"];
    long = snapshot["longitude"];
    description = snapshot["description"];
    coorID = snapshot["coorID"];
    storeID = snapshot.id;
    check = false;
  }
}
class BrandModels{
  String? brandName;
  String? image;
  String? brandID;
  String? coorID;
  bool? check;

  BrandModels({this.brandName, this.image, this.check, this.brandID,this.coorID});

  BrandModels.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    brandName=snapshot["brandName"];
    image=snapshot["image"];
    brandID=snapshot.id;
    coorID=snapshot["coorID"];
    check=false;
  }
}