import 'dart:async';
import 'dart:math';

import 'package:cae/Global.dart';
import 'package:cae/views/addPlayer.dart';
import 'package:get/get.dart';

class MyController extends GetxController{
  Timer? timer;
  final players = [].obs;
  final colors = List.from(Global.colors).obs;
  final page = 0.obs;

  void setSplash () {
    timer?.cancel();
    int seconds = 2;
    timer = Timer.periodic(Duration(seconds: 1), (timer){
      if(seconds > 0){
        seconds--;
      }else{
        Get.off(Addplayer());
        timer.cancel();
      }
    });
  }

  void addPlayer (String name) {
    final color = colors.value.first;
    colors.value.removeAt(0);
    if(colors.value.length == 0){
      colors.value = List.from(Global.colors);
    }
    players.value.add({
      "name" : name,
      "color" : color,
    });
    players.refresh();
  }

  void removePlayer (int index) {
    players.value.removeAt(index);
    players.refresh();
    print(players.value);
  }

  void setPage (int item) {
    page.value = item;
  }

  void delegateVictims() {
    // 1. Creamos una copia de la lista original
    List listForVictims = List.from(players.value);

    // 2. Barajamos la lista de víctimas aleatoriamente
    listForVictims.shuffle();

    for (int i = 0; i < players.value.length; i++) {
      var currentPlayer = players.value[i];

      // 3. Buscamos una víctima que no sea el mismo jugador
      // Si el primer elemento de la lista de víctimas es el mismo jugador,
      // tomamos el último de la lista (o el siguiente).
      int victimIndex = 0;
      if (listForVictims[victimIndex]["name"] == currentPlayer["name"]) {
        victimIndex = listForVictims.length - 1;
      }

      var victim = listForVictims[victimIndex];

      // 4. Asignamos la víctima
      currentPlayer["victim"] = {
        "name": victim["name"],
        "action": victim["action"],
      };

      // 5. Removemos a esa víctima de la lista para que no se repita
      listForVictims.removeAt(victimIndex);
    }
  }

  List get Players => players.value;
  int get Page => page.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setSplash();
  }
}