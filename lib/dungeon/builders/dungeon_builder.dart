import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_tile_builder.dart';
import 'package:hackerspace_game_jam_2023/enemies/goblin.dart';

abstract class DungeonBuilder {
  @protected
  DungeonTileBuilder dungeonTileBuilder = DungeonTileBuilder();

  Future<DungeonMap> build(covariant DungeonMapConfig config);

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

  @protected
  bool isFloor(TileModel? model) {
    if (model == null) return false;
    return model.sprite!.path.contains('floor');
  }

  @protected
  double getManhattanDistance(Vector2 p1, Vector2 p2) => (p1.x - p2.x).abs() + (p1.y - p2.y).abs();

  @protected
  List<Enemy> createEnemies(List<List<TileModel>> rawMap, DungeonMapConfig config) {
    List<Vector2> spawnPoints = [];

    for (int x = 0; x < rawMap.length; x++) {
      for (int y = 0; y < rawMap[x].length; y++) {
        final Vector2 currentPos = Vector2(x.toDouble(), y.toDouble());

        if (isFloor(rawMap[x][y]) && _isOutsideSafeSpace(config, currentPos)) {
          if (spawnPoints.isEmpty || _canSpawn(currentPos, spawnPoints, config)) {
            spawnPoints.add(currentPos);
          }
        }
      }
    }

    return spawnPoints
        .map((e) =>
            Goblin(Vector2(e.x * DungeonTileBuilder.tileSize, e.y * DungeonTileBuilder.tileSize)))
        .toList();
  }

  @protected
  bool _isOutsideSafeSpace(DungeonMapConfig config, Vector2 currentPos) {
    return getManhattanDistance(config.startingPos, currentPos) > config.safeAreaRadius;
  }

  /// Determines if nearest enemy is further than configured distance in manhattan metric
  /// @protected
  bool _canSpawn(Vector2 currentPos, List<Vector2> spawnPoints, DungeonMapConfig config) =>
      spawnPoints.none((e) => getManhattanDistance(e, currentPos) < config.enemySpread) &&
      (spawnPoints.length < config.enemiesCount || config.enemiesCount == -1);
}
