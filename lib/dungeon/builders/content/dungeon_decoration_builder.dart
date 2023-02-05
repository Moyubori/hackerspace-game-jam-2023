import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_tile_builder.dart';

import '../../../equipment/breakable_world_object.dart';

class DungeonDecorationBuilder {
  final Random random = Random();

  GameDecoration buildBarrel(int x, int y) => Barrel(getRelativeTilePosition(x, y));

  GameDecoration buildTable(int x, int y) => Table(getRelativeTilePosition(x, y));

  GameDecoration buildRandom(int x, int y) => random.nextInt(10) < 4 ? buildTable(x, y) : buildBarrel(x, y);

  static Vector2 getRelativeTilePosition(int x, int y) {
    return Vector2(
      (x * DungeonTileBuilder.tileSize).toDouble(),
      (y * DungeonTileBuilder.tileSize).toDouble(),
    );
  }
}
