import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project101/Controller/Admin/user_controller.dart';
import 'package:project101/View/Supervisor/home.dart';

class SignIn extends GetWidget<UserController> {
  SignIn({Key? key}) : super(key: key);

  final form = GlobalKey<FormState>();

  _signIn(name, password) async {
    CollectionReference user =
        FirebaseFirestore.instance.collection("category");
    await user
        .where("username", isEqualTo: name)
        .where("password", isEqualTo: password)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // print(doc.data()!["data"]);

        // if(doc["type"]==0){
        //   print("Admin");
        // }else if(doc["type"]==1){
        //   print("mon");
        // }else if(doc["type"]==2){
        //   print("4");
        // }
      });
    });
  }

  void logincus(context) async {
    // if (form.currentState!.validate()) {
    //
    // }
    //  _signIn("dart", "123456");
    Get.to(() => SU_Home());
  }

  UserController _controller = Get.put(UserController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey.shade200,
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 23.0),
          child: SingleChildScrollView(
            child: Form(
              key: form,
              child: Column(
                children: [
                  const SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: Image(
                        image: AssetImage("images/icon.png"),
                      )),
                  const Padding(
                    padding: EdgeInsets.only(top: 23.0),
                  ),
                  Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1)
                  ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 5.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            controller: controller.username,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person_outline,
                                ),
                                // icon: Icon(Icons.person),
                                contentPadding: const EdgeInsets.all(4),
                                hintText: "إسم المستخدم",
                                filled: true,
                                fillColor: Colors.grey[200],
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade700,
                                        style: BorderStyle.solid,
                                        width: 2)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        style: BorderStyle.solid,
                                        width: 2))),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "ادخل اسم المستخدم";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            obscureText: true,
                            controller: controller.password,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock_outline),
                                // icon: Icon(Icons.person),
                                contentPadding: EdgeInsets.all(4),
                                hintText: " كلمة المرور",
                                filled: true,
                                fillColor: Colors.grey.shade300,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade700,
                                        style: BorderStyle.solid,
                                        width: 2)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        style: BorderStyle.solid,
                                        width: 2))),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "ادخل كلمة المرور";
                              }
                              return null;
                            },
                          ),
                        ),
                        // Container(child: Text(False?"رقم الهاتف غير صحيح":"",style: TextStyle(color: Colors.red,fontFamily: 'Cairo'),),)
                      ],
                    ),
                  ),
                  Obx(()=>Container(
                    // width: 150,
                    // margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                      color:_controller.isLoad.value?Colors.transparent: Colors.white,
                       ),
                    child: _controller.isLoad.value
                        ? const CircularProgressIndicator()
                        : MaterialButton(

                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            'دخول',
                            style: TextStyle(
                                color: Colors.black,
                                // fontSize: 25.0,
                                fontFamily: 'Cairo'),
                          ),
                        ),
                        onPressed: () {
                          form.currentState!.save();
                          if (form.currentState!.validate()) {
                            if(controller.username.text.trim().isNotEmpty){
                              controller.getUsers();
                            }
                          }
                        }),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
