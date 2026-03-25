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
  final initialData = [].obs;

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
      "isDead" : false
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
    List originalPlayers = List.from(players.value);
    List victimList = List.from(players.value);

    bool hasSelfVictim = true;

    // Re-barajamos hasta que nadie sea su propia víctima
    while (hasSelfVictim) {
      victimList.shuffle();
      hasSelfVictim = false;

      for (int i = 0; i < originalPlayers.length; i++) {
        if (originalPlayers[i]["name"] == victimList[i]["name"]) {
          hasSelfVictim = true;
          break;
        }
      }
    }

    // Una vez que tenemos una lista válida, asignamos
    for (int i = 0; i < players.value.length; i++) {
      players.value[i]["victim"] = {
        "name": victimList[i]["name"],
        "action": victimList[i]["action"], // Asegúrate de que las acciones ya existan
      };
    }

    players.refresh();
  }

  void assassinatePlayer(int index) {
    final deadPlayer = players.value[index];
    deadPlayer["isDead"] = true;

    // Buscamos al asesino de forma segura
    final assassin = players.value.firstWhere(
          (item) => item["victim"] != null && item["victim"]["name"] == deadPlayer["name"],
      orElse: () => {},
    );

    if (assassin != null) {
      // EL ASESINO HEREDA LA VÍCTIMA DEL MUERTO
      assassin["victim"] = deadPlayer["victim"];
      // El muerto ya no tiene víctima (para evitar bucles)
      deadPlayer["victim"] = null;
    }

    players.refresh();
  }

  void resucitatePlayer(int index) {
    players.value[index]["isDead"] = false;
    players.refresh();
  }

  void resetGame () {
    for (int i = 0; i < players.value.length; i++) {
      final player = players.value[i];
      players.value[i] = {
        "name" : player["name"],
        "color" : player["color"],
        "isDead" : false
      };
    }

    players.refresh();
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