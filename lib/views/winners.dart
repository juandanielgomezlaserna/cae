import 'package:cae/Global.dart';
import 'package:cae/main.dart';
import 'package:cae/views/addPlayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void showWinners (context) {
  final playersWinners = controller.Players.where((item) => !item["isDead"]).toList();
  final player1 = playersWinners[0];
  final player2 = playersWinners[1];
  showDialog(
    context: context,
    builder: (context){
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Global.primary
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('EL JUEGO HA FINALIZADO', style: TextStyle(fontSize: 29, height: 1), textAlign: TextAlign.center,),
                  Text('Ganadores:', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w500),),
                  SizedBox(height: 20,),
                  Icon(Icons.emoji_events, size: 50, color: Global.secondary,),
                  Text('${player1["name"]} & ${player2["name"]}', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w500),),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      controller.resetGame();
                      Get.off(Addplayer());
                    },
                    child: Container(
                      height: 52,
                      width: 135,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Global.secondary
                      ),
                      child: Center(
                        child: Text("REINICIAR", style: TextStyle(color: Global.white, fontSize: 19, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  );
}