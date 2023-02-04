import 'package:bonfire/bonfire.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_tile_builder.dart';
import 'package:hackerspace_game_jam_2023/equipment/axe.dart';
import 'package:hackerspace_game_jam_2023/equipment/sword.dart';

import '../equipment/potion.dart';

class DemoDungeonMap {
  static double tileSize = 48;
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
    DungeonTileBuilder tileBuilder = DungeonTileBuilder();

    List<TileModel> tileList = [];
    List.generate(35, (indexRow) {
      List.generate(70, (indexColumn) {
        if (indexRow == 3 && indexColumn > 2 && indexColumn < 30) {
          tileList.add(tileBuilder.buildWallBottom(indexColumn, indexRow));
          return;
        }
        if (indexRow == 4 && indexColumn > 2 && indexColumn < 30) {
          tileList.add(tileBuilder.buildWall(indexColumn, indexRow));
          return;
        }

        if (indexRow == 9 && indexColumn > 2 && indexColumn < 30) {
          tileList.add(tileBuilder.buildWallTop(indexColumn, indexRow));
          return;
        }

        if (indexRow > 4 && indexRow < 9 && indexColumn > 2 && indexColumn < 30) {
          tileList.add(tileBuilder.buildFloor(indexColumn, indexRow));
          return;
        }

        if (indexRow > 3 && indexRow < 9 && indexColumn == 2) {
          tileList.add(tileBuilder.buildWallLeft(indexColumn, indexRow));
        }
        if (indexRow == 9 && indexColumn == 2) {
          tileList.add(tileBuilder.buildWallBottomLeft(indexColumn, indexRow));
        }

        if (indexRow > 3 && indexRow < 9 && indexColumn == 30) {
          tileList.add(tileBuilder.buildWallRight(indexColumn, indexRow));
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
        collisions: [
          CollisionArea.circle(radius: tileSize / 3, align: Vector2.all(tileSize / 6)),
        ],
      ),
      GameDecorationWithCollision.withSprite(
        sprite: Sprite.load('itens/table.png'),
        position: getRelativeTilePosition(15, 7),
        size: Vector2(tileSize, tileSize),
        collisions: [
          CollisionArea.circle(radius: tileSize * 0.4, align: Vector2.all(tileSize * 0.1)),
        ],
      ),
      GameDecorationWithCollision.withSprite(
        sprite: Sprite.load('itens/table.png'),
        position: getRelativeTilePosition(27, 6),
        size: Vector2(tileSize, tileSize),
        collisions: [
          CollisionArea.circle(radius: tileSize * 0.4, align: Vector2.all(tileSize * 0.1)),
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
      ),
      Axe(Vector2(480, 240), 1),
      Sword(Vector2(480, 350), 1),
      Axe(Vector2(580, 240), 3),
      Sword(Vector2(580, 350), 3),
      Axe(Vector2(680, 240), 5),
      Sword(Vector2(680, 350), 5),
    ];
  }

  static Vector2 getRelativeTilePosition(int x, int y) {
    return Vector2(
      (x * tileSize).toDouble(),
      (y * tileSize).toDouble(),
    );
  }
}
