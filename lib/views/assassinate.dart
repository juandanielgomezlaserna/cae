import 'package:cae/Global.dart';
import 'package:cae/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void assassinate (context, player, index) {
  showDialog(
    context: context,
    builder: (context){
      return Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          height: 340,
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 316,
                  height: 310,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    color: Global.primary
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text('${player["name"]}', style: TextStyle(fontSize: 29, height: 1),),
                          Text('Morirá por:', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w500),),
                          SizedBox(height: 20,),
                          Icon(player["action"]["icon"], size: 50, color: Global.secondary,),
                          Text('${player["action"]["action"]}', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w500),),
                          Text('${player["action"]["description"]}', style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
                          SizedBox(height: 20,),
                          InkWell(
                            onTap: (){
                              controller.assassinatePlayer(index);
                              Get.back();
                            },
                            child: Container(
                              height: 52,
                              width: 135,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Global.secondary
                              ),
                              child: Center(
                                child: Text("ASESINAR", style: TextStyle(color: Global.white, fontSize: 19, fontWeight: FontWeight.bold),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.topRight,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(37),
                    onTap: (){
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 37,
                        width: 37,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Global.white,
                        ),
                        child: Icon(CupertinoIcons.xmark, color: Global.secondary,),
                      ),
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      );
    }
  );
}