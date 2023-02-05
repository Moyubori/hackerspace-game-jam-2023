import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/enemies/centipede/centipede_controller.dart';
import 'package:hackerspace_game_jam_2023/enemies/goblin/goblin_controller.dart';
import 'package:hackerspace_game_jam_2023/enemies/plaguebearer/plaguebearer_controller.dart';
import 'package:hackerspace_game_jam_2023/fight/fight.dart';
import 'package:hackerspace_game_jam_2023/overworld/overworld.dart';

import 'dungeon/dungeon.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() async {
  BonfireInjector().putFactory((i) => GoblinController());
  BonfireInjector().putFactory((i) => CentipedeController());
  BonfireInjector().putFactory((i) => PlaguebearerController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Navigator(
        key: navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                  builder: (_) => Scaffold(
                        body: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: NetworkImage(
                                  'https://raw.githubusercontent.com/Moyubori/ggj2023.github.io/main/assets/assets/images/menu_art.jpg'),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Spacer(),
                              Column(
                                children: [
                                  const Spacer(
                                    flex: 2,
                                  ),
                                  Image.network(
                                      'https://raw.githubusercontent.com/Moyubori/ggj2023.github.io/main/assets/assets/images/logo.png'),
                                  Image.network(
                                      'https://raw.githubusercontent.com/Moyubori/ggj2023.github.io/main/assets/assets/images/controls.png'),
                                  const SizedBox(height: 10),
                                  SpriteButton.future(
                                    sprite: Sprite.load('button.png'),
                                    pressedSprite: Sprite.load('button_click.png'),
                                    onPressed: () => navigatorKey.currentState!.popAndPushNamed('/dungeon'),
                                    width: 292,
                                    height: 64,
                                    label: Text(
                                      'Start!',
                                      style: TextStyle(fontSize: 36, color: Colors.white70),
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 2,
                                  ),
                                ],
                              ),
                              const Spacer(
                                flex: 9,
                              ),
                            ],
                          ),
                        ),
                      ),
                  settings: settings);
            case '/gameover':
              return MaterialPageRoute(
                  builder: (_) => Scaffold(
                        body: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: NetworkImage(
                                  'https://raw.githubusercontent.com/Moyubori/ggj2023.github.io/main/assets/assets/images/background.jpg'),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                const Spacer(),
                                Image.asset(
                                    'https://raw.githubusercontent.com/Moyubori/ggj2023.github.io/main/assets/assets/images/gameover.gif'),
                                const Spacer(),
                                Image.asset(
                                  'https://raw.githubusercontent.com/Moyubori/ggj2023.github.io/main/assets/assets/images/skeletal.png',
                                  scale: 0.5,
                                ),
                                const Spacer(),
                                SpriteButton.future(
                                  sprite: Sprite.load('button.png'),
                                  pressedSprite: Sprite.load('button_click.png'),
                                  onPressed: () => navigatorKey.currentState!.popAndPushNamed('/'),
                                  width: 292,
                                  height: 64,
                                  label: Text(
                                    'Back to Main Menu',
                                    style: TextStyle(fontSize: 24, color: Colors.white70),
                                  ),
                                ),
                                const Spacer(),
                              ],
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
