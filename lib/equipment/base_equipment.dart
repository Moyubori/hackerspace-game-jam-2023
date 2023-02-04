import 'package:bonfire/bonfire.dart';
import 'package:flame/components.dart';
import 'package:hackerspace_game_jam_2023/equipment/base_item.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

abstract class BaseWeapon extends InteractableItem {
  double dmg;
  double swingDuration;
  bool isEquipped = false;
  BaseWeapon(super.position, super.file, this.dmg, this.swingDuration);
  BaseWeapon.noPosition(String file, double dmg, double swingDuration)
      : this(Vector2(0, 0), file, dmg, swingDuration);

  @override
  void interact(MainPlayer player) {
    player.inventory.add(this);
    var weaponData = player.weaponComponent;
    weaponData.isEquipped = true;
    weaponData.dmg = dmg;
    weaponData.swingDuration = swingDuration;
    weaponData.sprite = sprite!;
  }
}