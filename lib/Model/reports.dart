import 'package:cloud_firestore/cloud_firestore.dart';

// class Report {
//   String? coordinator;
//   String? store;
//   String? dateTime;
//
// //endingDesc
//   Report(
//       this.coordinator,
//       this.store,
//       this.dateTime);
//   Report.fromJson(Map<dynamic, dynamic> map) {
//     coordinator = map["coordinator"];
//     store = map["store"];
//     dateTime = map["dateTime"];
//   }
//   toJson() {
//     return {
//       "coordinator": coordinator,
//       "store": store,
//       "dateTime": dateTime,
//     };
//   }
// }

class Report {
  String? docID;
  String? coordinator;
  String? store;
  Timestamp? dateTime;
  String? product;
  String? desc;
  String? availaple;
  Timestamp? ending;
  String? endingDesc;
  int? rack;
  int? warehouse;
  int? total;
  String? imageAfore;
  String? imageAfer;
//endingDesc
  Report(
      this.docID,
      this.coordinator,
      this.store,
      this.dateTime,
      this.product,
      this.desc,
      this.availaple,
      this.ending,
      this.endingDesc,
      this.rack,
      this.warehouse,
      this.total,
      this.imageAfore,
      this.imageAfer);
  Report.fromDocumentSnapshot(DocumentSnapshot  snapshot) {
    docID=snapshot["docID"];
    coordinator = snapshot["coordinator"];
    store = snapshot["store"];
    dateTime = snapshot["dateTime"];
    product = snapshot["product"];
    desc = snapshot["description"];
    availaple = snapshot["availaple"];
    ending = snapshot["ending"];
    endingDesc = snapshot["endingDesc"];
    rack = snapshot["rack"];
    warehouse = snapshot["warehouse"];
    total = snapshot["total"];
    imageAfore = snapshot["imageAfore"];
    imageAfer = snapshot["imageAfer"];
  }

    Report.fromJson(Map<dynamic, dynamic> map) {
    coordinator = map["coordinator"];
    store = map["store"];
    dateTime = map["dateTime"];
    coordinator = map["coordinator"];
    store = map["store"];
    dateTime = map["dateTime"];
    product = map["product"];
    desc = map["description"];
    availaple = map["availaple"];
    ending = map["ending"];
    endingDesc = map["endingDesc"];
    rack = map["rack"];
    warehouse = map["warehouse"];
    total = map["total"];
    imageAfore = map["imageAfore"];
    imageAfer = map["imageAfer"];
  }

  toJson() {
    return {
      "coordinator": coordinator,
      "store": store,
      "dateTime": dateTime,
      "product": product,
      "description": desc,
      "availaple": availaple,
      "ending": ending,
      "endingDesc": endingDesc,
      "rack": rack,
      "warehouse": warehouse,
      "total": total,
      "imageAfore": imageAfore,
      "imageAfer": imageAfer
    };
  }
}
