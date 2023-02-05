import 'package:bonfire/bonfire.dart';
import 'package:collection/collection.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/content/dungeon_content_factory.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/content/enemy_factory.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_tile_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';

class NewEnemyFactory extends DungeonContentFactory<Enemy> {
  final List<EnemyDefinition> enemyDefinitions = [];

  @override
  List<Enemy> createContent(
      List<List<TileModel>> rawMap, DungeonMapConfig config, List<Vector2> takenSpots) {
    Map<EnemyDefinition, List<Vector2>> enemySpawnPoints = {
      for (var enemyDefinition in enemyDefinitions) enemyDefinition: []
    };

    List<Vector2> spawnPoints = [];

    int totalSpawned = 0;

    try {
      for (int x = 0; x < rawMap.length; x++) {
        for (int y = 0; y < rawMap[x].length; y++) {
          final Vector2 currentPos = Vector2(x.toDouble(), y.toDouble());

          if (isFloor(rawMap[x][y]) && isOutsideSafeSpace(config, currentPos)) {
            if ((spawnPoints.isEmpty || _canSpawn(currentPos, spawnPoints, config)) &&
                !isTaken(currentPos, takenSpots)) {
              for (EnemyDefinition builder in enemySpawnPoints.keys) {
                if (!_hasEnoughSpace(builder.size, rawMap, x, y)) {
                  continue;
                }

                if (takenSpots
                    .where((element) => getManhattanDistance(currentPos, element) < builder.size + 1)
                    .isNotEmpty) {
                  continue;
                }

                final double spawnProbability = enemySpawnPoints[builder]!.length / totalSpawned;
                if (spawnProbability <= builder.spawnProbability && enemySpawnPoints.length > 1) {
                  spawnPoints.add(currentPos);
                  enemySpawnPoints[builder]!.add(currentPos);
                  takenSpots.add(currentPos);
                  totalSpawned++;
                  continue;
                }
              }

              spawnPoints.add(currentPos);
              enemySpawnPoints[enemyDefinitions[0]]!.add(currentPos);
              takenSpots.add(currentPos);
              totalSpawned++;
            }
          }
        }
      }
    } catch (exception, stackTrace) {
      print(exception);
    }

    return enemySpawnPoints.entries
        .map((entry) => entry.value.map((pos) => entry.key.builder(
            Vector2(pos.x * DungeonTileBuilder.tileSize, pos.y * DungeonTileBuilder.tileSize))))
        .expand((e) => e)
        .toList();
  }

  void withEnemy(EnemyDefinition def) => enemyDefinitions.add(def);

  /// Determines if nearest enemy is further than configured distance in manhattan metric
  /// @protected
  bool _canSpawn(Vector2 currentPos, List<Vector2> spawnPoints, DungeonMapConfig config) =>
      spawnPoints.none((e) => getManhattanDistance(e, currentPos) < config.enemySpread) &&
      (spawnPoints.length < config.enemiesCount || config.enemiesCount == -1);

  bool _hasEnoughSpace(int enemySize, List<List<TileModel>> rawMap, int posx, int posy) {
    try {
      for (int x = 0; x < enemySize; x++) {
        for (int y = 0; y < enemySize; y++) {
          if (!isFloor(rawMap[posx + x][posy + y])) {
            return false;
          }
        }
      }

      return true;
    } catch (ex) {
      return false;
    }
  }
}
