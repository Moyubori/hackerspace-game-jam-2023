import 'package:bonfire/bonfire.dart';

class PlaguebearerSpriteSheet {
  static Future<SpriteAnimation> get plaguebearerIdleLeft => SpriteAnimation.load(
        "enemy/plaguebearer/plaguebearer_idle_left.png",
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.2,
          textureSize: Vector2(72, 72),
        ),
      );

  static Future<SpriteAnimation> get plaguebearerIdleRight => SpriteAnimation.load(
        "enemy/plaguebearer/plaguebearer_idle_right.png",
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.2,
          textureSize: Vector2(72, 72),
        ),
      );

  static Future<SpriteAnimation> get plaguebearerRunRight => SpriteAnimation.load(
        "enemy/plaguebearer/plaguebearer_run_right.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.2,
          textureSize: Vector2(72, 72),
        ),
      );

  static Future<SpriteAnimation> get plaguebearerRunLeft => SpriteAnimation.load(
        "enemy/plaguebearer/plaguebearer_run_left.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.2,
          textureSize: Vector2(72, 72),
        ),
      );

  static Future<SpriteAnimation> get plaguebearerAttack => SpriteAnimation.load(
        "enemy/plaguebearer/plaguebearer_attack.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.2,
          textureSize: Vector2(72, 72),
        ),
      );

  static SimpleDirectionAnimation get plaguebearerSimpleDirectionAnimation => SimpleDirectionAnimation(
        idleRight: plaguebearerIdleRight,
        runRight: plaguebearerRunRight,
      );
}
