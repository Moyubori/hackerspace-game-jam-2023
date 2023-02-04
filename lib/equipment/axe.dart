import 'package:bonfire/bonfire.dart';
import 'package:flame/components.dart';
import 'package:hackerspace_game_jam_2023/equipment/base_equipment.dart';

class Axe extends BaseWeapon {
  Axe(Vector2 position, int reqLvl) : super(position, "axe.png", 120, 0.5, reqLvl);
}
