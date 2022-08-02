import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project101/Controller/Admin/user_controller.dart';
import 'package:project101/theme_helper.dart';

class AddUser extends GetWidget<UserController> {
  @override
  Widget build(BuildContext context) {
    final formKey=GlobalKey<FormState>();
    UserController _controller = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة مستخدم"),
        flexibleSpace: ThemeHelper().appBar(),
      ),body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 20),
          child: Column(
            children: [
              // const SizedBox(height: 20),
              Form(
                 key: formKey,
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          controller: controller.email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: ThemeHelper().textInputDecoration("الإيميل",Icons.email_outlined),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "ادخل ايميل المستخدم";
                            }
                            return null;
                          },
                        ),
                        // decoration:
                        // ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        child: TextFormField(
                          controller: controller.name,
                          decoration: ThemeHelper().textInputDecoration("اسم المستخدم",Icons.person_outline),
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
                      const SizedBox(height: 20.0),
                      Container(
                        child: TextFormField(
                          controller: controller.pass,
                          obscureText: true,
                          decoration: ThemeHelper().textInputDecoration("كلمة المرور",Icons.lock_outline),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "ادخل كلمة المرور";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        child: TextFormField(
                          controller: controller.phone,
                          keyboardType: TextInputType.phone,
                          decoration: ThemeHelper().textInputDecoration("رقم الهاتف",Icons.phone_outlined),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "ادخل رقم الهاتف";
                            }
                            return null;
                          },
                        ),
                      ),

                      Stack(
                        children:[
                          Container(
                            width: double.infinity,
                            height: 140,
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                            padding: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Get.theme.accentColor, width: 1),
                              borderRadius: BorderRadius.circular(5),
                              shape: BoxShape.rectangle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: const[
                                UserTypeButton(value: 1, title: "مشرف"),
                                UserTypeButton(value: 2, title: "منسق"),
                              ],),
                            ),
                          ),
                          Positioned(
                              right: 50,
                              top: 10,
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                                color: Colors.grey.shade100,
                                child: const Text(
                                  'نوع المستخدم',
                                  style: TextStyle(color: Colors.black, fontSize: 12),
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Obx(()=>Container(
                        decoration:
                        ThemeHelper().buttonBoxDecoration(),
                        child:_controller.isLoad.value?CircularProgressIndicator():ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: const Padding(
                            padding:
                            EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: Text(
                              'حفظ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          onPressed: () async {
                            formKey.currentState!.save();
                            if (formKey.currentState!.validate()) {
                                controller.addUser();
                            }
                          },
                        ),
                      ))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
class UserTypeButton extends StatelessWidget {
  final int value;
  final String title;

  const UserTypeButton({

    required this.value,
    required this.title,});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (buttonController) {
        return ListTile(
          leading: Radio(
            value: value,
            groupValue: buttonController.userType,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (int? value){
              buttonController.setUserType(value!);
            },
            activeColor: Get.theme.primaryColor,
          ),
          title: Text(title),
          onTap: ()=>buttonController.setUserType(value),
        );
      },
    );
  }
}
