import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/enemies/boss/centipede_controller.dart';

import 'package:hackerspace_game_jam_2023/fight/fight.dart';
import 'package:hackerspace_game_jam_2023/overworld/overworld.dart';
import 'package:hackerspace_game_jam_2023/enemies/goblin_controller.dart';

import 'dungeon/dungeon.dart';

void main() async {
  BonfireInjector().putFactory((i) => GoblinController());
  BonfireInjector().putFactory((i) => CentipedeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () => navigatorKey.currentState!.popAndPushNamed('/'),
              child: Text(
                'overworld',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () => navigatorKey.currentState!.popAndPushNamed('/fight'),
              child: Text(
                'fight',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () => navigatorKey.currentState!.popAndPushNamed('/dungeon'),
              child: Text(
                'dungeon',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 100,
            )
          ],
        ),
        body: Navigator(
          key: navigatorKey,
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (_) => Overworld(), settings: settings);
              case '/fight':
                return MaterialPageRoute(builder: (_) => FightSceneWidget(), settings: settings);
              case '/dungeon':
                return MaterialPageRoute(builder: (_) => DungeonWidget(), settings: settings);
            }
          },
        ),
      ),
    );
  }
}