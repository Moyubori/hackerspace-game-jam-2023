import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flame/components.dart';
import 'package:hackerspace_game_jam_2023/equipment/base_item.dart';
import 'package:hackerspace_game_jam_2023/navigation.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

class DungeonGate extends InteractableItem with HasGameRef<BonfireGame> {

  DungeonGate(Vector2 position) : super(position, 'itens/bookshelf.png');

  @override
  bool interact(MainPlayer player) {
    double mapSize = sqrt(gameRef.map.tiles.length);
    nextDungeon((mapSize + mapSize ~/ 2).toInt());
    return false;
  }

}