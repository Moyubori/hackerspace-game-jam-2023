import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:collection/collection.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';

class RandomDungeonMapConfig extends DungeonMapConfig {
  final int mapSize;
  final int startingBlobs;

  RandomDungeonMapConfig({
    required this.mapSize,
    required super.startingPos,
    required this.startingBlobs,
    super.safeAreaRadius = 10.0,
    super.enemySpread = 10.0,
    super.enemiesCount = -1,
  });
}

class RandomDungeonBuilder extends DungeonBuilder {
  @override
  Future<DungeonMap> build(RandomDungeonMapConfig config) async {
    final Random random = Random();

    List<List<TileModel>> rawMap = List.generate(config.mapSize,
        (x) => List.generate(config.mapSize, (y) => dungeonTileBuilder.buildAbyss(x, y)));

    // select initial blob positions
    List<Vector2> blobs = [];
    while (blobs.length < config.startingBlobs) {
      int x = random.nextInt(config.mapSize);
      int y = random.nextInt(config.mapSize);

      final Vector2 blobPos = Vector2(x.toDouble(), y.toDouble());
      if (blobs.none((e) => getManhattanDistance(e, blobPos) < 10)) {
        blobs.add(blobPos);
      }
    }

    Vector2 centerBlob = config.startingPos;

    // build blobs
    _insertBlobs(blobs, centerBlob, rawMap, config.mapSize, config.mapSize);
    List<MapEntry<Vector2, Vector2>> neighbours = _buildTree(blobs, centerBlob);
    _buildPaths(neighbours, rawMap, config.mapSize, config.mapSize);
    _patchSingles(rawMap);
    _trimEdges(rawMap);

    decorate(rawMap);

    return DungeonMap(
      dungeon: WorldMap(rawMap.expand((line) => line).toList()),
      enemies: createEnemies(rawMap, config),
      decorations: createDecorations(rawMap, config),
    );
  }

  void _insertBlobs(
      List<Vector2> blobs, Vector2 centerBlob, List<List<TileModel>> rawMap, int cols, int rows) {
    _insertBlob(centerBlob, rawMap, cols, rows);
    for (Vector2 blobPos in blobs) {
      _insertBlob(blobPos, rawMap, cols, rows);
    }
  }

  void _insertBlob(Vector2 blobPos, List<List<TileModel>> rawMap, int cols, int rows) {
    final int x = blobPos.x.toInt();
    final int y = blobPos.y.toInt();

    if (x - 1 >= 0) {
      if (y - 1 >= 0) {
        rawMap[x - 1][y - 1] = dungeonTileBuilder.buildFloor(x - 1, y - 1);
      }

      rawMap[x - 1][y] = dungeonTileBuilder.buildFloor(x - 1, y);

      if (y + 1 < cols) {
        rawMap[x - 1][y + 1] = dungeonTileBuilder.buildFloor(x - 1, y + 1);
      }
    }

    if (y - 1 >= 0) {
      rawMap[x][y - 1] = dungeonTileBuilder.buildFloor(x, y - 1);
    }

    rawMap[x][y] = dungeonTileBuilder.buildFloor(x, y);

    if (y + 1 < cols) {
      rawMap[x][y + 1] = dungeonTileBuilder.buildFloor(x, y + 1);
    }

    if (x + 1 < rows) {
      if (y - 1 >= 0) {
        rawMap[x + 1][y - 1] = dungeonTileBuilder.buildFloor(x + 1, y - 1);
      }
      rawMap[x + 1][y] = dungeonTileBuilder.buildFloor(x + 1, y);

      if (y + 1 < cols) {
        rawMap[x + 1][y + 1] = dungeonTileBuilder.buildFloor(x + 1, y + 1);
      }
    }
  }

  List<MapEntry<Vector2, Vector2>> _buildTree(List<Vector2> blobs, Vector2 centerBlob) {
    final Map<Vector2, Vector2> neighbours = {};

    for (Vector2 blob in blobs) {
      List<Vector2> unusedBlobs =
          blobs.whereNot((element) => neighbours.containsValue(element)).toList();
      List<double> neighbourDistances = unusedBlobs
          .map((e) => !neighbours.values.contains(e) ? getManhattanDistance(blob, e) : 0.0)
          .toList();
      double closestDistance = neighbourDistances
          .reduce((value, element) => value == 0 || element < value ? element : value);
      int index = neighbourDistances.indexOf(closestDistance);
      neighbours[blob] = unusedBlobs[index];
    }

    return [...blobs.map((e) => MapEntry(e, centerBlob)).toList(), ...neighbours.entries.toList()];
  }

  void _buildPaths(
    List<MapEntry<Vector2, Vector2>> neighbours,
    List<List<TileModel>> rawMap,
    int cols,
    int rows,
  ) {
    for (MapEntry<Vector2, Vector2> neighbour in neighbours) {
      int xAxisDiff = (neighbour.key.x - neighbour.value.x).toInt();
      int yAxisDiff = (neighbour.key.y - neighbour.value.y).toInt();

      bool goLeft = xAxisDiff < 0;
      bool goUp = yAxisDiff < 0;

      xAxisDiff = xAxisDiff.abs();
      yAxisDiff = yAxisDiff.abs();

      int xStart = neighbour.key.x.toInt();
      int yStart = neighbour.key.y.toInt();

      int xEnd = neighbour.value.x.toInt();
      int yEnd = neighbour.value.y.toInt();

      for (int x = 0; x < xAxisDiff + 1; x++) {
        int xPos = goLeft ? xStart + x : xStart - x;

        if (xPos >= 0 && xPos < rawMap.length) {
          _insertBlob(Vector2(xPos.toDouble(), yStart.toDouble()), rawMap, cols, rows);
        } else {
          print('index out of bounds x: $xPos');
        }
      }

      for (int y = 0; y < yAxisDiff + 1; y++) {
        int yPos = goUp ? yEnd - y : yEnd + y;
        if (yPos >= 0 && yPos < rawMap.length) {
          _insertBlob(Vector2(xEnd.toDouble(), yPos.toDouble()), rawMap, cols, rows);
        } else {
          print('index out of bounds y: $yPos');
        }
      }
    }
  }

  void _patchSingles(List<List<TileModel>> rawMap) {
    for (int x = 0; x < rawMap.length; x++) {
      for (int y = 0; y < rawMap.length; y++) {
        if (x + 1 < rawMap.length &&
            x - 1 >= 0 &&
            isAbyss(rawMap[x][y]) &&
            isFloor(rawMap[x + 1][y]) &&
            isFloor(rawMap[x - 1][y])) {
          rawMap[x + 1][y] = dungeonTileBuilder.buildAbyss(x + 1, y);
        }

        if (y + 1 < rawMap.length &&
            y - 1 >= 0 &&
            isAbyss(rawMap[x][y]) &&
            isFloor(rawMap[x][y + 1]) &&
            isFloor(rawMap[x][y - 1])) {
          rawMap[x][y + 1] = dungeonTileBuilder.buildAbyss(x, y + 1);
        }
      }
    }
  }

  void _trimEdges(List<List<TileModel>> rawMap) {
    rawMap[0] = List.generate(rawMap.length, (index) => dungeonTileBuilder.buildAbyss(0, index));
    rawMap[rawMap.length - 1] = List.generate(
        rawMap.length, (index) => dungeonTileBuilder.buildAbyss(rawMap.length - 1, index));

    for (int x = 0; x < rawMap.length; x++) {
      rawMap[x][0] = dungeonTileBuilder.buildAbyss(x, 0);
      rawMap[x][rawMap.length - 1] = dungeonTileBuilder.buildAbyss(x, rawMap.length - 1);
    }
  }

  bool isAbyss(TileModel model) => model.sprite!.path.contains('abyss');
}
