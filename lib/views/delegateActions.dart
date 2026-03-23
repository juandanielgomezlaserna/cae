import 'package:cae/Global.dart';
import 'package:cae/main.dart';
import 'package:cae/views/Revealcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Delegateactions extends StatefulWidget {
  const Delegateactions({super.key});

  @override
  State<Delegateactions> createState() => _DelegateactionsState();
}

class _DelegateactionsState extends State<Delegateactions> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: RevealCard(
        centerText: controller.Players[controller.Page]["victim"]["name"],
        nextPlayerName: controller.Page == controller.Players.length - 1 ? "" : controller.Players[controller.Page + 1]["name"],
        cardColor: controller.Players[controller.Page]["color"],
      ),
    ));
  }
}
