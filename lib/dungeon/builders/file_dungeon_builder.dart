import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_tile_builder.dart';
import 'package:hackerspace_game_jam_2023/enemies/goblin.dart';
import 'package:image/image.dart' as img;

class FileDungeonMapConfig extends DungeonMapConfig {
  final String levelFile;

  FileDungeonMapConfig({
    required this.levelFile,
    required super.startingPos,
    super.safeAreaRadius = 10.0,
    super.enemySpread = 10.0,
    super.enemiesCount = -1,
  });
}

class FileDungeonBuilder extends DungeonBuilder {
  @override
  Future<DungeonMap> build(FileDungeonMapConfig config) async {
    ByteData byteData = await rootBundle.load(config.levelFile);
    img.Image? levelData = img.decodeImage(byteData.buffer.asUint8List());

    List<List<TileModel>> rawMap = _buildPaths(levelData);
    decorate(rawMap);

    return DungeonMap(
      dungeon: WorldMap(rawMap.expand((line) => line).toList()),
      enemies: createEnemies(rawMap, config),
    );
  }

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
