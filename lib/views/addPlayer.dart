import 'package:cae/Global.dart';
import 'package:cae/main.dart';
import 'package:cae/views/actions.dart';
import 'package:cae/views/createPlayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Addplayer extends StatefulWidget {
  const Addplayer({super.key});

  @override
  State<Addplayer> createState() => _AddplayerState();
}

class _AddplayerState extends State<Addplayer> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Global.secondary,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset("lib/assets/logotipo.png", width: 165,)),
            SizedBox(height: 5,),
            Text("Agregar jugadores", style: GoogleFonts.dmSans(color: Global.white, fontSize: 24, fontWeight: FontWeight.bold),),
            SizedBox(height: 40,),
            InkWell(
              onTap: (){
                createPlayer(context);
              },
              child: Container(
                height: 57,
                width: 57,
                decoration: BoxDecoration(
                  color: Global.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(CupertinoIcons.add, color: Global.secondary, size: 30,),
                ),
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 397,
              child: ListView.builder(
                itemCount: controller.Players.length,
                itemBuilder: (context, i){
                  final player = controller.Players[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      height: 86,
                      width: 316,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          color: Global.white
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(player["name"], style: GoogleFonts.dmSans(color: Global.secondary, fontSize: 29, fontWeight: FontWeight.w500),),
                            ),
                          ),
                          Container(
                            height: double.infinity,
                            width: 57,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: player["color"]
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: (){
                                  controller.removePlayer(i);
                                },
                                child: Icon(CupertinoIcons.delete_solid, color: Global.secondary, size: 24,)
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                if(controller.Players.length > 2){
                  Get.to(Addactions());
                }
              },
              child: Container(
                height: 67,
                width: 219,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Global.primary
                ),
                child: Center(
                  child: Text("CONTINUAR", style: TextStyle(color: Global.secondary, fontSize: 28),),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
