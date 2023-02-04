import 'package:bonfire/bonfire.dart';

class TileHelpers {

  double getManhattanDistance(Vector2 p1, Vector2 p2) => (p1.x - p2.x).abs() + (p1.y - p2.y).abs();

  bool isFloor(TileModel? model) {
    if (model == null) return false;
    return model.sprite!.path.contains('floor');
  }

  bool isAbyss(TileModel model) => model.sprite!.path.contains('abyss');
}