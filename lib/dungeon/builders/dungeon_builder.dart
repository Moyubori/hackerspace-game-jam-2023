import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/content/dungeon_decoration_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/tile_helpers.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_gate.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_tile_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/torch.dart';

abstract class DungeonBuilder with TileHelpers {
  @protected
  DungeonTileBuilder dungeonTileBuilder = DungeonTileBuilder();

  Future<DungeonMap> build(covariant DungeonMapConfig config) async {
    List<List<TileModel>> rawMap = await buildPaths(config);
    List<Vector2> takenSpots = [config.startingPos];

    buildWalls(rawMap);

    List<GameDecoration> decorations = buildDecorations(config, rawMap, takenSpots);
    List<Enemy> enemies = config.enemyFactory?.createContent(rawMap, config, takenSpots) ?? [];

    return DungeonMap(
      dungeon: WorldMap(rawMap.expand((line) => line).toList()),
      enemies: enemies,
      decorations: decorations,
    );
  }

  List<GameDecoration> buildDecorations(
      DungeonMapConfig config, List<List<TileModel>> rawMap, List<Vector2> takenSpots) {
    Vector2? gatePos = chooseGatePosition(rawMap, config);
    if (gatePos != null) {
      takenSpots.add(gatePos);
    }

    List<GameDecoration> decorations =
        config.decorationFactory?.createContent(rawMap, config, takenSpots) ?? [];
    if (gatePos != null) {
      decorations.add(DungeonGate(DungeonDecorationBuilder.getRelativeTilePosition(
        gatePos.x.toInt(),
        gatePos.y.toInt(),
      )));
    }
    buildTorches(decorations, rawMap);
    return decorations;
  }

  Future<List<List<TileModel>>> buildPaths(covariant DungeonMapConfig config);

  @protected
  void buildWalls(List<List<TileModel>> rawMap) {
    for (int x = 0; x < rawMap.length; x++) {
      for (int y = 0; y < rawMap[x].length; y++) {
        if (isFloor(rawMap[x][y])) {
          continue;
        }

        if (x - 1 >= 0 && isFloor(rawMap[x - 1][y])) {
          if (y - 1 > 0 && isFloor(rawMap[x][y - 1])) {
            rawMap[x][y] = dungeonTileBuilder.buildWallLeftAndTop(x, y);
          } else if (y + 1 < rawMap[x].length && isFloor(rawMap[x][y + 1])) {
            // rawMap[x][y] = dungeonTileBuilder.buildWallRightAndBottom(x, y);
            rawMap[x][y] = dungeonTileBuilder.buildWall(x, y);
          } else {
            rawMap[x][y] = dungeonTileBuilder.buildWallRight(x, y);
          }
          continue;
        }

        if (x + 1 < rawMap.length && isFloor(rawMap[x + 1][y])) {
          if (y - 1 > 0 && isFloor(rawMap[x][y - 1])) {
            rawMap[x][y] = dungeonTileBuilder.buildWallTurnLeftTop(x, y);
          } else if (y + 1 < rawMap[x].length && isFloor(rawMap[x][y + 1])) {
            // rawMap[x][y] = dungeonTileBuilder.buildWallLeftAndBottom(x, y);
            rawMap[x][y] = dungeonTileBuilder.buildWall(x, y);
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
          // rawMap[x][y] = dungeonTileBuilder.buildWallBottom(x, y);
          rawMap[x][y] = dungeonTileBuilder.buildWall(x, y);
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

  void buildTorches(List<GameDecoration> decorations, List<List<TileModel>> rawMap) {
    List<Vector2> torchPositions = [];

    for (int x = 0; x < rawMap.length; x++) {
      for (int y = 0; y < rawMap[x].length; y++) {
        final Vector2 currentPos = Vector2(x.toDouble(), y.toDouble());

        if (isWall(rawMap[x][y]) &&
            torchPositions.none((tp) => getManhattanDistance(tp, currentPos) < 20)) {
          torchPositions.add(currentPos);
        }
      }
    }

    decorations.addAll(
        torchPositions.map((e) => Torch(DungeonDecorationBuilder.getRelativeTilePosition(
              e.x.toInt(),
              e.y.toInt(),
            ))));
  }

  Vector2? chooseGatePosition(List<List<TileModel>> rawMap, covariant DungeonMapConfig config) =>
      null;
}
