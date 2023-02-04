import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

class LifeBar extends InterfaceComponent {
  double padding = 20;
  double widthBar = 116;
  double strokeWidth = 20;
  double maxLife = 0;
  double life = 0;

  LifeBar() : super(
    id: 1,
    position: Vector2(0, 0),
    spriteUnselected: Sprite.load('health_bar_knight.png'),
    size: Vector2(206, 72)
  );

  @override
  void update(double t) {
    if (this.gameRef.player != null) {
      life = this.gameRef.player!.life;
      maxLife = this.gameRef.player!.maxLife;
    }
    super.update(t);
  }

  @override
  void render(Canvas c) {
    try {
      _drawLife(c);
    } catch (e) {}
    super.render(c);
  }

  void _drawLife(Canvas canvas) {
    double xBar = 84;
    double yBar = 12;
    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + widthBar, yBar),
        Paint()
          ..color = Colors.blueGrey[800]!
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);

    double currentBarLife = (life * widthBar) / maxLife;

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + currentBarLife, yBar),
        Paint()
          ..color = _getColorLife(currentBarLife)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);
  }

  Color _getColorLife(double currentBarLife) {
    if (currentBarLife > widthBar - (widthBar / 3)) {
      return Colors.green;
    }
    if (currentBarLife > (widthBar / 3)) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}