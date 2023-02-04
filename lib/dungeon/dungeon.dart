import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_builder.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

class DungeonWidget extends StatelessWidget {

  late DungeonBuilder _dungeonBuilder;

  DungeonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    _dungeonBuilder = DungeonBuilder();

    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder<WorldMap>(
          // future: Future.value(_dungeonBuilder.build(DungeonBuilder.sample)),
          future: _dungeonBuilder.buildFromFile('sampleLevel.png'),
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
            WorldMap result = snapshot.data!;
            return BonfireWidget(
              player: MainPlayer(
                Vector2(45,45),
                150,
              ),
              joystick: Joystick(
                keyboardConfig: KeyboardConfig(keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows),
              ),
              lightingColorGame: Colors.black,
              map: result,
            );
          },
        );
      },
    );
  }

}