import 'package:cloud_firestore/cloud_firestore.dart';

class usersModel {
  String? userName;
  String? password;
  String? email;
  String? phone;
  int? type;
  String? uid;
  String? suID;
  bool? check;

  usersModel(
      {this.userName,
      this.password,
      this.email,
      this.phone,
      this.type,
      this.uid,
      this.suID,
      this.check});

  usersModel.fromDocumentSnapshot(DocumentSnapshot  snapshot) {
    userName = snapshot["username"];
    password = snapshot["password"];
    email = snapshot["email"];
    phone = snapshot["phone"];
    type = snapshot["type"];
    suID = snapshot["suID"];
    uid=snapshot.id;
    check=false;
  }

  usersModel.fromJson(Map map) {
    userName = map["username"];
    password = map["password"];
    email = map["email"];
    phone = map["phone"];
    type = map["type"];
    suID = map["suID"];
    uid=map["uid"];
    check=map["check"];
  }
  toJson() {
    return {
      "username": userName,
      "password": password,
      "email": email,
      "phone": phone,
      "type": type,
      "suID": suID,
      "uid":uid,
      "check":check
    };
  }
}
