import 'package:bonfire/bonfire.dart';
import 'package:hackerspace_game_jam_2023/equipment/base_equipment.dart';

class Sword extends BaseWeapon {
  Sword(Vector2 position, int reqLvl) : super(position, "sword.png", 80, 0.15, reqLvl);
}
