import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project101/Controller/Admin/user_controller.dart';
import 'package:project101/Model/Supervisor/stores.dart';
import 'package:project101/Model/users.dart';

class CoordinatorController extends GetxController {
  final CollectionReference userReference =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference storeReference =
  FirebaseFirestore.instance.collection("storeManager");
  final CollectionReference brandReference =
  FirebaseFirestore.instance.collection("brandManager");
  final controller = Get.put(UserController());
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _coordinator
        .bindStream(getStores(controller.UsersModel!.uid.toString()));
    _rxStores.bindStream(getStore());
    _rxBrand.bindStream(getBrands());
  }

//Display Firebase data in a Listview without DUPLICATES in it
  final Rx<List<usersModel>> _coordinator = Rx<List<usersModel>>([]);

  List<usersModel> get coordinator => _coordinator.value;

  Stream<List<usersModel>> getStores(String suID) {
    return userReference
        .where("suID", isEqualTo: suID)
        .snapshots()
        .map((event) {
      List<usersModel> retVal = [];
      event.docs.forEach((element) {
        retVal.add(usersModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  var record = <StoresModel>[];

  Widget buildStore(String coorID) {
    return StreamBuilder<QuerySnapshot>(
      stream: storeReference.where("coorID", isEqualTo: coorID).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();
        buildListStores(snapshot.data!.docs);
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
                return ListTile(
                  leading: IconButton(
                      onPressed: () {
                        deleteStore(record[index].storeID.toString());
                      },
                      icon: Icon(
                        Icons.cancel,
                        size: 28,
                        color: Get.theme.primaryColor,
                      )),
                  title: Text(record[index].name.toString()),
                );
              }),
        )
            : const SizedBox();
      },
    );
  }

  buildListStores(List<DocumentSnapshot> snapshot) {
    record.clear();
    snapshot.forEach((data) {
      record.add(StoresModel.fromDocumentSnapshot(data));
    });
  }

  checkStores(index) {
    return CheckboxListTile(
      onChanged: (bool? value) {
        stores[index].check = value;
        update();
      },
      value: stores[index].check,
      title: Text(stores[index].name.toString()),
      activeColor: Get.theme.primaryColor,
    );
  }

  final Rx<List<StoresModel>> _rxStores = Rx<List<StoresModel>>([]);
  List<StoresModel> get stores => _rxStores.value;
  Stream<List<StoresModel>> getStore() {
    return storeReference
        .where("coorID", isEqualTo: "")
        .snapshots()
        .map((event) {
      List<StoresModel> stores = [];
      event.docs.forEach((element) {
        print(element.id);
        stores.add(StoresModel.fromDocumentSnapshot(element));
      });
      return stores;
    });
  }

  void addStore(String coorID, List<StoresModel> store) {
    for (int i = 0; i < store.length; i++) {
      if (store[i].check == true) {
        storeReference.doc(store[i].storeID).update({"coorID": coorID});
      }
    }
  }

  void deleteStore(String uid) {
    storeReference.doc(uid).update({"coorID": ""});
  }

  ////////////////////////////////

  var list = <BrandModels>[];

  Widget buildBrand(String coorID) {
    return StreamBuilder<QuerySnapshot>(
      stream: brandReference.where("coorID", isEqualTo: coorID).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();
        buildListBrand(snapshot.data!.docs);
        return list.isNotEmpty
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
                return ListTile(
                  leading: IconButton(
                      onPressed: () {
                        deleteBrand(list[index].brandID.toString());
                      },
                      icon: Icon(
                        Icons.cancel,
                        size: 28,
                        color: Get.theme.primaryColor,
                      )),
                  title: Text(list[index].brandName.toString()),
                );
              }),
        )
            : const SizedBox();
      },
    );
  }

  buildListBrand(List<DocumentSnapshot> snapshot) {
    list.clear();
    snapshot.forEach((data) {
      list.add(BrandModels.fromDocumentSnapshot(data));
    });
  }

  checkBrand(index) {
    return CheckboxListTile(
      onChanged: (bool? value) {
        brand[index].check = value;
        update();
      },
      value: brand[index].check,
      title: Text(brand[index].brandName.toString()),
      activeColor: Get.theme.primaryColor,
    );
  }

  final Rx<List<BrandModels>> _rxBrand = Rx<List<BrandModels>>([]);
  List<BrandModels> get brand => _rxBrand.value;
  Stream<List<BrandModels>> getBrands() {
    return brandReference
        .where("coorID", isEqualTo: "")
        .snapshots()
        .map((event) {
      List<BrandModels> brand = [];
      event.docs.forEach((element) {
        print(element.id);
        brand.add(BrandModels.fromDocumentSnapshot(element));
      });
      return brand;
    });
  }

  void addBrand(String coorID, List<BrandModels> brand) {
    for (int i = 0; i < brand.length; i++) {
      if (brand[i].check == true) {
        brandReference.doc(brand[i].brandID).update({"coorID": coorID});
      }
    }
  }

  void deleteBrand(String uid) {
    brandReference.doc(uid).update({"coorID": ""});
  }
}
