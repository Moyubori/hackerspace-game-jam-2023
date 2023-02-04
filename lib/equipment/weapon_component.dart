import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flame/components.dart';
import 'dart:math' as math;

import '../overworld/player.dart';

class WeaponComponent extends SpriteComponent with HasGameRef<BonfireGame> {
  late double swingDuration;
  late double dmg;
  static const double normalDamping = 0.3;
  static const double swingingDamping = 3;
  static const double firstPositionAngularPosition = 1.5;
  static const double secondPositionAngularPosition = 0.5;

  final MainPlayer player;

  bool _inSecondPosition = false;
  bool _isSwinging = false;
  double _swingingStartTime = 0;
  bool isEquipped = false;
  late Sprite axe;
  late Sprite sword;

  WeaponComponent(this.player) : super(priority: 999);

  @override
  Future<void> onLoad() async {
    axe = await Sprite.load('axe.png');
    sword = await Sprite.load('axe.png');
    sprite = axe;
    size = Vector2(32, 32);
    anchor = Anchor.center;
    position = player.position;
  }

  @override
  void render(Canvas c) {
    if(!isEquipped) {
      return;
    }
    else {
      super.render(c);
    }
  }


  @override
  void update(double dt) {
    super.update(dt);
    if (!_isSwinging) {
      final Vector2 targetWeaponDirection = player.currentFacingDirection.toVector2()
        ..rotate((_inSecondPosition ? secondPositionAngularPosition : firstPositionAngularPosition) * math.pi);
      final Vector2 targetPosition = player.position + Vector2(16, 16) + targetWeaponDirection * 32;
      position.lerp(
        targetPosition,
        dt * position.distanceTo(targetPosition) * (_isSwinging ? swingingDamping : normalDamping),
      );
    } else {
      final double swingProgress = (gameRef.currentTime() - _swingingStartTime) / swingDuration;
      final Vector2 targetPosition = player.currentFacingDirection.toVector2()
        ..rotate(((_inSecondPosition
            ? secondPositionAngularPosition - firstPositionAngularPosition
            : firstPositionAngularPosition - secondPositionAngularPosition) *
            swingProgress +
            (_inSecondPosition ? secondPositionAngularPosition : firstPositionAngularPosition)) *
            math.pi);
      position = player.position + Vector2(16, 16) + targetPosition * 32;
    }
  }

  void trySwing() {
    if (!_isSwinging) {
      _isSwinging = true;
      _swingingStartTime = gameRef.currentTime();
      add(
        TimerComponent(
          period: swingDuration,
          onTick: () {
            _isSwinging = false;
            _inSecondPosition = !_inSecondPosition;
          },
        ),
      );
    }
  }
}