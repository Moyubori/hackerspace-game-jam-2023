import 'dart:math';
import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire/mixins/keyboard_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackerspace_game_jam_2023/equipment/base_item.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

abstract class BaseWeapon extends InteractableItem with KeyboardEventListener {
  double baseDmg;
  double swingDuration;
  bool pressed = false;
  bool isEquipped;
  int reqLvl = 1;
  bool wasJustDropped = false;
  BaseWeapon(super.position, super.file, this.baseDmg, this.swingDuration, this.reqLvl, {this.isEquipped = false});
  BaseWeapon.noPosition(String file, double dmg, double swingDuration, int reqLvl)
      : this(Vector2(0, 0), file, dmg, swingDuration, reqLvl);

  @override
  bool onKeyboard(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    pressed = keysPressed.contains(LogicalKeyboardKey.keyE);
    return super.onKeyboard(event, keysPressed);
  }

  @override
  bool interact(MainPlayer player) {
    if(player.currentLvl >= reqLvl && /*!wasJustDropped*/ pressed) {
      var oldWeapon = player.equippedWeapon;
      if(oldWeapon == this || player.isRolling) {
        return true;
      }
      oldWeapon.isEquipped = false;
      oldWeapon.wasJustDropped = true;
      var oldWeaponPos = oldWeapon.position;
      oldWeaponPos.x = player.position.x;
      oldWeaponPos.y = player.position.y;
      if(oldWeapon is! DummyWeapon) oldWeapon.changeParent(parent!);
      player.equippedWeapon = this;
      var weaponData = player.weaponComponent;
      weaponData.isEquipped = true;
      weaponData.dmg = dmgScaledWithLevel();
      weaponData.swingDuration = swingDuration;
      weaponData.sprite = sprite!;
      return false;
    }
    return true;
  }

  bool _observedPlayer = false;

  @override
  void update(double dt) {
    if (gameRef.player != null) {
      seeComponent(
        gameRef.player!,
        observed: (player) {
          if (!_observedPlayer) {
            _observedPlayer = true;
          }
        },
        notObserved: () {
          _observedPlayer = false;
        },
        radiusVision: 15,
      );
    }
    super.update(dt);
  }

  @override
  void onContactExit(GameComponent component) {
    wasJustDropped = false;
  }

  @override
  void render(Canvas c) {
    var style = const TextStyle(color: Colors.white, fontSize: 10);
    var basePos = Vector2.copy(position);
    basePos.y -= 5;
    TextPaint(style: style).render(c, "LV: $reqLvl", basePos);
    if(_observedPlayer && !isEquipped) {
      var newPos = Vector2.copy(position);
      newPos.y -= 15;
      TextPaint(style: style).render(c, "Pickup (E)", newPos);
    }
    super.render(c);
  }

  double dmgScaledWithLevel() {
    const dmgMultiplier = 1.1;
    return baseDmg * (pow(dmgMultiplier, reqLvl - 1));
  }
}

class DummyWeapon extends BaseWeapon {
  DummyWeapon(): super.noPosition("sword.png", 0, 0, 0);
}