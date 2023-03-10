import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/dungeon/demo_dungeon_map.dart';
import 'package:hackerspace_game_jam_2023/enemies/centipede/centipede_controller.dart';
import 'package:hackerspace_game_jam_2023/enemies/centipede/centipede_sprite_sheet.dart';
import 'package:hackerspace_game_jam_2023/enemies/common/common_sprite_sheet.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

import '../awards.dart';

class Centipede extends SimpleEnemy
    with
        ObjectCollision,
        JoystickListener,
        MovementByJoystick,
        AutomaticRandomMovement,
        UseBarLife,
        awards,
        UseStateController<CentipedeController> {
  late final SpriteAnimation attackAnimation;

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
            size: Vector2(64, 64),
            align: Vector2(32, 32),
          ),
          CollisionArea.circle(radius: 32, align: Vector2(0, 32)),
          CollisionArea.circle(radius: 32, align: Vector2(64, 32))
        ],
      ),
    );

    setupBarLife(
      borderRadius: BorderRadius.circular(2),
      borderWidth: 4,
    );

    CentipedeSpriteSheet.centipedeAttack.then((value) => attackAnimation = value);
  }

  @override
  void die() {
    super.die();
    FlameAudio.play('mnstr7.wav');
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
    if ((gameRef.player != null && gameRef.player?.isDead == true) ||
        children.whereType<CentipedeAttackAnimationComponent>().isNotEmpty) return;
    simpleAttackMelee(
      size: Vector2.all(72),
      damage: damage / 2,
      interval: 400,
      withPush: true,
      sizePush: 48,
      animationRight: CommonSpriteSheet.blackAttackEffectRight,
      execute: () {
        FlameAudio.play(['giant1.wav', 'giant2.wav', 'giant3.wav'].getRandom());
        add(CentipedeAttackAnimationComponent(attackAnimation.clone()));
      },
    );
  }

  @override
  void render(Canvas canvas) {
    if (children.where((element) => element is CentipedeAttackAnimationComponent).isEmpty) {
      super.render(canvas);
    }
  }

  @override
  void removeLife(double life) {
    FlameAudio.play(['giant4.wav', 'giant5.wav'].getRandom());
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
    return 50;
  }
}

class CentipedeAttackAnimationComponent extends PositionComponent {
  final SpriteAnimation animation;

  CentipedeAttackAnimationComponent(this.animation);

  @override
  Future<void> onLoad() async {
    scale = Vector2.all(2.5);
    animation.loop = false;
    animation.completed.then((_) {
      removeFromParent();
    });
  }

  @override
  void render(Canvas canvas) {
    animation.getSprite().render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    animation.update(dt);
    position = (parent as Centipede).position - Vector2(52, 86);
  }
}
