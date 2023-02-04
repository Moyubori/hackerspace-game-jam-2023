import 'package:bonfire/bonfire.dart';

class GoblinSpriteSheet {
  static Future<SpriteAnimation> get goblinIdleLeft => SpriteAnimation.load(
    "enemy/goblin_idle_left.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2(16, 16),
    ),
  );

  static Future<SpriteAnimation> get goblinIdleRight => SpriteAnimation.load(
    "enemy/goblin_idle.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2(16, 16),
    ),
  );

  static Future<SpriteAnimation> get goblinRunRight => SpriteAnimation.load(
    "enemy/goblin_run_right.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2(16, 16),
    ),
  );

  static Future<SpriteAnimation> get goblinRunLeft => SpriteAnimation.load(
    "enemy/goblin_run_left.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2(16, 16),
    ),
  );

  static SimpleDirectionAnimation get goblinSimpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: goblinIdleRight,
        runRight: goblinRunRight,
      );
}