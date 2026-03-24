import 'package:cae/Global.dart';
import 'package:cae/main.dart';
import 'package:cae/views/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RevealCard extends StatefulWidget {
  final String centerText;
  final String nextPlayerName;
  final Color cardColor;

  const RevealCard({
    super.key,
    required this.centerText,
    required this.nextPlayerName,
    required this.cardColor
  });

  @override
  State<RevealCard> createState() => _RevealCardState();
}

class _RevealCardState extends State<RevealCard> {
  double _offset = 0.0;
  bool _hasSeenVictim = false; // Nueva variable para saber si ya deslizó

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Global.secondary,
      body: Stack(
        children: [
          // --- CAPA 1: EL CONTENIDO OCULTO (CENTRO) ---
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Tu víctima es", style: TextStyle(color: Global.white)),
                Text(
                  widget.centerText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    color: Global.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 350,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          controller.Players[controller.Page]["victim"]["action"]["icon"],
                          color: Global.white,
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            controller.Players[controller.Page]["victim"]["action"]["action"],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(color: Global.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  controller.Players[controller.Page]["victim"]["action"]["description"],
                  style: GoogleFonts.dmSans(color: Global.white.withOpacity(0.8), fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // --- CAPA 2: LA TARJETA (TAPA TODO) ---
          GestureDetector(
            onVerticalDragUpdate: (details) {
              setState(() {
                _offset += details.delta.dy;
                if (_offset > 0) _offset = 0; // Bloqueo para que no baje

                // Si sube más del 20% de la pantalla, marcamos que ya vio la víctima
                if (_offset < -(screenHeight * 0.20)) {
                  _hasSeenVictim = true;
                }
              });
            },
            onVerticalDragEnd: (details) {
              // SIEMPRE REGRESA A TAPAR AL SOLTAR EL DEDO
              setState(() => _offset = 0);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.elasticOut, // Efecto rebote suave
              transform: Matrix4.translationValues(0, _offset, 0),
              width: double.infinity,
              height: double.infinity,
              color: widget.cardColor,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Icon(Icons.person, size: 80, color: Colors.black26),
                    ),

                    Text(
                      "TURNO DE ${controller.Players[controller.Page]["name"].toUpperCase()}",
                      style: GoogleFonts.dmSans(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // --- PARTE INFERIOR DE LA TARJETA ---
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: _hasSeenVictim
                          ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 60),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () {
                          if(widget.nextPlayerName == ""){
                            Get.to(const Game());
                          } else {
                            controller.setPage(controller.Page + 1);
                            setState(() {
                              _offset = 0;
                              _hasSeenVictim = false; // Reset para el siguiente
                            });
                          }
                        },
                        child: Text(widget.nextPlayerName == ""
                            ? "INICIAR JUEGO"
                            : "PASAR CELULAR A ${widget.nextPlayerName}"),
                      )
                          : Column(
                        children: [
                          const Icon(Icons.keyboard_double_arrow_up, color: Colors.black54),
                          Text(
                            "MANTÉN Y SUBE PARA VER",
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}