import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_builder.dart';
import 'package:hackerspace_game_jam_2023/dungeon/dungeon_map.dart';

void main() {
  runApp(MyApp());
}

List<List<int>> _worldSchema = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0],
    [0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0],
    [0, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0],
    [0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1],
    [0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1],
    [0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1],
    [0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1],
    [0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1],
    [0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1],
    [0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1],
    [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1],
];

class MyApp extends StatelessWidget {

  late DungeonBuilder _dungeonBuilder;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _dungeonBuilder = DungeonBuilder();

    return MaterialApp(
      title: 'Flutter Demo',
      // home: RandomDungeonGame(size: Vector2(150, 150)),
      // home: BonfireWidget(
      //   // map: DungeonMap.map(),
      //   map: _dungeonBuilder.build(_worldSchema),
      // ),
      home: LayoutBuilder(
        builder: (context, constraints) {
          return FutureBuilder<WorldMap>(
            future: _dungeonBuilder.buildFromLevelFile('sampleLevel.png'),
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
                map: result,
              );
            },
          );
        },
      ),
    );
  }
}