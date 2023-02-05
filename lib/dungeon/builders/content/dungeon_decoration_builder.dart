import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_tile_builder.dart';
import 'package:hackerspace_game_jam_2023/equipment/chest.dart';
import 'package:hackerspace_game_jam_2023/overworld/reward_manager.dart';

class DungeonDecorationBuilder {
  final Random random = Random();

  GameDecoration buildBarrel(int x, int y) => GameDecorationWithCollision.withSprite(
        sprite: Sprite.load('itens/barrel.png'),
        position: getRelativeTilePosition(x, y),
        size: Vector2(DungeonTileBuilder.tileSize, DungeonTileBuilder.tileSize),
        collisions: [
          CollisionArea.circle(
              radius: DungeonTileBuilder.tileSize / 3, align: Vector2.all(DungeonTileBuilder.tileSize / 6)),
        ],
      );

  GameDecoration buildTable(int x, int y) => GameDecorationWithCollision.withSprite(
        sprite: Sprite.load('itens/table.png'),
        position: getRelativeTilePosition(x, y),
        size: Vector2(DungeonTileBuilder.tileSize, DungeonTileBuilder.tileSize),
        collisions: [
          CollisionArea.circle(
              radius: DungeonTileBuilder.tileSize * 0.4, align: Vector2.all(DungeonTileBuilder.tileSize * 0.1)),
        ],
      );

  GameDecoration buildChest(int x, int y) => Chest(getRelativeTilePosition(x, y), RewardManager.generateRandomChestContent());

  GameDecoration buildRandom(int x, int y) => getRandomDecoration(x, y);

  GameDecoration getRandomDecoration(int x, int y) {
    int randValue = random.nextInt(10);

    // if (randValue < 3) {
    //   return buildTable(x, y);
    // } else if (randValue < 8) {
    //   return buildBarrel(x, y);
    // } else {
      return buildChest(x, y);
    // }
  }

  static Vector2 getRelativeTilePosition(int x, int y) {
    return Vector2(
      (x * DungeonTileBuilder.tileSize).toDouble(),
      (y * DungeonTileBuilder.tileSize).toDouble(),
    );
  }
}
