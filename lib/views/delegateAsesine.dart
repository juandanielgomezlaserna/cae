import 'package:cae/Global.dart';
import 'package:cae/main.dart';
import 'package:cae/views/winners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void delegateAsesine (context, player) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent, // Fondo transparente para que la X sobresalga
        insetPadding: const EdgeInsets.symmetric(horizontal: 20), // Margen lateral en pantallas pequeñas
        child: Stack(
          clipBehavior: Clip.none, // <--- CLAVE: Permite que la X se salga del contenedor
          alignment: Alignment.center,
          children: [
            // --- CONTENEDOR PRINCIPAL (Altura dinámica) ---
            Container(
              width: 316,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                color: Global.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // <--- CLAVE: El modal solo mide lo que miden sus hijos
                  children: [
                    Text('${player["name"]}', style: const TextStyle(fontSize: 29, height: 1)),
                    Text('Ahora su victima es:', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w500)),
                    Text(
                      '${player['victim']['name']}',
                      style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    Text('Morirá por:', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w500)),
                    Icon(player["victim"]["action"]["icon"], size: 50, color: Global.secondary),
                    Text('${player['victim']["action"]["action"]}', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w500)),
                    Text(
                      '${player["action"]["description"]}',
                      style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // --- BOTÓN DE CERRAR (X) ---
            Positioned(
              top: -10, // <--- Ajusta esto para que sobresalga más o menos
              right: -10, // <--- Ajusta esto para que sobresalga lateralmente
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  height: 37,
                  width: 37,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Global.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Icon(CupertinoIcons.xmark, color: Global.secondary, size: 20),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}