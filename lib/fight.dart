import 'package:bonfire/bonfire.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class FightSceneWidget extends StatelessWidget {
  const FightSceneWidget({super.key});

  @override
  Widget build(BuildContext context) => GameWidget(game: FightScene());
}

class FightScene extends FlameGame {
  @override
  Future<void> onLoad() async {
    add(SpriteComponent(sprite: await Sprite.load('profesor.jpg')));
  }
}
