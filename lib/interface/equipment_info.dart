import 'dart:ui';

import 'package:bonfire/bonfire.dart';

import '../equipment/base_item.dart';
import '../overworld/player.dart';

class EquipmentInfo extends InterfaceComponent {
  List<InteractableItem> currentEquipment = [];

  EquipmentInfo() : super(
    id: 2,
    position: Vector2(0, 0),
    size: Vector2(450, 72)
  );

  @override
  void update(double dt) {
    var player = gameRef.player as MainPlayer;
    currentEquipment = List.from(player.inventory);
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    currentEquipment.asMap().forEach((index, value) {
      double offsetX = 80 + index * 30;
      value.sprite?.render(c, size: Vector2(20, 20), position: Vector2(offsetX, 40));
    });
  }
}