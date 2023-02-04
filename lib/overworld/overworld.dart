import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/dungeon/demo_dungeon_map.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

import '../enemies/goblin.dart';
import '../interface/life_bar.dart';

class Overworld extends StatelessWidget {
  const Overworld({super.key});

  @override
  Widget build(BuildContext context) {
    MainPlayer player = MainPlayer(
      Vector2((4 * DemoDungeonMap.tileSize), (6 * DemoDungeonMap.tileSize)),
      100,
    );

    return Stack(
      children: [
        BonfireWidget(
          player: player,
          enemies: [Goblin(Vector2(6 * DemoDungeonMap.tileSize, 8 * DemoDungeonMap.tileSize))],
          joystick: Joystick(
            keyboardConfig: KeyboardConfig(),
          ),
          map: DemoDungeonMap.map(),
          decorations: DemoDungeonMap.decorations(),
          cameraConfig: CameraConfig(zoom: 3),
          interface: GameInterface()..add(LifeBar()),
        ),
      ],
    );
  }
}
// Positioned(child: Text("HP: ${player.life}", style: TextStyle(color: Colors.yellow)
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

