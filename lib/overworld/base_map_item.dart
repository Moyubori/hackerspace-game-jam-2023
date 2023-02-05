import 'dart:html';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/cupertino.dart';

import '../dungeon/demo_dungeon_map.dart';
import 'player.dart';

abstract class MapObject extends GameDecorationWithCollision with Sensor<Player> {
  MapObject(Vector2 position, String file)
      : super.withSprite(
    sprite: Sprite.load(file),
    position: position,
    size: Vector2.all(DemoDungeonMap.tileSize * 0.5),
  );

  MapObject.breakable(Vector2 position, Vector2 size, String sprite, List<CollisionArea> collisions)
      : super.withSprite(sprite: Sprite.load(sprite), position: position, size: size, collisions: collisions);

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