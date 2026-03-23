import 'package:cae/Global.dart';
import 'package:cae/main.dart';
import 'package:cae/models/actions.dart';
import 'package:cae/views/createAction.dart';
import 'package:cae/views/delegateActions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Addactions extends StatefulWidget {
  const Addactions({super.key});

  @override
  State<Addactions> createState() => _AddactionsState();
}

class _AddactionsState extends State<Addactions> {
  int page = 0;
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
            Center(child: Text("Causa de muerte", style: GoogleFonts.dmSans(color: Global.white, fontSize: 24, fontWeight: FontWeight.bold))),
            SizedBox(height: 10,),
            Container(
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
                      child: Text(controller.Players[page]["name"], style: GoogleFonts.dmSans(color: Global.secondary, fontSize: 29, fontWeight: FontWeight.w500),),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      createAction(context, page);
                    },
                    child: Container(
                      height: double.infinity,
                      width: 57,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          color: controller.Players[page]["color"]
                      ),
                      child: Center(
                        child: Icon(CupertinoIcons.add, color: Colors.black,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
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
                    itemCount: actionsData.length,
                    // Configuración de la cuadrícula
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,          // 2 columnas
                      crossAxisSpacing: 10,       // Espacio horizontal entre tarjetas
                      mainAxisSpacing: 10,        // Espacio vertical entre tarjetas
                      childAspectRatio: 1,        // Esto las hace perfectamente CUADRADAS
                    ),
                    itemBuilder: (context, i) {
                      final action = actionsData[i];
                      final Color playerColor = controller.Players[page]["color"];

                      return InkWell(
                        onTap: (){
                          controller.players.value[page]["action"] = action;
                          controller.players.refresh();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            color: controller.Players[page]["action"] == null ?
                            playerColor.withOpacity(0.9) :
                            controller.Players[page]["action"]["action"]  == action["action"]
                                ? Global.primary.withOpacity(0.9) :
                            playerColor.withOpacity(0.9), // Un poco de transparencia queda mejor en Grid
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: i % 2 == 0 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                            children: [
                              // Icono en la parte superior
                              Icon(action["icon"], color: Colors.black, size: 28),

                              // Espacio flexible para el texto para que NUNCA se desborde
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: i % 2 == 0 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      action["action"],
                                      style: GoogleFonts.dmSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis, // Si es muy largo pone "..."
                                      textAlign: i % 2 == 0 ? TextAlign.left : TextAlign.right,
                                    ),
                                    const SizedBox(height: 4),
                                    if (action["description"] != "")
                                      Flexible(
                                        child: Text(
                                          action["description"],
                                          style: GoogleFonts.dmSans(
                                              color: Colors.black54,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600
                                          ),
                                          maxLines: 3, // Límite para la descripción
                                          overflow: TextOverflow.visible, // Permite que se vea lo más posible
                                          textAlign: i % 2 == 0 ? TextAlign.left : TextAlign.right,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                    if(page > 0){
                      setState(() {
                        page--;
                      });
                    }
                  },
                  child: Container(
                    height: 67,
                    width: 67,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Global.primary
                    ),
                    child: Center(
                      child: Icon(CupertinoIcons.back, color: Global.secondary,),
                    ),
                  ),
                ),
                Icon(Icons.person, color: Global.primary, size: 67,),
                InkWell(
                  onTap: (){
                    if(page < controller.Players.length - 1 && controller.Players[page]["action"] != null){
                      setState(() {
                        page++;
                      });
                    }else{
                      controller.delegateVictims();
                      controller.setPage(0);
                      Get.to(Delegateactions());
                    }
                  },
                  child: Container(
                    height: 67,
                    width: page == controller.Players.length - 1 ? 150 : 67,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Global.primary
                    ),
                    child: Center(
                      child: page == controller.Players.length - 1 ? Text("CONTINUAR", style: TextStyle(color: Global.secondary, fontSize: 18),) : Icon(Icons.navigate_next, color: Global.secondary,),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
