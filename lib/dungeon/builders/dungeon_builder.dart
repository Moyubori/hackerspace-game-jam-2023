import 'dart:async';
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_decoration_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/tile_helpers.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_tile_builder.dart';
import 'package:hackerspace_game_jam_2023/enemies/goblin/goblin.dart';

abstract class DungeonBuilder with TileHelpers {
  @protected
  DungeonTileBuilder dungeonTileBuilder = DungeonTileBuilder();

  Future<DungeonMap> build(covariant DungeonMapConfig config) async {
    List<List<TileModel>> rawMap = await buildPaths(config);

    decorate(rawMap);

    return DungeonMap(
      dungeon: WorldMap(rawMap.expand((line) => line).toList()),
      enemies: config.enemyFactory?.createContent(rawMap, config) ?? [],
      decorations: config.decorationFactory?.createContent(rawMap, config) ?? [],
    );
  }

  Future<List<List<TileModel>>> buildPaths(covariant DungeonMapConfig config);

  @protected
  void decorate(List<List<TileModel>> rawMap) {
    for (int x = 0; x < rawMap.length; x++) {
      for (int y = 0; y < rawMap[x].length; y++) {
        if (isFloor(rawMap[x][y])) {
          continue;
        }

        if (x - 1 >= 0 && isFloor(rawMap[x - 1][y])) {
          if (y - 1 > 0 && isFloor(rawMap[x][y - 1])) {
            rawMap[x][y] = dungeonTileBuilder.buildWallLeftAndTop(x, y);
          } else if (y + 1 < rawMap[x].length && isFloor(rawMap[x][y + 1])) {
            rawMap[x][y] = dungeonTileBuilder.buildWallRightAndBottom(x, y);
          } else {
            rawMap[x][y] = dungeonTileBuilder.buildWallRight(x, y);
          }
          continue;
        }

        if (x + 1 < rawMap.length && isFloor(rawMap[x + 1][y])) {
          if (y - 1 > 0 && isFloor(rawMap[x][y - 1])) {
            rawMap[x][y] = dungeonTileBuilder.buildWallTurnLeftTop(x, y);
          } else if (y + 1 < rawMap[x].length && isFloor(rawMap[x][y + 1])) {
            rawMap[x][y] = dungeonTileBuilder.buildWallLeftAndBottom(x, y);
          } else {
            rawMap[x][y] = dungeonTileBuilder.buildWallLeft(x, y);
          }
          continue;
        }

        if (y - 1 > 0 && isFloor(rawMap[x][y - 1])) {
          rawMap[x][y] = dungeonTileBuilder.buildWallTop(x, y);
          continue;
        }

        if (y + 1 < rawMap[x].length && isFloor(rawMap[x][y + 1])) {
          rawMap[x][y] = dungeonTileBuilder.buildWallBottom(x, y);
          continue;
        }

        if (x - 1 >= 0 && y - 1 >= 0 && isFloor(rawMap[x - 1][y - 1])) {
          rawMap[x][y] = dungeonTileBuilder.buildWallRight(x, y);
          continue;
        }

        if (x - 1 >= 0 && y + 1 < rawMap[x].length && isFloor(rawMap[x - 1][y + 1])) {
          rawMap[x][y] = dungeonTileBuilder.buildWallTopInnerRight(x, y);
          continue;
        }

        if (x + 1 < rawMap.length && y - 1 >= 0 && isFloor(rawMap[x + 1][y - 1])) {
          rawMap[x][y] = dungeonTileBuilder.buildWallLeft(x, y);
          continue;
        }

        if (x + 1 < rawMap.length && y + 1 < rawMap[x].length && isFloor(rawMap[x + 1][y + 1])) {
          rawMap[x][y] = dungeonTileBuilder.buildWallTopInnerLeft(x, y);
          continue;
        }
      }
    }
  }
}
