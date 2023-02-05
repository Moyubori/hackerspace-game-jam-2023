import 'package:bonfire/bonfire.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_tile_builder.dart';

class TileHelpers {

  double getManhattanDistance(Vector2 p1, Vector2 p2) => (p1.x - p2.x).abs() + (p1.y - p2.y).abs();

  bool isFloor(TileModel? model) {
    if (model == null) return false;
    return model.sprite!.path.contains('floor');
  }

  bool isAbyss(TileModel model) => model.sprite!.path.contains('abyss');

  bool isWall(TileModel model) => model.sprite!.path == DungeonTileBuilder.wall;

  bool isWallTop(TileModel model) => model.sprite!.path == DungeonTileBuilder.wallTop;

  bool isWallBottom(TileModel model) => model.sprite!.path == DungeonTileBuilder.wallBottom;
}