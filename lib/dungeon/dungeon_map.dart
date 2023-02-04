import 'package:bonfire/bonfire.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/content/dungeon_content_factory.dart';

class DungeonMap {
  final WorldMap dungeon;
  final List<Enemy> enemies;
  final List<GameDecoration> decorations;
  final Vector2? gatePos;

  DungeonMap({
    required this.dungeon,
    this.enemies = const [],
    this.decorations = const [],
    this.gatePos,
  });
}

abstract class DungeonMapConfig {
  final Vector2 startingPos;
  final double safeAreaRadius;
  final double enemySpread;
  final int enemiesCount;
  final DungeonContentFactory<Enemy>? enemyFactory;
  final DungeonContentFactory<GameDecoration>? decorationFactory;

  DungeonMapConfig({
    required this.startingPos,
    this.enemyFactory,
    this.decorationFactory,
    this.safeAreaRadius = 10.0,
    this.enemySpread = 10.0,
    this.enemiesCount = -1,
  });
}
