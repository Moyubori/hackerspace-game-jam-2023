import 'dart:math';
import 'package:bonfire/bonfire.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/equipment/base_item.dart';
import 'package:hackerspace_game_jam_2023/navigation.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

class DungeonGate extends InteractableItem with HasGameRef<BonfireGame> {

  bool _canEnter = false;
  double renderTime = -1;

  static const double maxRenderTime = 100;

  DungeonGate(Vector2 position) : super(position, 'itens/bookshelf.png');

  @override
  bool interact(MainPlayer player) {
    if (!_canEnter) {
      renderTime = 0;
      return true;
    }

    double mapSize = sqrt(gameRef.map.tiles.length);
    nextDungeon((mapSize + mapSize ~/ 2).toInt());
    return false;
  }

  @override
  void update(double dt) {
    _canEnter = gameRef.enemies().isEmpty;
    if (renderTime != -1) {
      renderTime += dt;
    }

    if (renderTime > maxRenderTime) {
      renderTime = -1;
    }

    super.update(dt);
  }

  @override
  void render(Canvas c) {
    if (renderTime != -1 && renderTime < maxRenderTime) {
      var style = const TextStyle(color: Colors.yellow, fontSize: 30);
      TextPaint(style: style).render(c, "Kill enemies first!", Vector2(position.x, position.y - 45));
    }

    super.render(c);
  }
}
