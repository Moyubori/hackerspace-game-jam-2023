import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

import '../dungeon/builders/dungeon_tile_builder.dart';
import '../overworld/base_map_item.dart';

abstract class BreakableWorldObject extends MapObject {
  String breakSound;
  BreakableWorldObject(Vector2 position, Vector2 size, String sprite, this.breakSound, List<CollisionArea> collisions)
      : super.breakable(position, size, sprite, collisions);

  @override
  void onPlayerTouched(MainPlayer player) {
    if(player.isRolling) {
      breakObject();
    }
  }

  void breakObject() {
    FlameAudio.play(breakSound);
    removeFromParent();
  }
}

class Table extends BreakableWorldObject {
  Table(Vector2 position)
    : super(position,
      Vector2(DungeonTileBuilder.tileSize, DungeonTileBuilder.tileSize),
      "itens/table.png",
      "wooden_break.mp3",
      [
        CollisionArea.circle(
            radius: DungeonTileBuilder.tileSize * 0.4, align: Vector2.all(DungeonTileBuilder.tileSize * 0.1)),
      ]);
}

class Barrel extends BreakableWorldObject {
  Barrel(Vector2 position)
      : super(position,
      Vector2(DungeonTileBuilder.tileSize, DungeonTileBuilder.tileSize),
      "itens/barrel.png",
      "wooden_break.mp3",
      [
        CollisionArea.circle(
            radius: DungeonTileBuilder.tileSize / 3, align: Vector2.all(DungeonTileBuilder.tileSize / 6)),
      ]);
}