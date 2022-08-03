import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:project101/Model/Supervisor/products.dart';

class ProductController extends GetxController {
  final CollectionReference productReference =
      FirebaseFirestore.instance.collection("productManager");

  var product = TextEditingController();
  var code = TextEditingController();
  var desc = TextEditingController();

  String? barCode;
  String? barError;

  Future<void> barScan() async {
    try {
      await FlutterBarcodeScanner.scanBarcode(
              "5AD3BC", "إلغاء", true, ScanMode.BARCODE)
          .then((value) {
        barCode = value;
      });
    } catch (e) {
      barError = "غير قادر على قراءة هذا";
    }
    update();
  }
  late File image;
  String? url;
  void getImage() async {
    final myImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      image = File(myImage!.path);
update();
  }
  void uploadImage() async {
    TaskSnapshot ref = FirebaseStorage.instance
        .ref()
        .child(p.basename(image.path)).putFile(image).snapshot;
    url=await ref.ref.getDownloadURL();
    update();
  }

  var record = <ProductsModel>[];
  Widget buildBody(String storeID) {
    return StreamBuilder<QuerySnapshot>(
      stream: productReference.where("storeID", isEqualTo: storeID).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();
        buildList(snapshot.data!.docs);
        return record.isNotEmpty
            ? Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey, width: 1),
                  shape: BoxShape.rectangle,
                ),
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return Row(
                        children: [
                          Image.network(
                            record[index].image.toString(),
                            width: 70,
                            height: 70,
                          ),
                          Column(
                            children: [
                              Text("المنتج : ${record[index].product}"),
                              const Divider(color: Colors.grey),
                              Text("الوصف : ${record[index].product}"),
                              const Divider(color: Colors.grey),
                              Text("الباركود : ${record[index].product}"),
                            ],
                          ),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.edit)),
                        ],
                      );
                    }),
              )
            : const SizedBox();
      },
    );
  }

  buildList(List<DocumentSnapshot> snapshot) {
    record.clear();
    snapshot.forEach((data) {
      record.add(ProductsModel.fromDocumentSnapshot(data));
    });
  }
}
