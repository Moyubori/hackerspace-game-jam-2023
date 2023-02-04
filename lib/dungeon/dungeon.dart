import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/content/decoration_factory.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/content/enemy_factory.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_tile_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/random_dungeon_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/file_dungeon_builder.dart';
import 'package:hackerspace_game_jam_2023/enemies/boss/centipede.dart';
import 'package:hackerspace_game_jam_2023/enemies/goblin.dart';
import 'package:hackerspace_game_jam_2023/interface/equipment_info.dart';
import 'package:hackerspace_game_jam_2023/interface/life_bar.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

class DungeonWidget extends StatelessWidget {
  late DungeonBuilder _dungeonBuilder;
  late DungeonMapConfig _mapConfig;

  DungeonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // _dungeonBuilder = FileDungeonBuilder();
    // _mapConfig = FileDungeonMapConfig(
    //   levelFile: 'assets/levels/sampleLevel.png',
    //   startingPos: Vector2(1, 1),
    // );
    _dungeonBuilder = RandomDungeonBuilder();
    _mapConfig = RandomDungeonMapConfig(
      mapSize: 32,
      startingBlobs: 8,
      startingPos: Vector2(16, 16),
      enemyFactory: EnemyFactory()
        ..withEnemy(EnemyDefinition(builder: (pos) => Goblin(pos), spawnProbability: 0.9))
        ..withEnemy(EnemyDefinition(builder: (pos) => Centipede(pos), spawnProbability: 0.1)),
      decorationFactory: DecorationBuilder(),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder<DungeonMap>(
          // future: Future.value(_dungeonBuilder.build(DungeonBuilder.sample)),
          future: _dungeonBuilder.build(_mapConfig),
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
              // constructionMode: true,
              player: MainPlayer(
                Vector2(
                  _mapConfig.startingPos.x * DungeonTileBuilder.tileSize,
                  _mapConfig.startingPos.y * DungeonTileBuilder.tileSize,
                ),
                1500,
              ),
              joystick: Joystick(
                keyboardConfig: KeyboardConfig(keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows),
              ),
              // lightingColorGame: Colors.black,
              // cameraConfig: CameraConfig(zoom: 3),
              interface: GameInterface()
                ..add(LifeBar())
                ..add(EquipmentInfo()),
              enemies: result.enemies,
              decorations: result.decorations,
              map: result.dungeon,
            );
          },
        );
      },
    );
  }
}
