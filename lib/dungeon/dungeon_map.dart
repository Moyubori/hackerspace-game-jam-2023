import 'package:bonfire/bonfire.dart';

class DungeonMap {
  final WorldMap dungeon;
  final List<Enemy> enemies;
  final List<GameDecoration> decorations;

  DungeonMap({
    required this.dungeon,
    this.enemies = const [],
    this.decorations = const [],
  });
}

abstract class DungeonMapConfig {
  final Vector2 startingPos;
  final double safeAreaRadius;
  final double enemySpread;
  final int enemiesCount;

  DungeonMapConfig({
    required this.startingPos,
    this.safeAreaRadius = 10.0,
    this.enemySpread = 10.0,
    this.enemiesCount = -1,
  });
}
