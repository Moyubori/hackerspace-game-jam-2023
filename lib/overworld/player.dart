import 'dart:math' as math;

import 'package:bonfire/bonfire.dart';
import 'package:bonfire/mixins/keyboard_listener.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackerspace_game_jam_2023/dungeon/demo_dungeon_map.dart';
import 'package:hackerspace_game_jam_2023/overworld/ExpManager.dart';
import 'package:hackerspace_game_jam_2023/sprite_sheets/common_sprite_sheet.dart';

import '../equipment/base_item.dart';
import '../equipment/weapon_component.dart';

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

class MainPlayer extends SimplePlayer with ObjectCollision, KeyboardEventListener, Lighting, HasGameRef<BonfireGame> {
  static const double rollDuration = 0.3;
  static const double rollDistance = 100;

  bool _canRoll = true;
  bool _isRolling = false;
  double _rollStartTime = 0;
  double initialHp = 100;
  bool _canAttack = true;
  List<InteractableItem> inventory = List.empty(growable: true);
  double currentExp = 0;
  static int initialLevel = 1;
  int currentLvl = initialLevel;
  double expNeeded = ExpManager.expNeededToNextLevelUp[initialLevel];

  JoystickMoveDirectional currentFacingDirection = JoystickMoveDirectional.MOVE_RIGHT;
  JoystickMoveDirectional _rollingDirection = JoystickMoveDirectional.MOVE_RIGHT;

  late final WeaponComponent weaponComponent;

  MainPlayer(Vector2 position, initialHp)
      : super(
            position: position,
            size: Vector2(32, 32),
            animation: PlayerSpriteSheet.simpleDirectionAnimation,
            life: initialHp) {
    setupCollision(
      CollisionConfig(
        collisions: [CollisionArea.circle(radius: 12, align: Vector2(4, 4))],
      ),
    );

    setupLighting(
      LightingConfig(
        radius: width * 3,
        blurBorder: width * 3,
        color: Colors.deepOrangeAccent.withOpacity(0.2),
      ),
    );
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    weaponComponent = WeaponComponent(this);
    gameRef.add(weaponComponent);
  }

  void roll() {
    _isRolling = true;
    final double originalSpeed = speed;
    speed = 0;
    _rollingDirection = currentFacingDirection;
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
  void die() {
    super.die();
    gameRef.add(
      AnimatedObjectOnce(
        animation: CommonSpriteSheet.smokeExplosion,
        position: position,
        size: Vector2.all(DemoDungeonMap.tileSize),
      ),
    );
    removeFromParent();
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, dynamic identify) {
    if (!_isRolling) {
      super.receiveDamage(attacker, damage, identify);
    }
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    if (event.directional != JoystickMoveDirectional.IDLE) {
      currentFacingDirection = event.directional;
    }
    super.joystickChangeDirectional(event);
  }

  @override
  bool onKeyboard(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.keyJ)) {
      if (_canRoll) {
        _canRoll = false;
        roll();
        add(TimerComponent(period: rollDuration, onTick: () => _canRoll = true));
      }
    }
    if (_canAttack && keysPressed.contains(LogicalKeyboardKey.keyK) && weaponComponent.isEquipped) {
      _canAttack = false;
      weaponComponent.trySwing();
    }
    if (!keysPressed.contains(LogicalKeyboardKey.keyK)) {
      _canAttack = true;
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
    angle = math.pi * value * 2;
  }

  RollAnimationComponent(this.animation);

  @override
  void render(Canvas canvas) {
    animation.getSprite().render(canvas, anchor: Anchor.center, size: Vector2(32, 32));
  }
}
