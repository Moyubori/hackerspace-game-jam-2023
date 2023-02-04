import 'dart:math';

import 'package:bonfire/bonfire.dart';

import 'chest.dart';
import 'item.dart';

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
      Chest(Vector2(250, 300), [Potion(Vector2(0, 0))]),
      Potion(Vector2(450, 240)),
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