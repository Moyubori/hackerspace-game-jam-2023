import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MyGame game = MyGame();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameWidget(game: game),
    );
  }
}

class MyGame extends Forge2DGame {
  @override
  Future<void> onLoad() async {
    final SpriteComponent spriteComponent = SpriteComponent(
      sprite: await Sprite.load('profesor.jpg'),
      size: Vector2(size.x, size.y),
    );
    add(spriteComponent);
  }
}
