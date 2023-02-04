import 'package:bonfire/bonfire.dart';
import 'package:bonfire/state_manager/state_controller.dart';
import 'package:hackerspace_game_jam_2023/dungeon/demo_dungeon_map.dart';

import 'centipede.dart';

class CentipedeController extends StateController<Centipede> {
  double attack = 100;
  bool _seePlayerToAttackMelee = false;
  bool enableBehaviors = true;

  @override
  void update(double dt, Centipede component) {
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
        radiusVision: DemoDungeonMap.tileSize * 1.5,
      );

      if (!_seePlayerToAttackMelee) {
        component.seeAndMoveToAttackRange(
          minDistanceFromPlayer: DemoDungeonMap.tileSize * 2,
          positioned: (p) {
            component.execAttackRange(attack);
          },
          radiusVision: DemoDungeonMap.tileSize * 3,
          notObserved: () {
            component.runRandomMovement(
              dt,
              speed: component.speed / 2,
              maxDistance: (DemoDungeonMap.tileSize * 3).toInt(),
            );
          },
        );
      }
    }
  }
}
