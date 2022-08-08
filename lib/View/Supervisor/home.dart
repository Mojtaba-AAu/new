import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project101/Controller/Admin/user_controller.dart';
import 'package:project101/View/Account/signIn.dart';
import 'package:project101/View/Supervisor/product_manager.dart';
import 'package:project101/View/Supervisor/reports.dart';
import 'package:project101/View/Supervisor/store_manager.dart';
import 'package:project101/View/Supervisor/user_manager.dart';


class SuHome extends GetWidget<UserController> {
  SuHome({Key? key}) : super(key: key);
  final String email="";
  final String mobile="";
  final user=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الرئيسية"),),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:const EdgeInsets.only(top: 20),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    trailing: Container(
                      padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black54,width: 2,style: BorderStyle.solid)
                        ),
                        child: const Text("مشرف")),
                    leading: Image.asset("images/profile.png",width: 50,height: 50,),
                    title: Text(controller.UsersModel!.userName.toString()),
                    onTap: (){

                    },
                  ),
                ),
              ),
              SizedBox(
                child: GridView.count(
                  shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 8.0,
                    children: List.generate(choices.length, (index) {
                      return Center(
                        child: InkWell(child: SelectCard(choice: choices[index]),onTap: (){
                          if(index.isEqual(0)){
                            Get.to(()=>SuReports());
                          }
                          if(index.isEqual(1)){
                            Get.to(()=>UserManager());
                          }
                          if(index.isEqual(2)){
                            Get.to(()=>ProductManager());
                          }
                          if(index.isEqual(3)){
                            Get.to(()=>StoreManager());
                          }
                        },),
                      );
                    }
                    )
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

class Choice {
  const Choice({required this.title, required this.image});
  final String title;
  final AssetImage image;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'التقارير', image:AssetImage("images/report.png")),
  Choice(title: 'إدارة المستخدمين', image: AssetImage("images/user-manager.png")),
  Choice(title: 'إدارة المنتجات', image: AssetImage("images/box.png")),
  Choice(title: 'المتاجر والعلامات التجارية', image: AssetImage("images/storeAdmin.png")),
];

class SelectCard extends StatelessWidget {
   const SelectCard({Key? key, required this.choice}) : super(key: key);
   final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Card(
elevation: 5,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Image(image: choice.image,width: 100,height: 100,)),
              Center(child: Text(choice.title,style: const TextStyle(fontWeight: FontWeight.w400),)),
            ]
        ),
        )
    );
  }
}