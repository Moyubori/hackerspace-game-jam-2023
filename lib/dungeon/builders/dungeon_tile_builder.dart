import 'dart:math';

import 'package:bonfire/bonfire.dart';

class DungeonTileBuilder {
  static double tileSize = 45;

  static const String abyss = 'tile/abyss.png';
  static const String placeholder = 'tile/placeholder.png';

  static const String wall = 'tile/wall.png';
  static const String wallTop = 'tile/wall_top.png';
  static const String wallTopInnerRight = 'tile/wall_top_inner_right.png';
  static const String wallTopInnerLeft = 'tile/wall_top_inner_left.png';

  static const String wallLeft = 'tile/wall_left.png';
  static const String wallLeftAndBottom = 'tile/wall_left_and_bottom.png';
  static const String wallLeftAndTop = 'tile/wall_left_and_top.png';

  static const String wallBottom = 'tile/wall_bottom.png';
  static const String wallBottomLeft = 'tile/wall_bottom_left.png';
  static const String wallBottomRight = 'tile/wall_bottom_right.png';

  static const String wallRight = 'tile/wall_right.png';
  static const String wallRightAndBottom = 'tile/wall_right_and_bottom.png';
  static const String wallTurnLeftTop = 'tile/wall_turn_left_top.png';

  static const String floor_1 = 'tile/floor_1.png';
  static const String floor_2 = 'tile/floor_2.png';
  static const String floor_3 = 'tile/floor_3.png';
  static const String floor_4 = 'tile/floor_4.png';

  TileModel buildPlaceholder(int x, int y) => TileModel(
    sprite: TileModelSprite(path: placeholder),
    x: x.toDouble(),
    y: y.toDouble(),
    collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
    width: tileSize,
    height: tileSize,
  );

  TileModel buildAbyss(int x, int y) => TileModel(
    sprite: TileModelSprite(path: abyss),
    x: x.toDouble(),
    y: y.toDouble(),
    // collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
    width: tileSize,
    height: tileSize,
  );

  TileModel buildFloor(int x, int y) => TileModel(
    sprite: TileModelSprite(path: randomFloor()),
    x: x.toDouble(),
    y: y.toDouble(),
    width: tileSize,
    height: tileSize,
  );

  TileModel buildWall(int x, int y) => TileModel(
    sprite: TileModelSprite(path: wall),
    x: x.toDouble(),
    y: y.toDouble(),
    collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
    width: tileSize,
    height: tileSize,
  );

  TileModel buildWallBottom(int indexColumn, int indexRow) => TileModel(
      sprite: TileModelSprite(path: wallBottom),
      x: indexColumn.toDouble(),
      y: indexRow.toDouble(),
      collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
      width: tileSize,
      height: tileSize,
    );

  TileModel buildWallBottomLeft(int indexColumn, int indexRow) => TileModel(
    sprite: TileModelSprite(path: wallBottomLeft),
    x: indexColumn.toDouble(),
    y: indexRow.toDouble(),
    collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
    width: tileSize,
    height: tileSize,
  );

  TileModel buildWallRight(int indexColumn, int indexRow) => TileModel(
      sprite: TileModelSprite(path: wallRight),
      x: indexColumn.toDouble(),
      y: indexRow.toDouble(),
      collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
      width: tileSize,
      height: tileSize,
    );

  TileModel buildWallRightAndBottom(int indexColumn, int indexRow) => TileModel(
      sprite: TileModelSprite(path: wallRightAndBottom),
      x: indexColumn.toDouble(),
      y: indexRow.toDouble(),
      collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
      width: tileSize,
      height: tileSize,
    );

  TileModel buildWallLeft(int indexColumn, int indexRow) => TileModel(
      sprite: TileModelSprite(path: wallLeft),
      x: indexColumn.toDouble(),
      y: indexRow.toDouble(),
      collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
      width: tileSize,
      height: tileSize,
    );

  TileModel buildWallLeftAndTop(int indexColumn, int indexRow) => TileModel(
      sprite: TileModelSprite(path: wallLeftAndTop),
      x: indexColumn.toDouble(),
      y: indexRow.toDouble(),
      collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
      width: tileSize,
      height: tileSize,
    );

  TileModel buildWallLeftAndBottom(int indexColumn, int indexRow) => TileModel(
      sprite: TileModelSprite(path: wallLeftAndBottom),
      x: indexColumn.toDouble(),
      y: indexRow.toDouble(),
      collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
      width: tileSize,
      height: tileSize,
    );

  TileModel buildWallTurnLeftTop(int indexColumn, int indexRow) => TileModel(
      sprite: TileModelSprite(path: wallTurnLeftTop),
      x: indexColumn.toDouble(),
      y: indexRow.toDouble(),
      collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
      width: tileSize,
      height: tileSize,
    );

  TileModel buildWallTop(int indexColumn, int indexRow) => TileModel(
      sprite: TileModelSprite(path: wallTop),
      x: indexColumn.toDouble(),
      y: indexRow.toDouble(),
      collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
      width: tileSize,
      height: tileSize,
    );

  TileModel buildWallTopInnerRight(int indexColumn, int indexRow) => TileModel(
      sprite: TileModelSprite(path: wallTopInnerRight),
      x: indexColumn.toDouble(),
      y: indexRow.toDouble(),
      collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
      width: tileSize,
      height: tileSize,
    );

  TileModel buildWallTopInnerLeft(int indexColumn, int indexRow) => TileModel(
      sprite: TileModelSprite(path: wallTopInnerLeft),
      x: indexColumn.toDouble(),
      y: indexRow.toDouble(),
      collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
      width: tileSize,
      height: tileSize,
    );

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
}