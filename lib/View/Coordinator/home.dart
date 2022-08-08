import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project101/Controller/Admin/user_controller.dart';
import 'package:project101/View/Account/signIn.dart';
import 'package:project101/theme_helper.dart';

class CoorHome extends GetWidget<UserController> {
  const CoorHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("الرئيسية"), flexibleSpace: ThemeHelper().appBar()),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Card(
                    color: Colors.blue[200],
                    shadowColor: Colors.amber,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20)),
                    ),
                    child: ListTile(
                      title: Text("الاسم"),
                      subtitle: Text(controller.UsersModel!.userName!),
                      onTap: () {},
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/bg.jpg"), fit: BoxFit.fill),
                  ),
                  child: ListTile(
                    title: Text("التقارير"),
                    subtitle: Text("إضغط هنا لإدرة التقارير واستعراضها"),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Card(
                    color: Colors.blue[200],
                    shadowColor: Colors.amber,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20)),
                    ),
                    child: ListTile(
                      title: const Text("إدارة المستخدمين"),
                      subtitle: const Text("إضغط هنا لإدارة الموظفين"),
                      onTap: () {},
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Card(
                    elevation: 5,
                    child: MaterialButton(
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 40.0),
                          child: Text(
                            'تسجيل الخروج',
                            style: TextStyle(
                                color: Colors.black,
                                // fontSize: 25.0,
                                fontFamily: 'Cairo'),
                          ),
                        ),
                        onPressed: () {
                          controller.dataStore.remove("user");
                          Get.offAll(() => LoginPage());                        }),
                  ),
                )
              ],
            ),
            Text("data")
          ],
        ),
      ),
    );
  }
}
