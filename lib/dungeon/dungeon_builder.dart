import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_tile_builder.dart';

abstract class DungeonBuilder {

  @protected
  DungeonTileBuilder dungeonTileBuilder = DungeonTileBuilder();
  
  Future<DungeonMap> build(DungeonMapConfig config);

  @protected
  void decorate(List<List<TileModel>> rawMap) {
    for (int x = 0; x < rawMap.length; x++) {
      for (int y = 0; y < rawMap[x].length; y++) {
        if (isFloor(rawMap[x][y].sprite?.path)) {
          continue;
        }

        if (x - 1 >= 0 && isFloor(rawMap[x - 1][y].sprite?.path)) {
          if (y - 1 > 0 && isFloor(rawMap[x][y - 1].sprite?.path)) {
            rawMap[x][y] = dungeonTileBuilder.buildWallLeftAndTop(x, y);
          } else if (y + 1 < rawMap[x].length && isFloor(rawMap[x][y + 1].sprite?.path)) {
            rawMap[x][y] = dungeonTileBuilder.buildWallRightAndBottom(x, y);
          } else {
            rawMap[x][y] = dungeonTileBuilder.buildWallRight(x, y);
          }
          continue;
        }

        if (x + 1 < rawMap.length && isFloor(rawMap[x + 1][y].sprite?.path)) {
          if (y - 1 > 0 && isFloor(rawMap[x][y - 1].sprite?.path)) {
            rawMap[x][y] = dungeonTileBuilder.buildWallTurnLeftTop(x, y);
          } else if (y + 1 < rawMap[x].length && isFloor(rawMap[x][y + 1].sprite?.path)) {
            rawMap[x][y] = dungeonTileBuilder.buildWallLeftAndBottom(x, y);
          } else {
            rawMap[x][y] = dungeonTileBuilder.buildWallLeft(x, y);
          }
          continue;
        }

        if (y - 1 > 0 && isFloor(rawMap[x][y - 1].sprite?.path)) {
          rawMap[x][y] = dungeonTileBuilder.buildWallTop(x, y);
          continue;
        }

        if (y + 1 < rawMap[x].length && isFloor(rawMap[x][y + 1].sprite?.path)) {
          rawMap[x][y] = dungeonTileBuilder.buildWallBottom(x, y);
          continue;
        }

        if (x - 1 >= 0 && y - 1 >= 0 && isFloor(rawMap[x - 1][y - 1].sprite?.path)) {
          rawMap[x][y] = dungeonTileBuilder.buildWallRight(x, y);
          continue;
        }

        if (x - 1 >= 0 && y + 1 < rawMap[x].length && isFloor(rawMap[x - 1][y + 1].sprite?.path)) {
          rawMap[x][y] = dungeonTileBuilder.buildWallTopInnerRight(x, y);
          continue;
        }

        if (x + 1 < rawMap.length && y - 1 >= 0 && isFloor(rawMap[x + 1][y - 1].sprite?.path)) {
          rawMap[x][y] = dungeonTileBuilder.buildWallLeft(x, y);
          continue;
        }

        if (x + 1 < rawMap.length &&
            y + 1 < rawMap[x].length &&
            isFloor(rawMap[x + 1][y + 1].sprite?.path)) {
          rawMap[x][y] = dungeonTileBuilder.buildWallTopInnerLeft(x, y);
          continue;
        }
      }
    }
  }

  @protected
  bool isFloor(String? path) {
    if (path == null) return false;
    return path.contains('floor');
  }

}