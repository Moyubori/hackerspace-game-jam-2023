import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/content/decoration_factory.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/content/enemy_factory.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/content/new_enemy_factory.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/dungeon_tile_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/builders/random_dungeon_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';
import 'package:hackerspace_game_jam_2023/enemies/centipede/centipede.dart';
import 'package:hackerspace_game_jam_2023/enemies/goblin/goblin.dart';
import 'package:hackerspace_game_jam_2023/interface/equipment_info.dart';
import 'package:hackerspace_game_jam_2023/interface/exp_info.dart';
import 'package:hackerspace_game_jam_2023/interface/life_bar.dart';
import 'package:hackerspace_game_jam_2023/main.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

class DungeonWidget extends StatelessWidget {
  final int dungeonSize;

  final FocusNode focusNode = FocusNode();

  late DungeonBuilder _dungeonBuilder;
  late DungeonMapConfig _mapConfig;

  DungeonWidget({super.key, int? dungeonSize}) : dungeonSize = dungeonSize ?? 32;

  @override
  Widget build(BuildContext context) {
    // _dungeonBuilder = FileDungeonBuilder();
    // _mapConfig = FileDungeonMapConfig(
    //   levelFile: 'assets/levels/sampleLevel.png',
    //   startingPos: Vector2(1, 1),
    // );
    _dungeonBuilder = RandomDungeonBuilder();
    _mapConfig = RandomDungeonMapConfig(
      mapSize: dungeonSize,
      startingBlobs: dungeonSize ~/ 4,
      startingPos: Vector2(dungeonSize / 2, dungeonSize / 2),
      enemyFactory: NewEnemyFactory() // EnemyFactory()
        ..withEnemy(EnemyDefinition(builder: (pos) => Goblin(pos), spawnProbability: 0.9))
        ..withEnemy(EnemyDefinition(builder: (pos) => Centipede(pos), spawnProbability: 0.1, size: 3)),
      decorationFactory: DecorationFactory(),
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
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              focusNode.requestFocus();
              if (!FlameAudio.bgm.isPlaying) {
                FlameAudio.bgm.initialize();
                FlameAudio.bgm.play('bgm.ogg');
              }
            });

            return Stack(
              children: [
                BonfireWidget(
                  // constructionMode: true,
                  focusNode: focusNode,
                  player: MainPlayer(
                    Vector2(
                      _mapConfig.startingPos.x * DungeonTileBuilder.tileSize,
                      _mapConfig.startingPos.y * DungeonTileBuilder.tileSize,
                    ),
                    150,
                  ),
                  joystick: Joystick(
                    keyboardConfig: KeyboardConfig(keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows),
                  ),
                  lightingColorGame: Colors.black,
                  cameraConfig: CameraConfig(zoom: 2.5),
                  interface: GameInterface()
                    ..add(LifeBar())
                    ..add(EquipmentInfo())
                    ..add(ExpInfo()),
                  enemies: result.enemies,
                  decorations: result.decorations,
                  map: result.dungeon,
                  overlayBuilderMap: {
                    'miniMap': (context, game) => MiniMap(
                      game: game,
                      margin: EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(10),
                      size: Vector2.all(constraints.maxHeight / 4),
                      border: Border.all(color: Colors.white.withOpacity(0.5)),
                      zoom: 0.5,
                      // backgroundColor: Color(),
                      // tileCollisionColor: Color(),
                      // tileColor: Color(),
                      // playerColor: Color(),
                      // enemyColor: Color(),
                      // npcColor: Color(),
                      // allyColor: Color(),
                      // decorationColor: Color(),
                    ),
                  },
                  initialActiveOverlays: [
                    'miniMap',
                  ],
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: SpriteButton.future(
                    sprite: Sprite.load('button.png'),
                    pressedSprite: Sprite.load('button_click.png'),
                    onPressed: () => navigatorKey.currentState!.popAndPushNamed('/'),
                    width: 292 * 0.5,
                    height: 64 * 0.5,
                    label: Text(
                      'Exit',
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
