import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project101/Controller/Admin/user_controller.dart';
import 'package:project101/View/Account/signIn.dart';
import 'package:project101/View/admin/manage_users.dart';
import 'package:project101/View/admin/report.dart';
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
                padding:const EdgeInsets.only(top: 20,bottom: 20),
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
                        child: const Text("مدير")),
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
                            Get.to(()=>AD_Report());
                          }
                          if(index.isEqual(1)){
                            Get.to(()=>ManageUsers());
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
                  elevation: 10,
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
class Choice {
  const Choice({required this.title, required this.image});
  final String title;
  final AssetImage image;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'التقارير', image:AssetImage("images/report.png")),
  Choice(title: 'إدارة المستخدمين', image: AssetImage("images/user-manager.png")),
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