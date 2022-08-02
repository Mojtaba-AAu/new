import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:project101/View/Account/login.dart';
import 'package:project101/helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'View/Account/signIn.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _primaryColor = HexColor('#DC54FE');
    Color _accentColor = HexColor('#5AD3BC');

    // Design color
    // Color _primaryColor= HexColor('#FFC867');
    // Color _accentColor= HexColor('#FF3CBD');

    // Our Logo Color
    // Color _primaryColor= HexColor('#D44CF6');
    // Color _accentColor= HexColor('#5E18C8');

    // Our Logo Blue Color
    //Color _primaryColor= HexColor('#651BD2');
    //Color _accentColor= HexColor('#320181');
    return GetMaterialApp(
      initialBinding: Binding(),
      title: "إدارة المبيعات",
      theme: ThemeData(
          primaryColor: _primaryColor,
          accentColor: _accentColor,
          scaffoldBackgroundColor: Colors.grey.shade100,
          primarySwatch: Colors.blueGrey,
          fontFamily: 'Cairo'
      ),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      home:SplashScreen(title: 'إدرة الرفوف',),);
  }
}
