import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/enemies/goblin_controller.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';
import 'package:hackerspace_game_jam_2023/sprite_sheets/goblin_sprite_sheet.dart';

import '../dungeon/demo_dungeon_map.dart';
import '../sprite_sheets/common_sprite_sheet.dart';
import 'awards.dart';

class Goblin extends SimpleEnemy
    with
        ObjectCollision,
        JoystickListener,
        MovementByJoystick,
        AutomaticRandomMovement,
        UseBarLife,
        awards,
        UseStateController<GoblinController> {
  Goblin(Vector2 position)
      : super(
          animation: GoblinSpriteSheet.goblinSimpleDirectionAnimation,
          position: position,
          size: Vector2.all(48),
          speed: DemoDungeonMap.tileSize * 1.6,
          life: 100,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.circle(radius: 16, align: Vector2(8, 8)),
        ],
      ),
    );

    setupBarLife(
      borderRadius: BorderRadius.circular(2),
      borderWidth: 2,
    );
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

  void execAttackRange(double damage) {
    if (gameRef.player != null && gameRef.player?.isDead == true) return;
    simpleAttackRange(
      animationRight: CommonSpriteSheet.fireBallRight,
      animationDestroy: CommonSpriteSheet.explosionAnimation,
      id: 35,
      size: Vector2.all(width * 0.9),
      damage: damage,
      speed: DemoDungeonMap.tileSize * 3,
      execute: () {
        FlameAudio.play('fireball.wav', volume: 0.6);
      },
      collision: CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2.all(width / 2),
            align: Vector2(width * 0.25, width * 0.25),
          ),
        ],
      ),
      lightingConfig: LightingConfig(
        radius: width / 2,
        blurBorder: width,
        color: Colors.orange.withOpacity(0.3),
      ),
    );
  }

  void execAttack(double damage) {
    if (gameRef.player != null && gameRef.player?.isDead == true) return;
    simpleAttackMelee(
      size: Vector2.all(width),
      damage: damage / 2,
      interval: 400,
      execute: () {
        FlameAudio.play(['ogre1.wav', 'ogre2.wav'].getRandom());
      },
      sizePush: DemoDungeonMap.tileSize / 2,
      animationRight: CommonSpriteSheet.blackAttackEffectRight,
    );
  }

  @override
  void removeLife(double life) {
    FlameAudio.play(['ogre3.wav', 'ogre4.wav', 'ogre5.wav'].getRandom());
    showDamage(
      life,
      config: TextStyle(
        fontSize: width / 3,
        color: Colors.white,
      ),
    );
    super.removeLife(life);
    ColorEffect(Colors.white, Offset(0, 1), EffectController(duration: 0.2));
  }

  @override
  void joystickAction(JoystickActionEvent event) {}

  @override
  void moveTo(Vector2 position) {}

  @override
  double exp() {
    return 5;
  }
}
