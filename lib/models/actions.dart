import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> actionsData = [
  // --- FRASES (Lograr que la víctima diga...) ---
  {"action": "¿Qué hora tienes?", "icon": Icons.watch_later_outlined, "description": "La víctima debe mencionar la hora actual o consultar un reloj."},
  {"action": "No me acuerdo", "icon": Icons.question_mark_rounded, "description": "La víctima debe admitir que ha olvidado un dato o información."},
  {"action": "Pásame eso", "icon": CupertinoIcons.hand_raised_fill, "description": "La víctima debe pedir que le pasen un objeto."},
  {"action": "Tengo hambre", "icon": Icons.restaurant, "description": "La víctima debe expresar su deseo de comer o apetito."},
  {"action": "¡Qué calor! / ¡Qué frío!", "icon": Icons.thermostat, "description": "La víctima debe quejarse o mencionar la temperatura ambiental."},
  {"action": "¿En serio?", "icon": Icons.priority_high, "description": "La víctima debe mostrar incredulidad o sorpresa ante un comentario."},
  {"action": "Salud", "icon": Icons.clean_hands, "description": "La víctima debe responder cortésmente tras un estornudo."},
  {"action": "Mañana", "icon": Icons.calendar_today, "description": "La víctima debe referirse específicamente al día siguiente."},
  {"action": "Depende", "icon": Icons.balance, "description": "La víctima debe dar una respuesta condicionada en lugar de un sí o no."},
  {"action": "Yo también", "icon": Icons.person_add_alt_1, "description": "La víctima debe coincidir con una opinión o gusto personal."},
  {"action": "¿Dónde está...?", "icon": Icons.search, "description": "La víctima debe preguntar por la ubicación de un objeto o persona."},
  {"action": "Está rico", "icon": Icons.thumb_up_alt_outlined, "description": "La víctima debe elogiar el sabor de algo que esté consumiendo."},
  {"action": "No sé", "icon": Icons.quiz_outlined, "description": "La víctima debe declarar su desconocimiento sobre un tema."},
  {"action": "¡Mira!", "icon": Icons.visibility, "description": "La víctima debe intentar llamar la atención de alguien hacia algo visual."},
  {"action": "Espera", "icon": Icons.front_hand_outlined, "description": "La víctima debe pedir una pausa o tiempo antes de continuar."},

  // --- ACCIONES (Lograr que la víctima haga...) ---
  {"action": "Mirar el techo", "icon": Icons.arrow_upward, "description": "La víctima debe inclinar la cabeza hacia arriba para observar el cielo raso."},
  {"action": "Darte la mano", "icon": Icons.handshake, "description": "La víctima debe realizar un contacto físico de saludo o acuerdo con su mano."},
  {"action": "Sostenerte algo", "icon": Icons.back_hand, "description": "La víctima debe recibir y mantener un objeto tuyo temporalmente."},
  {"action": "Sentarse en una silla", "icon": Icons.chair_alt, "description": "La víctima debe ocupar el lugar o asiento que tú elijas."},
  {"action": "Reírse", "icon": Icons.sentiment_very_satisfied, "description": "La víctima debe soltar una carcajada o risa genuina."},
  {"action": "Brindar", "icon": Icons.wine_bar, "description": "La víctima debe chocar su recipiente de bebida con el tuyo."},
  {"action": "Desbloquear su teléfono", "icon": Icons.phonelink_lock, "description": "La víctima debe introducir su clave o usar biometría para abrir su móvil."},
  {"action": "Señalar algo", "icon": Icons.ads_click, "description": "La víctima debe extender el dedo para indicar la posición de un objeto."},
  {"action": "Cantar o tararear", "icon": Icons.music_note, "description": "La víctima debe emitir sonidos musicales o seguir la letra de una canción."},
  {"action": "Pasarte algo", "icon": Icons.keyboard_return, "description": "La víctima debe entregarte un objeto que está fuera de tu alcance (sal, azúcar, etc)."},
  {"action": "Quitarse algo", "icon": Icons.checkroom, "description": "La víctima debe desprenderse de una prenda de ropa o calzado."},
  {"action": "Abrir una puerta", "icon": Icons.door_front_door, "description": "La víctima debe accionar el pomo o manija para permitir el paso."},
  {"action": "Mirar una foto", "icon": Icons.image_outlined, "description": "La víctima debe fijar su vista en una imagen que le estás mostrando."},
  {"action": "Chocar los cinco", "icon": Icons.pan_tool_alt, "description": "La víctima debe palmear tu mano levantada en señal de celebración."},
  {"action": "Escribir algo", "icon": Icons.edit_note, "description": "La víctima debe plasmar texto o números sobre un papel o dispositivo digital."},
];