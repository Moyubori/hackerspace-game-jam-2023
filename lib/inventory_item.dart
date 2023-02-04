import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'dungeon_map.dart';
import 'overworld/player.dart';

abstract class MapObject extends GameDecoration with Sensor<Player> {
  MapObject(Vector2 position, String file)
      : super.withSprite(
    sprite: Sprite.load(file),
    position: position,
    size: Vector2.all(DungeonMap.tileSize * 0.5),
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

abstract class InventoryItem extends GameDecoration with Sensor<Player> {
  InventoryItem(Vector2 position, String file)
      : super.withSprite(
    sprite: Sprite.load(file),
    position: position,
    size: Vector2.all(DungeonMap.tileSize * 0.5),
  );

  @override
  void onContact(GameComponent component) {
    if (component is MainPlayer) {
      component.inventory.add(this);
      removeFromParent();
    }
  }

  void use(MainPlayer player);

  @override
  void onContactExit(GameComponent component) {}
}

class Potion extends InventoryItem {
  Potion(Vector2 position): super(position, "itens/potion_life.png");

  @override
  void use(MainPlayer player) {
    player.hp = min(player.hp + 20, player.initialHp);
  }
}