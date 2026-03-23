import 'package:cae/Global.dart';
import 'package:cae/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void createPlayer (context) {
  final nameController = TextEditingController();
  showDialog(
    context: context,
    builder: (context){
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: 220,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Global.white
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ingresa el nombre del jugador", style: TextStyle(color: Global.secondary), textAlign: TextAlign.center,),
                  SizedBox(height: 10,),
                  TextField(
                    controller: nameController,
                    style: GoogleFonts.dmSans(
                      color: Global.white
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 0, color: Colors.transparent)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 0, color: Colors.transparent)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 0, color: Colors.transparent)
                      ),
                      filled: true,
                      fillColor: Global.secondary.withOpacity(0.8)
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      if(nameController.text != ""){
                        controller.addPlayer(nameController.text);
                        Get.back();
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Global.primary
                      ),
                      child: Center(
                        child: Text("AGREGAR", style: TextStyle(color: Global.white),),
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
