import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire/game_interface/interface_component.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

import '../overworld/player.dart';

class ExpInfo extends InterfaceComponent {
  double exp = 0;
  double neededExp = 0;
  int currentLvl = 1;
  int enemiesLeft = 0;

  ExpInfo() : super(
      id: 3,
      position: Vector2(0, 0),
      size: Vector2(450, 720)
  );

  @override
  void update(double dt) {
    var player = gameRef.player as MainPlayer;
    exp = player.currentExp;
    neededExp = player.expNeeded;
    currentLvl = player.currentLvl;
    enemiesLeft = gameRef.enemies().length;
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    var style = const TextStyle(color: Colors.yellow, fontSize: 30);
    TextPaint(style: style).render(c, "LV: $currentLvl | XP: $exp | LV UP AT: $neededExp | ENEMIES: $enemiesLeft ", Vector2(220, 0));
  }
}