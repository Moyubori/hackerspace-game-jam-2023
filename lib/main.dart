import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/enemies/boss/centipede_controller.dart';
import 'package:hackerspace_game_jam_2023/enemies/goblin_controller.dart';
import 'package:hackerspace_game_jam_2023/fight/fight.dart';
import 'package:hackerspace_game_jam_2023/overworld/overworld.dart';

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
      home: Navigator(
        key: navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                  builder: (_) => Scaffold(
                        body: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage('images/menu_art.jpg'),
                            ),
                          ),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () => navigatorKey.currentState!.popAndPushNamed('/overworld'),
                              child: Text('Start!'),
                            ),
                          ),
                        ),
                      ),
                  settings: settings);
            case '/overworld':
              return MaterialPageRoute(builder: (_) => Overworld(), settings: settings);
            case '/fight':
              return MaterialPageRoute(builder: (_) => FightSceneWidget(), settings: settings);
            case '/dungeon':
              return MaterialPageRoute(builder: (_) => DungeonWidget(), settings: settings);
          }
        },
      ),
    );
  }
}
