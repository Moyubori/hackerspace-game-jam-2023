import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/dungeon/demo_dungeon_map.dart';
import 'package:hackerspace_game_jam_2023/enemies/goblin/goblin.dart';
import 'package:hackerspace_game_jam_2023/enemies/plaguebearer/plaguebearer.dart';
import 'package:hackerspace_game_jam_2023/interface/equipment_info.dart';
import 'package:hackerspace_game_jam_2023/interface/life_bar.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

import '../interface/exp_info.dart';

class Overworld extends StatelessWidget {
  const Overworld({super.key});

  @override
  Widget build(BuildContext context) {
    MainPlayer player = MainPlayer(
      Vector2((4 * DemoDungeonMap.tileSize), (6 * DemoDungeonMap.tileSize)),
      999999,
    );

    return Stack(
      children: [
        BonfireWidget(
          player: player,
          enemies: [
            Goblin(Vector2(10 * DemoDungeonMap.tileSize, 5 * DemoDungeonMap.tileSize)),
            Plaguebearer(Vector2(6 * DemoDungeonMap.tileSize, 5 * DemoDungeonMap.tileSize))
            // Centipede(Vector2(6 * DemoDungeonMap.tileSize, 5 * DemoDungeonMap.tileSize))
          ],
          joystick: Joystick(
            keyboardConfig: KeyboardConfig(keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows),
          ),
          map: DemoDungeonMap.map(),
          decorations: DemoDungeonMap.decorations(),
          cameraConfig: CameraConfig(zoom: 3),
          // constructionMode: true,
          // showCollisionArea: true,
          interface: GameInterface()
            ..add(LifeBar())
            ..add(EquipmentInfo())
            ..add(ExpInfo()),
        ),
      ],
    );
  }
}

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
        "player/knight_idle_left.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        "player/knight_idle.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        "player/knight_run.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
      "player/knight_run_left.png",
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.1,
        textureSize: Vector2(16, 16),
      ));
}
