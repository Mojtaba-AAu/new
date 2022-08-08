import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project101/Controller/Admin/user_controller.dart';
import 'package:project101/theme_helper.dart';

import 'header_widget.dart';


// Optional clientId
// clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',




class LoginPage extends GetWidget<UserController> {
    LoginPage({Key? key}) : super(key: key);

  final _headerHeight=250.0;
  final form = GlobalKey<FormState>();
  final UserController _controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight),
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      SizedBox(height: 30.0),
                      Form(
                          key: form,
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  controller: controller.username,
                                  decoration: InputDecoration(
                                    labelText: "اسم المستخدم",
                                    // hintText: hintText,
                                    prefixIcon: Icon(Icons.person_outline),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                  ),
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return "ادخل اسم المستخدم";
                                    }
                                    return null;
                                  },
                                ),
                                // decoration:
                                // ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              const SizedBox(height: 30.0),
                              Container(
                                child: TextFormField(
                                  controller: controller.password,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: "كلمة المرور",
                                    // hintText: hintText,
                                    prefixIcon: Icon(Icons.lock_outline),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                  ),
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return "ادخل كلمة المرور";
                                    }
                                    return null;
                                  },
                                ),
                                // decoration:
                                // ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 25.0),
                              Obx(()=>Container(
                                decoration:
                                ThemeHelper().buttonBoxDecoration(),
                                child:_controller.isLoad.value?CircularProgressIndicator():ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: const Padding(
                                    padding:
                                    EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'دخول',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () async {
                                    form.currentState!.save();
                                    if (form.currentState!.validate()) {
                                      if(controller.username.text.trim().isNotEmpty){
                                        controller.getUsers();
                                      }
                                    }
                                    },
                                ),
                              ))
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
