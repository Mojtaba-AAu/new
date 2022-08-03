import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project101/Controller/Admin/user_controller.dart';
import 'package:project101/View/Account/g.dart';
import 'package:project101/View/admin/manage_users.dart';
import 'package:project101/View/admin/report.dart';
import 'package:project101/View/admin/test.dart';
import 'package:project101/theme_helper.dart';

class AD_Home extends GetWidget<UserController>{
   AD_Home({Key? key}) : super(key: key);
   final user=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الرئيسية"), flexibleSpace: ThemeHelper().appBar()),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:const EdgeInsets.only(top: 20),
                child: Card(
                  elevation: 5,
                  color: Colors.blue.shade200,
                  child: ListTile(
                    title: Text("الاسم"),
                    subtitle: Text(controller.UsersModel!.userName.toString()),
                    onTap: (){
                      Get.to(()=>IconButtonBugView());
                    },
                  ),
                ),
              ),
              Padding(
                padding:const EdgeInsets.only(top: 20),
                child: Card(
                  elevation: 5,
                  color: Colors.blue.shade200,
                  child: ListTile(
                    title: Text("التقارير"),
                    subtitle: Text("إضغط هنا لإدرة التقارير واستعراضها"),
                    onTap: (){
                      Get.to(()=>AD_Report());
                    },
                  ),
                ),
              ),
              Padding(
                padding:const EdgeInsets.only(top: 20),
                child: Card(
                  elevation: 5,
                  color: Colors.blue.shade200,
                  child: ListTile(
                    title: const Text("إدارة المستخدمين"),
                    subtitle: const Text("إضغط هنا لإدارة الموظفين"),
                    onTap: (){
                      Get.to(()=>ManageUsers());
                    },
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
                      onPressed: (){
                        controller.dataStore.remove("user");
                        Get.offAll(() => LoginPage());
                      }
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// _editUser(email,mobile,user){
//   return Form(
//     key: user,
//     child: Column(
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.only(
//               top: 20.0,
//               bottom: 5.0,
//               left: 25.0,
//               right: 25.0),
//           child: TextFormField(
//             // controller: email,
//             decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.person,),
//                 // icon: Icon(Icons.person),
//                 contentPadding: const EdgeInsets.all(4),
//                 hintText: "إسم المستخدم",
//                 filled: true,
//                 fillColor: Colors.grey[200],
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Colors.grey.shade700,
//                         style: BorderStyle.solid,
//                         width: 2)),
//                 focusedBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Colors.blue,
//                         style: BorderStyle.solid,
//                         width: 2))),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return "ادخل اسم المستخدم";
//               }
//               return null;
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(
//               top: 20.0,
//               bottom: 50.0,
//               left: 25.0,
//               right: 25.0),
//           child: TextFormField(
//             // controller: mobile,
//             obscureText: true,
//             decoration:  InputDecoration(
//                 prefixIcon: const Icon(Icons.password),
//                 // icon: Icon(Icons.person),
//                 contentPadding: EdgeInsets.all(4),
//                 hintText: " كلمة المرور",
//                 filled: true,
//                 fillColor: Colors.grey.shade300,
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Colors.grey.shade700,
//                         style: BorderStyle.solid,
//                         width: 2)),
//                 focusedBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Colors.blue,
//                         style: BorderStyle.solid,
//                         width: 2))),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return "ادخل كلمة المرور";
//               }
//               return null;
//             },
//           ),
//         ),
//         // Container(child: Text(False?"رقم الهاتف غير صحيح":"",style: TextStyle(color: Colors.red,fontFamily: 'Cairo'),),)
//       ],
//     ),
//   );
// }