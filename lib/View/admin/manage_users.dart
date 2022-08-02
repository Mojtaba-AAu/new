import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project101/View/admin/add_user.dart';
import 'package:project101/theme_helper.dart';

import '../../Controller/Admin/user_controller.dart';
import '../../Model/users.dart';

class ManageUsers extends GetWidget<UserController> {
  ManageUsers({Key? key}) : super(key: key);
  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("إدارة المستخدمين"),
          flexibleSpace: ThemeHelper().appBar(),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => (userController != null &&
                      userController.getUser.isNotEmpty)
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: userController.getUser.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 10,
                              child: Container(
                                child: ExpansionTile(
                                  backgroundColor: Colors.blueGrey.shade50,
                                  leading:
                                      Icon(Icons.perm_contact_cal_outlined),
                                  textColor: Colors.cyan.shade700,
                                  iconColor: Colors.cyan.shade700,
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        title: Text(userController
                                            .getUser[index].userName
                                            .toString()),
                                        // leading: Icon(Icons.manage_accounts),
                                      )
                                    ],
                                  ),
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 170,
                                      margin: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(5),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: Get.width,
                                              child: const Text(
                                                'نوع المستخدم',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            UserTypeButton(
                                              value: 1,
                                              type: userController
                                                  .getUser[index].type!
                                                  .toInt(),
                                              title: "مشرف",
                                              uid: userController
                                                  .getUser[index].uid
                                                  .toString(),
                                            ),
                                            UserTypeButton(
                                              value: 2,
                                              type: userController
                                                  .getUser[index].type!
                                                  .toInt(),
                                              title: "منسق",
                                              uid: userController
                                                  .getUser[index].uid
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    userController.buildBody(userController
                                        .getUser[index].uid
                                        .toString()),
                                    const SizedBox(height: 10,),
                                    Container(
                                      decoration:ThemeHelper().buttonBoxDecoration(),
                                      child: ElevatedButton(
                                        style:ThemeHelper().buttonStyle(),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 40.0),
                                            child: Text(
                                              'تعيين منسقين',
                                              style: TextStyle(
                                                  // color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                  fontFamily: 'Cairo'),
                                            ),
                                          ),
                                          onPressed: userController
                                                      .getUser[index].type ==
                                                  1
                                              ? () {
                                                  addCoordinator(userController
                                                      .coordinator,userController.getUser[index].uid.toString());
                                                }
                                              : null),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }))
                  : const Text("Loading....."))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Get.to(
            () => AddUser(),
          ),
        ));
  }

  void addCoordinator(List coordinator,String suID) {
    Get.bottomSheet(
      SizedBox(
        height: Get.height/2,
          child: GetBuilder<UserController>(
              init: UserController(),
              builder: (userController) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: userController.coordinator.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          return Container(  margin: const EdgeInsets.fromLTRB(20,0,20,10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey, width: 1),
                              shape: BoxShape.rectangle,
                            ),
                            child: userController.check(index),);
                        }),
                  ),
                  Container(
                    decoration: ThemeHelper().buttonBoxDecoration(),
                    child: ElevatedButton(
                      style: ThemeHelper().buttonStyle(),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 40.0),
                          child: Text(
                            'تعيين',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                fontFamily: 'Cairo'),
                          ),
                        ),
                        onPressed: () {
                          userController.addCoordinator(suID, userController.coordinator);
                          Get.back();
                        }),
                  ),
                ],
              ))),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
    );
  }
}

class UserTypeButton extends StatelessWidget {
  final int value;
  final int type;
  final String title;
  final String uid;

  const UserTypeButton({
    required this.value,
    required this.type,
    required this.title,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (buttonController) {
        return ListTile(
          leading: Radio(
            value: value,
            groupValue: type,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (int? value) {
              buttonController.setUserType(value!);
            },
            activeColor: Get.theme.primaryColor,
          ),
          title: Text(title),
          onTap: () => buttonController.editUserType(uid, value),
        );
      },
    );
  }
}
