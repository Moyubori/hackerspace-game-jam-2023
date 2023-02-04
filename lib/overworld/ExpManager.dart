import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

class ExpManager {
  static List<double> expNeededToNextLevelUp = [
    0, //lv1
    10,
    25,
    60,
    150,
  ];

  static giveAwardsToKiller(MainPlayer player, double expReward) {
    FlameAudio.play(['coin.wav', 'coin2.wav', 'coin3.wav'].getRandom());
    player.currentExp += expReward;
    while (player.currentExp >= player.expNeeded) {
      player.currentLvl++;
      player.currentExp = max(player.currentExp - player.expNeeded, 0);
      player.expNeeded = expNeededToNextLevelUp[player.currentLvl];
    }
  }
}
