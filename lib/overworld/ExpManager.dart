import 'dart:math';

import 'package:hackerspace_game_jam_2023/overworld/player.dart';

class ExpManager {
  static List<double> expNeededToNextLevelUp = [
    0,//lv1
    10,
    25,
    60,
    150,
  ];

  static giveAwardsToKiller(MainPlayer player, double expReward) {
    player.currentExp += expReward;
    while(player.currentExp >= player.expNeeded) {
      player.currentLvl++;
      player.currentExp = max(player.currentExp - player.expNeeded, 0);
      player.expNeeded = expNeededToNextLevelUp[player.currentLvl];
    }
  }
}