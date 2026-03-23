import 'package:cae/Global.dart';
import 'package:cae/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.secondary,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset("lib/assets/logotipo.png", width: 165,)),
            SizedBox(height: 5,),
            Text("Juego", style: GoogleFonts.dmSans(color: Global.white, fontSize: 24, fontWeight: FontWeight.bold),),
            SizedBox(height: 40,),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,           // Arriba: totalmente visible
                    Colors.white,           // Se mantiene visible la mayor parte
                    Colors.transparent,     // Al final: se desvanece a transparente
                  ],
                  stops: [0.0, 0.85, 1.0],  // El desvanecimiento empieza al 85% de la altura
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,   // Esta es la clave para que use la transparencia del gradiente
              child: SizedBox(
                height: 397,
                child: SizedBox(
                  height: 397, // Aumenté un poco el alto para que se vean bien las filas
                  width: double.infinity,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: controller.Players.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      // --- CAMBIO CLAVE: Al subir de 1.0 a 1.6, se vuelven rectangulares (menos altas) ---
                      childAspectRatio: 1.6,
                    ),
                    itemBuilder: (context, i) {
                      final player = controller.Players[i];
                      final Color playerColor = player["color"];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          color: playerColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Column( // Usamos Stack para posicionar la calavera libremente
                          children: [
                            // Contenido del texto
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    player['name'],
                                    style: GoogleFonts.dmSans(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),

                            // Icono de Calavera con InkWell
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  print("Eliminar o acción de calavera para: ${player['name']}");
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Image.asset("lib/assets/iconskull.png", width: 45,)
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
