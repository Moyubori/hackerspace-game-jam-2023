import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:hackerspace_game_jam_2023/dungeon/demo_dungeon_map.dart';
import 'package:hackerspace_game_jam_2023/enemies/common/common_sprite_sheet.dart';
import 'package:hackerspace_game_jam_2023/enemies/plaguebearer/plaguebearer_controller.dart';
import 'package:hackerspace_game_jam_2023/enemies/plaguebearer/plaguebearer_sprite_sheet.dart';

import '../awards.dart';

class Plaguebearer extends SimpleEnemy
    with
        ObjectCollision,
        JoystickListener,
        MovementByJoystick,
        AutomaticRandomMovement,
        UseBarLife,
        awards,
        UseStateController<PlaguebearerController> {
  late final SpriteAnimation attackAnimation;

  Plaguebearer(Vector2 position)
      : super(
          animation: PlaguebearerSpriteSheet.plaguebearerSimpleDirectionAnimation,
          position: position,
          size: Vector2(72, 72),
          speed: DemoDungeonMap.tileSize * 0.8,
          life: 400,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.circle(radius: 32, align: Vector2(16, 16)),
          CollisionArea.circle(radius: 32, align: Vector2(0, 16))
        ],
      ),
    );

    setupBarLife(
      borderRadius: BorderRadius.circular(2),
      borderWidth: 4,
    );

    PlaguebearerSpriteSheet.plaguebearerAttack.then((value) => attackAnimation = value);
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

  void execAttack(double damage) {
    if ((gameRef.player != null && gameRef.player?.isDead == true) ||
        children.whereType<PlaguebearerAttackAnimationComponent>().isNotEmpty) return;
    simpleAttackMelee(
      size: Vector2.all(72),
      damage: damage / 2,
      interval: 400,
      withPush: true,
      sizePush: DemoDungeonMap.tileSize / 2,
      animationRight: CommonSpriteSheet.blackAttackEffectRight,
      execute: () {
        add(PlaguebearerAttackAnimationComponent(attackAnimation.clone()));
      },
    );
  }

  @override
  void render(Canvas canvas) {
    if (children.where((element) => element is PlaguebearerAttackAnimationComponent).isEmpty) {
      super.render(canvas);
    }
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

class PlaguebearerAttackAnimationComponent extends PositionComponent {
  final SpriteAnimation animation;

  PlaguebearerAttackAnimationComponent(this.animation);

  @override
  Future<void> onLoad() async {
    scale = Vector2.all(1);
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
    position = (parent as Plaguebearer).position;
  }
}
