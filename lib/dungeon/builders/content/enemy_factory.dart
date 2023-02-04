import 'package:bonfire/bonfire.dart';
import 'package:collection/collection.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/content/dungeon_content_factory.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_tile_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';

typedef EnemyBuilder = Enemy Function(Vector2);

class EnemyDefinition {
  final EnemyBuilder builder;
  final double spawnProbability;

  EnemyDefinition({required this.builder, required this.spawnProbability});
}

class EnemyFactory extends DungeonContentFactory<Enemy> {
  final List<EnemyDefinition> enemyDefinitions = [];

  @override
  List<Enemy> createContent(List<List<TileModel>> rawMap, DungeonMapConfig config) {
    List<Vector2> spawnPoints = [];

    for (int x = 0; x < rawMap.length; x++) {
      for (int y = 0; y < rawMap[x].length; y++) {
        final Vector2 currentPos = Vector2(x.toDouble(), y.toDouble());

        if (isFloor(rawMap[x][y]) && isOutsideSafeSpace(config, currentPos)) {
          if (spawnPoints.isEmpty || _canSpawn(currentPos, spawnPoints, config)) {
            spawnPoints.add(currentPos);
          }
        }
      }
    }

    Map<EnemyDefinition, List<Enemy>> spawnedEnemiesTable = {
      for (var enemyDefinition in enemyDefinitions) enemyDefinition: []
    };

    return spawnPoints
        .map((e) =>
            _spawn(Vector2(e.x * DungeonTileBuilder.tileSize, e.y * DungeonTileBuilder.tileSize), spawnedEnemiesTable))
        .toList();
  }

  void withEnemy(EnemyDefinition def) => enemyDefinitions.add(def);

  /// Determines if nearest enemy is further than configured distance in manhattan metric
  /// @protected
  bool _canSpawn(Vector2 currentPos, List<Vector2> spawnPoints, DungeonMapConfig config) =>
      spawnPoints.none((e) => getManhattanDistance(e, currentPos) < config.enemySpread) &&
      (spawnPoints.length < config.enemiesCount || config.enemiesCount == -1);

  Enemy _spawn(Vector2 position, Map<EnemyDefinition, List<Enemy>> spawnedEnemiesTable) {
    final int totalSpawned =
        spawnedEnemiesTable.values.map((e) => e.length).reduce((value, element) => value + element);

    for (EnemyDefinition builder in spawnedEnemiesTable.keys) {
      final double spawnProbability = spawnedEnemiesTable[builder]!.length / totalSpawned;
      if (spawnProbability <= builder.spawnProbability &&
          spawnedEnemiesTable.length > 1) {
        final Enemy e = builder.builder(position);
        spawnedEnemiesTable[builder]?.add(e);
        return e;
      }
    }

    Enemy e = enemyDefinitions[0].builder(position);
    spawnedEnemiesTable[enemyDefinitions[0]]!.add(e);
    return e;
  }
}
