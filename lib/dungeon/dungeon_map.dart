import 'package:bonfire/bonfire.dart';

class DungeonMap {
  final WorldMap dungeon;
  final List<Enemy> enemies;

  DungeonMap({
    required this.dungeon,
    this.enemies = const [],
  });
}

class DungeonMapConfig {
  final String levelFile;
  final Vector2 startingPos;
  final double safeAreaRadius;
  final double enemySpread;
  final int enemiesCount;

  DungeonMapConfig({
    required this.levelFile,
    required this.startingPos,
    this.safeAreaRadius = 10.0,
    this.enemySpread = 10.0,
    this.enemiesCount = -1,
  });
}
