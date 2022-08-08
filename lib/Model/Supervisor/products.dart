import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModel{
  String? product;
  String? description;
  String? barCode;
  String? image;
  String? storeID;


  ProductsModel({this.product, this.description, this.barCode, this.image,
    this.storeID});

  ProductsModel.fromDocumentSnapshot(DocumentSnapshot  snapshot){
    product=snapshot["product"];
    description=snapshot["description"];
    barCode=snapshot["barCode"];
    image=snapshot["image"];
    storeID=snapshot["storeID"];
  }

  toJson() {
    return {
      "product": product,
      "description": description,
      "barCode": barCode,
      "image": image,
      "storeID": storeID,
    };
  }
}