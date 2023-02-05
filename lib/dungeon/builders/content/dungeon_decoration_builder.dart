import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_tile_builder.dart';
import 'package:hackerspace_game_jam_2023/equipment/chest.dart';
import 'package:hackerspace_game_jam_2023/overworld/reward_manager.dart';

import '../../../equipment/breakable_world_object.dart';

class DungeonDecorationBuilder {
  final Random random = Random();

  GameDecoration buildBarrel(int x, int y) => Barrel(getRelativeTilePosition(x, y));

  GameDecoration buildTable(int x, int y) => Table(getRelativeTilePosition(x, y));

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
