import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flame/game.dart';

import 'dungeonMap.dart';
import 'item.dart';
import 'overworld.dart';

class Knight extends SimplePlayer with ObjectCollision {
  List<Item> inventory = List.empty(growable: true);
  late int hp;
  int initialHp;

  Knight(Vector2 position, this.initialHp)
      : super(
    position: position,
    size: Vector2(32, 32),
    animation: PlayerSpriteSheet.simpleDirectionAnimation,
  ) {
    hp = initialHp;
    setupCollision(
        CollisionConfig(
          collisions: [
            CollisionArea.rectangle(
              size: Vector2(
                DungeonMap.tileSize / 2,
                DungeonMap.tileSize / 2.2,
              ),
              align: Vector2(
                DungeonMap.tileSize / 3.5,
                DungeonMap.tileSize / 2,
              ),
            )
          ],
        )
    );
  }
}