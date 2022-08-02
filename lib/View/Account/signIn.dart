import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project101/View/Account/login.dart';

import '../admin/drop.dart';
import 'g.dart';


class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState(){

     Timer(const Duration(milliseconds: 2000), (){
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
      });
    });

     Timer(
        Duration(milliseconds: 10),(){
      setState(() {
        _isVisible = true; // Now it is showing fade effect and navigating to Login page
      });
    }
    );

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration:  BoxDecoration(
        gradient:  LinearGradient(
          colors: [Theme.of(context).accentColor, Theme.of(context).primaryColor],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 250.0,
            width: 250.0,
            child: Center(
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset("images/log.png",width: 200,height: 200,), //put your logo here
                  ),
                  const Text("Merchandiser",style: TextStyle(fontSize: 24),)
                ],
              ),
            ),
            // decoration: BoxDecoration(
            //     shape: BoxShape.rectangle,
            //    // color: Colors.white,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.3),
            //         blurRadius: 2.0,
            //         offset: Offset(5.0, 3.0),
            //         spreadRadius: 2.0,
            //       )
            //     ]
            // ),
          ),
        ),
      ),
    );
  }
}