import 'package:animate_do/animate_do.dart';
import 'package:cae/Global.dart';
import 'package:cae/controllers/MyController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main (){
  Get.put(MyController());
  runApp(GetMaterialApp(
    title: "Cae",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: "caefont",
    ),
    home: Splash(),
  ));
}

MyController controller = Get.find();

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.secondary,
      body: Center(
        child: FadeIn(
          child: Image.asset("lib/assets/caelogo.png", width: 156,)
        ),
      ),
    );
  }
}
