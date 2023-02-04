import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/equipment/base_equipment.dart';

import '../equipment/base_item.dart';
import '../overworld/player.dart';

class EquipmentInfo extends InterfaceComponent {
  List<BaseWeapon> currentEquipment = [];

  EquipmentInfo() : super(
    id: 2,
    position: Vector2(0, 0),
    size: Vector2(450, 72)
  );

  @override
  void update(double dt) {
    var player = gameRef.player as MainPlayer;
    currentEquipment = [player.equippedWeapon];
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    var style = const TextStyle(color: Colors.white, fontSize: 10);
    currentEquipment
        .whereNot((element) => element is DummyWeapon)
        .toList()
        .asMap()
        .forEach((index, value) {
          double offsetX = 80 + index * 30;
          value.sprite?.render(c, size: Vector2(20, 20), position: Vector2(offsetX, 40));
          var itemLvl = value.reqLvl;
          TextPaint(style: style).render(c, "LV: $itemLvl", Vector2(offsetX, 65));
        });
  }
}