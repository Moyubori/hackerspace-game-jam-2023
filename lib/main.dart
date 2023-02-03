import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/fight.dart';
import 'package:hackerspace_game_jam_2023/overworld.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // routes: {
      //   '/': (context) => Overworld(),
      //   '/fight': (context) => FightSceneWidget(),
      // },
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
            }
          },
        ),
      ),
    );
  }
}
