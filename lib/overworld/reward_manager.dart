import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:hackerspace_game_jam_2023/enemies/awards.dart';
import 'package:hackerspace_game_jam_2023/equipment/axe.dart';
import 'package:hackerspace_game_jam_2023/equipment/base_equipment.dart';
import 'package:hackerspace_game_jam_2023/equipment/chest.dart';
import 'package:hackerspace_game_jam_2023/equipment/potion.dart';
import 'package:hackerspace_game_jam_2023/equipment/sword.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

import '../equipment/base_item.dart';

class RewardManager {
  static List<double> expNeededToNextLevelUp = [
    0,//lv1
    10,
    25,
    60,
    150,
  ];
  
  static final List<GameDecoration Function(MainPlayer)> _possibleRewards = [
    (player) => Chest(Vector2(0,0), generateChestContent(player)),
    (player) => _randomItemLevel(Axe(Vector2(0,0), 1), player),
    (player) => _randomItemLevel(Sword(Vector2(0,0), 1), player),
    (player) => Potion(Vector2(0,0)),
  ];

  static BaseWeapon _trulyRandomItemLevel(BaseWeapon weapon) {
    weapon.reqLvl = Random().nextInt(10) + 1;
    return weapon;
  }

  static BaseWeapon _randomItemLevel(BaseWeapon weapon, MainPlayer player) {
    weapon.reqLvl = max(1, player.currentLvl + Random().nextInt(4) - 2);
    return weapon;
  }

  static List<InteractableItem> generateRandomChestContent() {
    var rand = Random();
    var randIdx = rand.nextInt(3);
    return [_possibleRandomItemRewards[randIdx]];
  }

  static List<InteractableItem> generateChestContent(MainPlayer player) {
    var rand = Random();
    var numberOfItems = rand.nextInt(2) + 1;
    return List<InteractableItem>.generate(numberOfItems, (index) =>
        _possibleItemRewards[rand.nextInt(_possibleItemRewards.length)](player));
  }

  static final List<InteractableItem> _possibleRandomItemRewards = [
        _trulyRandomItemLevel(Axe(Vector2(0, 0), 1)),
        _trulyRandomItemLevel(Sword(Vector2(0,0), 1)),
        Potion(Vector2(0,0)),
  ];

  static final List<InteractableItem Function(MainPlayer)> _possibleItemRewards = [
    (player) => _randomItemLevel(Axe(Vector2(0,0), 1), player),
    (player) => _randomItemLevel(Sword(Vector2(0,0), 1), player),
    (player) => Potion(Vector2(0,0)),
  ];


  static giveAwardsToKiller(MainPlayer player, Attackable enemy) {
    _giveExp(player, (enemy as awards).exp());
    generateLoot(player, enemy.position);
  }

  static _giveExp(MainPlayer player, double expReward) {
    player.currentExp += expReward;
    while(player.currentExp >= player.expNeeded) {
      player.currentLvl++;
      player.currentExp = max(player.currentExp - player.expNeeded, 0);
      player.expNeeded = expNeededToNextLevelUp[player.currentLvl];
    }
  }

  static generateLoot(MainPlayer player, Vector2 position) {
    var item = _possibleRewards[Random().nextInt(_possibleRewards.length)](player);
    FlameAudio.play(['coin.wav', 'coin2.wav', 'coin3.wav'].getRandom());
    item.position = Vector2.copy(position);
    var parent = player.parent as Component;
    item.changeParent(parent);
  }
}