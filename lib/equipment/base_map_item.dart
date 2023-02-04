import 'dart:html';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/cupertino.dart';

import '../dungeon/demo_dungeon_map.dart';
import '../overworld/player.dart';

abstract class MapObject extends GameDecoration with Sensor<Player> {
  MapObject(Vector2 position, String file)
      : super.withSprite(
    sprite: Sprite.load(file),
    position: position,
    size: Vector2.all(DemoDungeonMap.tileSize * 0.5),
  );

  @protected
  void onPlayerTouched(MainPlayer player);

  @override
  void onContact(GameComponent component) {
    if (component is MainPlayer) {
      onPlayerTouched(component);
    }
  }

  @override
  void onContactExit(GameComponent component) {}
}