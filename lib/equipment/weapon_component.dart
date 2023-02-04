import 'dart:math' as math;
import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flame/components.dart';

import '../overworld/player.dart';

class WeaponComponent extends SpriteComponent with HasGameRef<BonfireGame> {
  late double swingDuration;
  late double dmg;
  static const double normalDamping = 0.3;
  static const double swingingDamping = 3;
  static const double firstPositionAngularPosition = 1.5;
  static const double secondPositionAngularPosition = 0.5;
  Vector2 _originalSwingFacingDirection = Vector2.zero();
  List<Attackable> _enemiesDamagedThisSwing = [];

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
    sword = await Sprite.load('sword.png');
    sprite = axe;
    size = Vector2(32, 32);
    anchor = Anchor.center;
    position = player.position;
  }

  @override
  void render(Canvas c) {
    if (!isEquipped) {
      return;
    } else {
      super.render(c);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if ((_inSecondPosition && isFlippedVertically) || (!_inSecondPosition && !isFlippedVertically)) {
      flipVertically();
    }
    if (!_isSwinging) {
      final Vector2 targetAxeDirection = player.currentFacingDirection.toVector2()
        ..rotate((_inSecondPosition ? secondPositionAngularPosition : firstPositionAngularPosition) * math.pi);
      final Vector2 targetPosition = player.position + Vector2(16, 16) + targetAxeDirection * 32;
      position.lerp(
        targetPosition,
        dt * position.distanceTo(targetPosition) * (_isSwinging ? swingingDamping : normalDamping),
      );
    } else {
      final double swingProgress = (gameRef.currentTime() - _swingingStartTime) / swingDuration;
      final Vector2 targetPosition = Vector2.copy(_originalSwingFacingDirection)
        ..rotate(((_inSecondPosition
                        ? secondPositionAngularPosition - firstPositionAngularPosition
                        : firstPositionAngularPosition - secondPositionAngularPosition) *
                    swingProgress +
                (_inSecondPosition ? secondPositionAngularPosition : firstPositionAngularPosition)) *
            math.pi);
      position = player.position + Vector2(16, 16) + targetPosition * 32;
    }
    final Vector2 positionRelativeToPlayer = player.position - (position - Vector2(16, 16));
    angle = _inSecondPosition
        ? math.pi * 1.75 - math.atan2(positionRelativeToPlayer.x, positionRelativeToPlayer.y)
        : math.pi * 1.25 - math.atan2(positionRelativeToPlayer.x, positionRelativeToPlayer.y);

    if (_isSwinging) {
      gameRef
          .visibleAttackables()
          .where((a) => a.rectAttackable().overlaps(toRect()) && a != player && !_enemiesDamagedThisSwing.contains(a))
          .forEach((Attackable hitEnemy) {
        _enemiesDamagedThisSwing.add(hitEnemy);
        hitEnemy.receiveDamage(AttackFromEnum.PLAYER_OR_ALLY, dmg, 'id');
        final Vector2 pushDirection = (hitEnemy.position - player.position).normalized();
        final double pushAngle = math.atan2(pushDirection.x, pushDirection.y);
        final Vector2 diffBase = BonfireUtil.diffMovePointByAngle(
          hitEnemy.position,
          32,
          pushAngle,
        );
        final Vector2 rectAfterPush = hitEnemy.position.translate(diffBase.x, diffBase.y);
        if (hitEnemy is ObjectCollision &&
            ((hitEnemy as ObjectCollision).isCollision(displacement: rectAfterPush).isEmpty)) {
          hitEnemy.translate(diffBase.x, diffBase.y);
        }
        if (!gameRef.camera.shaking) {
          gameRef.camera.shake(duration: 0.1 + (dmg / 1000), intensity: 4 + (dmg / 100));
        }
      });
    }
  }

  void trySwing() {
    if (!_isSwinging) {
      _isSwinging = true;
      _swingingStartTime = gameRef.currentTime();
      _originalSwingFacingDirection = player.currentFacingDirection.toVector2();
      _enemiesDamagedThisSwing = [];
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
