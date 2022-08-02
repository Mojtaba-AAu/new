import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project101/Model/users.dart';
import 'package:project101/View/Supervisor/home.dart';
import 'package:project101/View/admin/home.dart';
import 'package:project101/theme_helper.dart';

class UserController extends GetxController {
  var users = <usersModel>[].obs;
  var docID = [];
  var isLoad = false.obs;
  var username = TextEditingController();
  var password = TextEditingController();
  final CollectionReference userReference =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference adminReference =
      FirebaseFirestore.instance.collection("admin");

  getUsers() async {
    isLoad(true);
    try {
      // await userReference.get().then((value) {
      //   docID.clear();
      //   value.docs.forEach((element) {
      //     docID.add(element.id);
      //   });
      // });
      // users.clear();
      // for (int i = 0; i < docID.length; i++) {
      //   await userReference.doc(docID[i]).get().then((value) {
      //     print(value.data());
      //     if (value.get("username") == username.text.trim().toString() &&
      //         value.get("password") == password.text.trim().toString()) {
      //       users.add(usersModel.fromDocumentSnapshot(value));
      //     }
      //   });
      // }
      users.clear();
     await userReference
          .where("username", isEqualTo: username.text)
          .where("password", isEqualTo: password.text)
          .get()
          .then((value) {
            value.docs.forEach((element) {
              users.add(usersModel.fromDocumentSnapshot(element));
            });
      });
      isLoad(false);
      print(users.length);
      if (users.isEmpty) {
        Get.snackbar("خطاء", "خطاء في اسم المستخدم او كلمة المرور",
            colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
      }
      adminReference.get().then((value) {});
      // for (int i = 0; i < users.length; i++) {
        if (users[0].type == 0) {
          Get.offAll(() => AD_Home());
        } else if (users[0].type == 1) {
          Get.offAll(() => SU_Home());
        } else if (users[0].type == 2) {
          Get.offAll(() => SU_Home());
        }
      // }
    } catch (error) {
      isLoad(false);
      printError();
      Get.snackbar("خطاء", "خطاء في الاتصال بالشبكة",
          colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _rxUsers.bindStream(getReports());
    _rxCoordinator.bindStream(getCoordinator());
  }

  Rx<List<usersModel>> _rxUsers = Rx<List<usersModel>>([]);
  List<usersModel> get getUser => _rxUsers.value;
  var name = TextEditingController();
  var pass = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var type = TextEditingController();
  Stream<List<usersModel>> getReports() {
    return userReference.orderBy("username").snapshots().map((event) {
      List<usersModel> retVal = [];
      event.docs.forEach((element) {
        print("element.id");
        retVal.add(usersModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  int _userType = 1;
  int get userType => _userType;
  void setUserType(type) {
    _userType = type;
    print("The user Type is " + "${_userType}");
    update();
  }

  void editUserType(String id, int type) {
    userReference.doc(id).update({"type": type}).then((value) {
      if (type == 1) {
        userReference.doc(id).update({"suID": ""});
      }
      if (record.isNotEmpty && type == 2) {
        record.forEach((element) {
          userReference.doc(element.uid).update({"suID": ""});
        });
      }
    });
    print("///////////////////////");
    print(id);
    print("/////////////////////////");
  }

  Future<void> addUser() async {
    isLoad(true);
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      )
          .then((value) {
        if (value.additionalUserInfo!.isNewUser) {
          userReference.doc(FirebaseAuth.instance.currentUser!.uid).set({
            "email": email.text,
            "password": pass.text,
            "phone": phone.text,
            "type": userType,
            "suID": "",
            "username": name.text
          });
        }
      });

      isLoad(false);
    } on FirebaseAuthException catch (e) {
      isLoad(false);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Get.snackbar("خطاء", "كلمة المرور ضعيفة",
            colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.snackbar("خطاء", "الايميل موجود مسبقا",
            colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoad(false);
      print(e);
    }
    isLoad(false);
  }

  /////////////////////
  var record = <usersModel>[];

  Widget buildBody(String uid) {
    return StreamBuilder<QuerySnapshot>(
      stream: userReference.where("suID", isEqualTo: uid).snapshots(),
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
                      return ListTile(
                        leading: IconButton(
                            onPressed: () {
                              deleteCoordinator(record[index].uid.toString());
                            },
                            icon: Icon(
                              Icons.cancel,
                              size: 28,
                              color: Get.theme.primaryColor,
                            )),
                        title: Text(record[index].userName.toString()),
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
      record.add(usersModel.fromDocumentSnapshot(data));
    });
  }

  check(index) {
    return CheckboxListTile(
      onChanged: (bool? value) {
        coordinator[index].check = value;
        update();
      },
      value: coordinator[index].check,
      title: Text(coordinator[index].userName.toString()),
      activeColor: Get.theme.primaryColor,
    );
  }

  Rx<List<usersModel>> _rxCoordinator = Rx<List<usersModel>>([]);
  List<usersModel> get coordinator => _rxCoordinator.value;
  Stream<List<usersModel>> getCoordinator() {
    return userReference
        .where("suID", isEqualTo: "")
        .where("type", isEqualTo: 2)
        .snapshots()
        .map((event) {
      List<usersModel> coordinator = [];
      event.docs.forEach((element) {
        print(element.id);
        coordinator.add(usersModel.fromJson(element));
      });
      return coordinator;
    });
  }

  void addCoordinator(String suId, List<usersModel> coordinator) {
    for (int i = 0; i < coordinator.length; i++) {
      if (coordinator[i].check == true) {
        userReference.doc(coordinator[i].uid).update({"suID": suId});
      }
    }
  }

  void deleteCoordinator(String uid) {
    userReference.doc(uid).update({"suID": ""});
  }
}
