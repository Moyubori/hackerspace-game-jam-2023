import 'package:bonfire/bonfire.dart';
import 'package:flame/components.dart';
import 'package:hackerspace_game_jam_2023/equipment/base_equipment.dart';

class Hammer extends BaseWeapon {
  Hammer(Vector2 position, int reqLvl, {bool isEquipped: false})
      : super(position, "hammer.png", 100, 0.5, reqLvl, isEquipped: true);
}
