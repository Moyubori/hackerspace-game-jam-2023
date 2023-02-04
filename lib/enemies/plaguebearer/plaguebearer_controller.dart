import 'package:bonfire/bonfire.dart';
import 'package:hackerspace_game_jam_2023/dungeon/demo_dungeon_map.dart';

import 'plaguebearer.dart';

class PlaguebearerController extends StateController<Plaguebearer> {
  double attack = 33;
  bool _seePlayerToAttackMelee = false;
  bool enableBehaviors = true;

  @override
  void update(double dt, Plaguebearer component) {
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
        radiusVision: DemoDungeonMap.tileSize * 5,
      );
    }
  }
}
