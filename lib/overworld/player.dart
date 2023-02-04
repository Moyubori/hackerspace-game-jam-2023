import 'dart:math' as math;

import 'package:bonfire/bonfire.dart';
import 'package:bonfire/mixins/keyboard_listener.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:hackerspace_game_jam_2023/overworld/overworld.dart';

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
        "player/knight_idle_left.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        "player/knight_idle.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        "player/knight_run.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
        "player/knight_run_left.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static SimpleDirectionAnimation get simpleDirectionAnimation => SimpleDirectionAnimation(
        idleRight: idleRight,
        runRight: runRight,
      );
}

class MainPlayer extends SimplePlayer with ObjectCollision, KeyboardEventListener, HasGameRef<BonfireGame> {
  static const double rollDuration = 0.3;
  static const double rollDistance = 100;

  bool _canRoll = true;
  bool _isRolling = false;
  double _rollStartTime = 0;
  JoystickMoveDirectional _currentFacingDirection = JoystickMoveDirectional.IDLE;
  JoystickMoveDirectional _rollingDirection = JoystickMoveDirectional.IDLE;

  MainPlayer(Vector2 position)
      : super(
          position: position,
          size: Vector2(32, 32),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(
              DungeonMap.tileSize / 2,
              DungeonMap.tileSize / 2.2,
            ),
            align: Vector2(
              DungeonMap.tileSize / 3.5,
              DungeonMap.tileSize / 2,
            ),
          )
        ],
      ),
    );
  }

  void roll() {
    _isRolling = true;
    final double originalSpeed = speed;
    speed = 0;
    _rollingDirection = _currentFacingDirection;
    _rollStartTime = gameRef.currentTime();
    add(RollAnimationComponent(animation!.runRight!));
    add(
      TimerComponent(
        period: rollDuration,
        onTick: () {
          _isRolling = false;
          _canRoll = true;
          speed = originalSpeed;
          remove(children.whereType<RollAnimationComponent>().first);
        },
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_isRolling) {
      (children.whereType<RollAnimationComponent>().first).position = position + Vector2(16, 16);
      moveByVector(_rollingDirection.toVector2() * rollDistance / rollDuration);
    }
  }

  @override
  void render(Canvas canvas) {
    if (_isRolling) {
      final double rollingAnimationProgress = (gameRef.currentTime() - _rollStartTime) / rollDuration;
      (children.whereType<RollAnimationComponent>().first).animationProgress = rollingAnimationProgress;
    } else {
      super.render(canvas);
    }
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    if (event.directional != JoystickMoveDirectional.IDLE) {
      _currentFacingDirection = event.directional;
    }
    super.joystickChangeDirectional(event);
  }

  @override
  bool onKeyboard(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      if (_canRoll) {
        _canRoll = false;
        roll();
        add(TimerComponent(period: rollDuration, onTick: () => _canRoll = true));
      }
    }
    return super.onKeyboard(event, keysPressed);
  }
}

extension DirectionToVector on JoystickMoveDirectional {
  static const double sin45deg = 0.70710678118;

  Vector2 toVector2() {
    switch (this) {
      case JoystickMoveDirectional.MOVE_UP:
        return Vector2(0.0, -1.0);
      case JoystickMoveDirectional.MOVE_UP_LEFT:
        return Vector2(-sin45deg, -sin45deg);
      case JoystickMoveDirectional.MOVE_UP_RIGHT:
        return Vector2(sin45deg, -sin45deg);
      case JoystickMoveDirectional.MOVE_RIGHT:
        return Vector2(1.0, 0.0);
      case JoystickMoveDirectional.MOVE_DOWN:
        return Vector2(0.0, 1.0);
      case JoystickMoveDirectional.MOVE_DOWN_RIGHT:
        return Vector2(1.0, sin45deg);
      case JoystickMoveDirectional.MOVE_DOWN_LEFT:
        return Vector2(-sin45deg, sin45deg);
      case JoystickMoveDirectional.MOVE_LEFT:
        return Vector2(-1.0, 0.0);
      case JoystickMoveDirectional.IDLE:
        return Vector2(0.0, 0.0);
    }
  }
}

class RollAnimationComponent extends PositionComponent {
  final SpriteAnimation animation;

  set animationProgress(double value) {
    // animation.update(value);
    angle = math.pi * value * 2;
  }

  RollAnimationComponent(this.animation);

  @override
  Future<void> onLoad() async {}

  @override
  void render(Canvas canvas) {
    animation.getSprite().render(canvas, anchor: Anchor.center, size: Vector2(32, 32));
  }
}
