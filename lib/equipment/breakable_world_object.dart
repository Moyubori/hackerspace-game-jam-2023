import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

import '../dungeon/builders/dungeon_tile_builder.dart';
import '../dungeon/demo_dungeon_map.dart';
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
    _addSmokeExplosion(position);
  }

  void _addSmokeExplosion(Vector2 position) {
    gameRef.add(
      AnimatedObjectOnce(
        animation: SpriteAnimation.load(
          "smoke_explosin.png",
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
        position: position,
        size: Vector2.all(DemoDungeonMap.tileSize),
      ),
    );
  }
}

class Table extends BreakableWorldObject {
  Table(Vector2 position)
    : super(position,
      Vector2(DungeonTileBuilder.tileSize, DungeonTileBuilder.tileSize),
      "itens/table.png",
      "wooden_break.wav",
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
      "ceramic_break.wav",
      [
        CollisionArea.circle(
            radius: DungeonTileBuilder.tileSize / 3, align: Vector2.all(DungeonTileBuilder.tileSize / 6)),
      ]);
}