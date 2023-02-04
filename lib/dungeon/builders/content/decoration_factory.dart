import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:collection/collection.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/content/dungeon_content_factory.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_decoration_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';

class DecorationBuilder extends DungeonContentFactory<GameDecoration> {
  @override
  List<GameDecoration> createContent(List<List<TileModel>> rawMap, DungeonMapConfig config) {
    final DungeonDecorationBuilder decorationBuilder = DungeonDecorationBuilder();
    final Random r = Random();
    List<Vector2> decorationPositions = [];

    for (int x = 0; x < rawMap.length; x++) {
      for (int y = 0; y < rawMap.length; y++) {
        final Vector2 currentPos = Vector2(x.toDouble(), y.toDouble());

        if (isFloor(rawMap[x][y]) &&
            r.nextInt(10) < 3 &&
            decorationPositions.none((p) => getManhattanDistance(p, currentPos) < 10)) {
          decorationPositions.add(currentPos);
        }
      }
    }

    return decorationPositions.map((e) => decorationBuilder.buildRandom(e.x.toInt(), e.y.toInt())).toList();
  }

}