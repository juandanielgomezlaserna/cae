import 'package:cae/Global.dart';
import 'package:cae/main.dart';
import 'package:cae/views/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RevealCard extends StatefulWidget {
  final String centerText;     // El rol (ej: "ASESINO")
  final String nextPlayerName; // El nombre del siguiente turno
  final Color cardColor;

  const RevealCard({
    super.key,
    required this.centerText,
    required this.nextPlayerName,
    required this.cardColor // Color por defecto
  });

  @override
  State<RevealCard> createState() => _RevealCardState();
}

class _RevealCardState extends State<RevealCard> {
  double _offset = 0.0;
  bool _isRevealed = false;

  @override
  Widget build(BuildContext context) {
    // Obtenemos el alto total de la pantalla para el límite del scroll
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Global.secondary, // Fondo profundo para que el centro resalte
      body: Stack(
        children: [
          // --- CAPA 1: EL CONTENIDO OCULTO (CENTRO) ---
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Tu víctima es", style: TextStyle(color: Global.white),),
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
                Center(
                  child: Container(
                    width: 350,
                    // Un poco de padding para que el texto no toque los bordes del SizedBox
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido horizontalmente
                      crossAxisAlignment: CrossAxisAlignment.center, // Centra el icono con el texto verticalmente
                      mainAxisSize: MainAxisSize.min, // El Row solo ocupa el espacio de sus hijos
                      children: [
                        Icon(
                          controller.Players[controller.Page]["victim"]["action"]["icon"],
                          color: Global.white,
                        ),
                        SizedBox(width: 12), // Espacio entre icono y texto
                        Flexible(
                          child: Text(
                            controller.Players[controller.Page]["victim"]["action"]["action"],
                            textAlign: TextAlign.center, // Centra las líneas de texto entre sí
                            style: GoogleFonts.dmSans(
                              color: Global.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  controller.Players[controller.Page]["victim"]["action"]["description"],
                  style: GoogleFonts.dmSans(color: Global.white.withOpacity(0.8), fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // --- CAPA 2: LA TARJETA DESLIZABLE ---
          GestureDetector(
            onVerticalDragUpdate: (details) {
              setState(() {
                // Solo permitimos deslizar hacia ARRIBA (valores negativos)
                _offset += details.delta.dy;
                // Evitamos que baje más de la posición inicial
                if (_offset > 0) _offset = 0;
              });
            },
            onVerticalDragEnd: (details) {
              // Si deslizó más del 30% de la pantalla, se considera "Revelado"
              if (_offset < -(screenHeight * 0.3)) {
                setState(() {
                  _offset = -screenHeight * 0.8; // Se desplaza casi fuera
                  _isRevealed = true;
                });
              } else {
                // Si no, regresa al inicio
                setState(() => _offset = 0);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              transform: Matrix4.translationValues(0, _offset, 0),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: widget.cardColor,
                borderRadius: _isRevealed
                    ? const BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))
                    : BorderRadius.zero,
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Icon(Icons.person, size: 80, color: Colors.black26),
                    ),

                    // Texto Central de la tapa (Instrucción)
                    Text(
                      "TURNO DE ${controller.Players[controller.Page]["name"].toUpperCase()}",
                      style: GoogleFonts.dmSans(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // --- PARTE INFERIOR DINÁMICA ---
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: _isRevealed
                          ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 60),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () {
                          if(widget.nextPlayerName == ""){
                            Get.to(Game());
                          }else{
                            controller.setPage(controller.Page + 1);
                            _isRevealed = false;
                          }
                        },
                        child: Text(widget.nextPlayerName == "" ? "Iniciar juego" : "PASAR CELULAR A ${widget.nextPlayerName.toUpperCase()}"),
                      )
                          : Column(
                        children: [
                          const Icon(Icons.keyboard_double_arrow_up, color: Colors.black54),
                          Text(
                            "DESLIZA HACIA ARRIBA",
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