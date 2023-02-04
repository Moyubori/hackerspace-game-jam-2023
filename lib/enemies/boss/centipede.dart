import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/dungeon/demo_dungeon_map.dart';
import 'package:hackerspace_game_jam_2023/enemies/boss/centipede_controller.dart';
import 'package:hackerspace_game_jam_2023/sprite_sheets/centipede_sprite_sheet.dart';
import 'package:hackerspace_game_jam_2023/sprite_sheets/common_sprite_sheet.dart';

class Centipede extends SimpleEnemy
    with
        ObjectCollision,
        JoystickListener,
        MovementByJoystick,
        AutomaticRandomMovement,
        UseBarLife,
        UseStateController<CentipedeController> {
  Centipede(Vector2 position)
      : super(
          animation: CentipedeSpriteSheet.centipedeSimpleDirectionAnimation,
          position: position,
          size: Vector2(128, 96),
          speed: DemoDungeonMap.tileSize * 0.8,
          life: 1000,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(
              DemoDungeonMap.tileSize * 0.4,
              DemoDungeonMap.tileSize * 0.4,
            ),
            align: Vector2(
              DemoDungeonMap.tileSize * 0.2,
              DemoDungeonMap.tileSize * 0.2,
            ),
          ),
        ],
      ),
    );

    setupBarLife(
      borderRadius: BorderRadius.circular(2),
      borderWidth: 4,
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
      sizePush: DemoDungeonMap.tileSize / 2,
      animationRight: CommonSpriteSheet.blackAttackEffectRight,
    );
  }

  @override
  void removeLife(double life) {
    showDamage(
      life,
      config: TextStyle(
        fontSize: width / 3,
        color: Colors.white,
      ),
    );
    super.removeLife(life);
  }

  @override
  void joystickAction(JoystickActionEvent event) {}

  @override
  void moveTo(Vector2 position) {}
}
