import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';
import 'package:hackerspace_game_jam_2023/dungeon/file_dungeon_builder.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

class DungeonWidget extends StatelessWidget {
  late DungeonBuilder _dungeonBuilder;

  DungeonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    _dungeonBuilder = FileDungeonBuilder();

    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder<DungeonMap>(
          // future: Future.value(_dungeonBuilder.build(DungeonBuilder.sample)),
          future: _dungeonBuilder.build(DungeonMapConfig(
            levelFile: 'assets/levels/sampleLevel.png',
            startingPos: Vector2(1, 1),
          )),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Material(
                color: Colors.black,
                child: Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }
            DungeonMap result = snapshot.data!;
            return BonfireWidget(
              player: MainPlayer(
                Vector2(45, 45),
                150,
              ),
              joystick: Joystick(
                keyboardConfig:
                    KeyboardConfig(keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows),
              ),
              lightingColorGame: Colors.black,
              cameraConfig: CameraConfig(zoom: 3),
              enemies: result.enemies,
              map: result.dungeon,
            );
          },
        );
      },
    );
  }
}
