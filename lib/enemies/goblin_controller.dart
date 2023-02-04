import 'package:bonfire/bonfire.dart';
import 'package:bonfire/state_manager/state_controller.dart';

import '../dungeon/dungeon_map.dart';
import 'goblin.dart';

class GoblinController extends StateController<Goblin> {
  double attack = 20;
  bool _seePlayerToAttackMelee = false;
  bool enableBehaviors = true;

  @override
  void update(double dt, Goblin component) {
    if (!enableBehaviors) return;

    if (!gameRef.sceneBuilderStatus.isRunning) {
      _seePlayerToAttackMelee = false;

      component.seeAndMoveToPlayer(
        closePlayer: (player) {
          component.execAttack(attack);
        },
        observed: () {
          _seePlayerToAttackMelee = true;
        },
        radiusVision: DungeonMap.tileSize * 1.5,
      );

      if (!_seePlayerToAttackMelee) {
        component.seeAndMoveToAttackRange(
          minDistanceFromPlayer: DungeonMap.tileSize * 2,
          positioned: (p) {
            component.execAttackRange(attack);
          },
          radiusVision: DungeonMap.tileSize * 3,
          notObserved: () {
            component.runRandomMovement(
              dt,
              speed: component.speed / 2,
              maxDistance: (DungeonMap.tileSize * 3).toInt(),
            );
          },
        );
      }
    }
  }
}