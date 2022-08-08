
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'signIn.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset("images/log.png"),
      title: const Text(
        "Merchandiser",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      gradientBackground: LinearGradient(
        colors: [Theme.of(context).accentColor, Theme.of(context).primaryColor],
        begin: const FractionalOffset(0, 0),
        end: const FractionalOffset(1.0, 0.0),
        stops: const [0.0, 1.0],
        tileMode: TileMode.clamp,
      ),
      showLoader: true,
      navigator: LoginPage(),
      durationInSeconds: 1000,
    );
  }
}