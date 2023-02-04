import 'package:bonfire/bonfire.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/tile_helpers.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';

abstract class DungeonContentFactory<T> with TileHelpers {

  List<T> createContent(List<List<TileModel>> rawMap, DungeonMapConfig config);

  bool isOutsideSafeSpace(DungeonMapConfig config, Vector2 currentPos) {
    return getManhattanDistance(config.startingPos, currentPos) > config.safeAreaRadius;
  }

}