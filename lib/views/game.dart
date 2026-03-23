import 'package:cae/Global.dart';
import 'package:cae/main.dart';
import 'package:cae/views/assassinate.dart';
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
                height: MediaQuery.of(context).size.height > 700 ? 397 : MediaQuery.of(context).size.height * 0.4,
                child: SizedBox(
                  height: 397, // Aumenté un poco el alto para que se vean bien las filas
                  width: double.infinity,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Calculamos el ratio para que la altura sea SIEMPRE 110 (puedes cambiar este número)
                      double itemHeight = 110;
                      double itemWidth = (constraints.maxWidth - 10) / 2; // (Ancho total - spacing) / 2 columnas
                      double fixedRatio = itemWidth / itemHeight;

                      return GridView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: controller.Players.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: fixedRatio, // Aplicamos el ratio calculado
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
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: Stack( // Stack es mejor para altura fija
                              children: [
                                // Texto del Jugador
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                                  child: Text(
                                    player['name'],
                                    style: GoogleFonts.dmSans(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                // Calavera posicionada abajo a la derecha
                                Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(50),
                                      onTap: () => assassinate(context, player),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          "lib/assets/iconskull.png",
                                          width: 40, // Tamaño fijo para la calavera
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
