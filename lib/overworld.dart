import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class Overworld extends StatelessWidget {
  const Overworld({super.key});

  @override
  Widget build(BuildContext context) => BonfireWidget(
        player: Knight(
          Vector2((4 * DungeonMap.tileSize), (6 * DungeonMap.tileSize)),
        ),
        joystick: Joystick(
          keyboardConfig: KeyboardConfig(),
        ),
        map: DungeonMap.map(),
      );
}

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
        "player/knight_idle_left.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        "player/knight_idle.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        "player/knight_run.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
        "player/knight_run_left.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static SimpleDirectionAnimation get simpleDirectionAnimation => SimpleDirectionAnimation(
        idleRight: idleRight,
        runRight: runRight,
      );
}

class Knight extends SimplePlayer with ObjectCollision {
  Knight(Vector2 position)
      : super(
          position: position,
          size: Vector2(32, 32),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
        ) {
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
      ),
    );
  }
}

class DungeonMap {
  static double tileSize = 45;
  static const String wallBottom = 'tile/wall_bottom.png';
  static const String wall = 'tile/wall.png';
  static const String wallTop = 'tile/wall_top.png';
  static const String wallLeft = 'tile/wall_left.png';
  static const String wallBottomLeft = 'tile/wall_bottom_left.png';
  static const String wallRight = 'tile/wall_right.png';
  static const String floor_1 = 'tile/floor_1.png';
  static const String floor_2 = 'tile/floor_2.png';
  static const String floor_3 = 'tile/floor_3.png';
  static const String floor_4 = 'tile/floor_4.png';

  static WorldMap map() {
    List<TileModel> tileList = [];
    List.generate(35, (indexRow) {
      List.generate(70, (indexColumn) {
        if (indexRow == 3 && indexColumn > 2 && indexColumn < 30) {
          tileList.add(TileModel(
            sprite: TileModelSprite(path: wallBottom),
            x: indexColumn.toDouble(),
            y: indexRow.toDouble(),
            collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
            width: tileSize,
            height: tileSize,
          ));
          return;
        }
        if (indexRow == 4 && indexColumn > 2 && indexColumn < 30) {
          tileList.add(TileModel(
            sprite: TileModelSprite(path: wall),
            x: indexColumn.toDouble(),
            y: indexRow.toDouble(),
            collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
            width: tileSize,
            height: tileSize,
          ));
          return;
        }

        if (indexRow == 9 && indexColumn > 2 && indexColumn < 30) {
          tileList.add(TileModel(
            sprite: TileModelSprite(path: wallTop),
            x: indexColumn.toDouble(),
            y: indexRow.toDouble(),
            collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
            width: tileSize,
            height: tileSize,
          ));
          return;
        }

        if (indexRow > 4 && indexRow < 9 && indexColumn > 2 && indexColumn < 30) {
          tileList.add(
            TileModel(
              sprite: TileModelSprite(path: randomFloor()),
              x: indexColumn.toDouble(),
              y: indexRow.toDouble(),
              width: tileSize,
              height: tileSize,
            ),
          );
          return;
        }

        if (indexRow > 3 && indexRow < 9 && indexColumn == 2) {
          tileList.add(TileModel(
            sprite: TileModelSprite(path: wallLeft),
            x: indexColumn.toDouble(),
            y: indexRow.toDouble(),
            collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
            width: tileSize,
            height: tileSize,
          ));
        }
        if (indexRow == 9 && indexColumn == 2) {
          tileList.add(TileModel(
            sprite: TileModelSprite(path: wallBottomLeft),
            x: indexColumn.toDouble(),
            y: indexRow.toDouble(),
            collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
            width: tileSize,
            height: tileSize,
          ));
        }

        if (indexRow > 3 && indexRow < 9 && indexColumn == 30) {
          tileList.add(TileModel(
            sprite: TileModelSprite(path: wallRight),
            x: indexColumn.toDouble(),
            y: indexRow.toDouble(),
            collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
            width: tileSize,
            height: tileSize,
          ));
        }
      });
    });

    return WorldMap(tileList);
  }

  static List<GameDecoration> decorations() {
    return [
      GameDecorationWithCollision.withSprite(
        sprite: Sprite.load('itens/barrel.png'),
        position: getRelativeTilePosition(10, 6),
        size: Vector2(tileSize, tileSize),
        collisions: [CollisionArea.rectangle(size: Vector2(tileSize / 1.5, tileSize / 1.5))],
      ),
      GameDecorationWithCollision.withSprite(
        sprite: Sprite.load('itens/table.png'),
        position: getRelativeTilePosition(15, 7),
        size: Vector2(tileSize, tileSize),
        collisions: [
          CollisionArea.rectangle(size: Vector2(tileSize, tileSize * 0.8)),
        ],
      ),
      GameDecorationWithCollision.withSprite(
        sprite: Sprite.load('itens/table.png'),
        position: getRelativeTilePosition(27, 6),
        size: Vector2(tileSize, tileSize),
        collisions: [
          CollisionArea.rectangle(size: Vector2(tileSize, tileSize * 0.8)),
        ],
      ),
      GameDecoration.withSprite(
        sprite: Sprite.load('itens/flag_red.png'),
        position: getRelativeTilePosition(24, 4),
        size: Vector2(tileSize, tileSize),
      ),
      GameDecoration.withSprite(
        sprite: Sprite.load('itens/flag_red.png'),
        position: getRelativeTilePosition(6, 4),
        size: Vector2(tileSize, tileSize),
      ),
      GameDecoration.withSprite(
        sprite: Sprite.load('itens/prisoner.png'),
        position: getRelativeTilePosition(10, 4),
        size: Vector2(tileSize, tileSize),
      ),
      GameDecoration.withSprite(
        sprite: Sprite.load('itens/flag_red.png'),
        position: getRelativeTilePosition(14, 4),
        size: Vector2(tileSize, tileSize),
      )
    ];
  }

  static List<Enemy> enemies() {
    return [];
  }

  static String randomFloor() {
    int p = Random().nextInt(6);
    switch (p) {
      case 0:
        return floor_1;
      case 1:
        return floor_2;
      case 2:
        return floor_3;
      case 3:
        return floor_4;
      case 4:
        return floor_3;
      case 5:
        return floor_4;
      default:
        return floor_1;
    }
  }

  static Vector2 getRelativeTilePosition(int x, int y) {
    return Vector2(
      (x * tileSize).toDouble(),
      (y * tileSize).toDouble(),
    );
  }
}
