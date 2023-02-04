import 'package:bonfire/bonfire.dart';

class CentipedeSpriteSheet {
  static Future<SpriteAnimation> get centipedeIdleLeft => SpriteAnimation.load(
        "enemy/centipede/centipede_idle_left.png",
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.2,
          textureSize: Vector2(48, 36),
        ),
      );

  static Future<SpriteAnimation> get centipedeIdleRight => SpriteAnimation.load(
        "enemy/centipede/centipede_idle_right.png",
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.2,
          textureSize: Vector2(48, 36),
        ),
      );

  static Future<SpriteAnimation> get centipedeRunRight => SpriteAnimation.load(
        "enemy/centipede/centipede_run_right.png",
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.2,
          textureSize: Vector2(48, 36),
        ),
      );

  static Future<SpriteAnimation> get centipedeRunLeft => SpriteAnimation.load(
        "enemy/centipede/centipede_run_left.png",
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.2,
          textureSize: Vector2(48, 36),
        ),
      );

  static Future<SpriteAnimation> get centipedeAttack => SpriteAnimation.load(
        "enemy/centipede/centipede_attack2.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.2,
          textureSize: Vector2(72, 72),
        ),
      );

  static SimpleDirectionAnimation get centipedeSimpleDirectionAnimation => SimpleDirectionAnimation(
        idleRight: centipedeIdleRight,
        runRight: centipedeRunRight,
      );
}
