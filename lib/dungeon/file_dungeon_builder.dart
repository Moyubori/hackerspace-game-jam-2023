import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_tile_builder.dart';
import 'package:hackerspace_game_jam_2023/enemies/goblin.dart';
import 'package:image/image.dart' as img;

class FileDungeonBuilder extends DungeonBuilder {

  @override
  Future<DungeonMap> build(DungeonMapConfig config) async {
    ByteData byteData = await rootBundle.load(config.levelFile);
    img.Image? levelData = img.decodeImage(byteData.buffer.asUint8List());

    List<List<TileModel>> rawMap = _buildPaths(levelData);
    decorate(rawMap);

    return DungeonMap(
      dungeon: WorldMap(rawMap.expand((line) => line).toList()),
      enemies: _createEnemies(rawMap, config),
    );
  }

  List<Enemy> _createEnemies(List<List<TileModel>> rawMap, DungeonMapConfig config) {
    List<Vector2> spawnPoints = [];

    for (int x = 0; x < rawMap.length; x++) {
      for (int y = 0; y < rawMap[x].length; y++) {
        final Vector2 currentPos = Vector2(x.toDouble(), y.toDouble());

        if (isFloor(rawMap[x][y].sprite?.path) && _isOutsideSafeSpace(config, currentPos)) {
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

  bool _isOutsideSafeSpace(DungeonMapConfig config, Vector2 currentPos) {
    return _getManhattanDistance(config.startingPos, currentPos) > config.safeAreaRadius;
  }

  /// Determines if nearest enemy is further than configured distance in manhattan metric
  bool _canSpawn(Vector2 currentPos, List<Vector2> spawnPoints, DungeonMapConfig config) =>
      spawnPoints.none((e) => _getManhattanDistance(e, currentPos) < config.enemySpread) &&
          (spawnPoints.length < config.enemiesCount || config.enemiesCount == -1);

  double _getManhattanDistance(Vector2 p1, Vector2 p2) => (p1.x - p2.x).abs() + (p1.y - p2.y).abs();

  List<List<TileModel>> _buildPaths(img.Image? levelData) {
    List<List<TileModel>> rawMap = [];

    for (int x = 0; x < levelData!.width + 2; x++) {
      List<TileModel> line = [];

      for (int y = 0; y < levelData.height + 2; y++) {
        if (x == 0 || x == levelData.width + 1) {
          line = List.generate(levelData.width + 2, (_) => dungeonTileBuilder.buildAbyss(x, y));
          continue;
        }

        if (y == 0 || y == levelData.height + 1) {
          line.add(dungeonTileBuilder.buildAbyss(x, y));
          continue;
        }

        img.Pixel pixel = levelData.getPixel(x - 1, y - 1);
        if (pixel.r == Colors.black.red &&
            pixel.g == Colors.black.green &&
            pixel.b == Colors.black.blue) {
          line.add(dungeonTileBuilder.buildFloor(x, y));
        } else {
          line.add(dungeonTileBuilder.buildAbyss(x, y));
        }
      }

      rawMap.add(line);
    }
    return rawMap;
  }
}
