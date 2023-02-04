import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/cupertino.dart';
import 'package:hackerspace_game_jam_2023/player.dart';
import 'dungeonMap.dart';

abstract class MapObject extends GameDecoration with Sensor<Player> {
  MapObject(Vector2 position, String file)
      : super.withSprite(
    sprite: Sprite.load(file),
    position: position,
    size: Vector2.all(DungeonMap.tileSize * 0.5),
  );

  @protected
  void onPlayerTouched(Knight player);

  @override
  void onContact(GameComponent component) {
    if (component is Knight) {
      onPlayerTouched(component);
    }
  }

  @override
  void onContactExit(GameComponent component) {}
}

abstract class Item extends GameDecoration with Sensor<Player> {
  Item(Vector2 position, String file)
      : super.withSprite(
    sprite: Sprite.load(file),
    position: position,
    size: Vector2.all(DungeonMap.tileSize * 0.5),
  );

  @override
  void onContact(GameComponent component) {
    if (component is Knight) {
      component.inventory.add(this);
      removeFromParent();
    }
  }

  void use(Knight player);

  @override
  void onContactExit(GameComponent component) {}
}

class Potion extends Item {
  Potion(Vector2 position): super(position, "itens/potion_life.png");

  @override
  void use(Knight player) {
    player.hp = min(player.hp + 20, player.initialHp);
  }
}