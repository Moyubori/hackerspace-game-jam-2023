import 'package:bonfire/bonfire.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';

class StaticDungeonBuilder extends DungeonBuilder {

  static List<List<int>> sample = [
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 0, 0, 0, 1, 0, 0, 0, 1],
    [1, 0, 0, 0, 1, 0, 0, 0, 1],
    [1, 0, 0, 1, 1, 1, 0, 0, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 0, 0, 1, 1, 1, 0, 0, 1],
    [1, 0, 0, 0, 1, 0, 0, 0, 1],
    [1, 0, 0, 0, 1, 0, 0, 0, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
  ];

  @override
  Future<DungeonMap> build(DungeonMapConfig config) async {
    List<List<TileModel>> rawMap = [];

    for (int y = 0; y < sample.length; y++) {
      List<int> column = sample[y];
      List<TileModel> tiles = [];
      for (int x = 0; x < column.length; x++) {
        tiles.add(column[x] == 0
            ? dungeonTileBuilder.buildAbyss(x, y)
            : dungeonTileBuilder.buildFloor(x, y));
      }
      rawMap.add(tiles);
    }

    decorate(rawMap);

    return DungeonMap(dungeon: WorldMap(rawMap.expand((tiles) => tiles).toList()));
  }

}