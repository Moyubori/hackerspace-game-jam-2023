import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire/mixins/keyboard_listener.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../dungeon/demo_dungeon_map.dart';
import 'base_item.dart';

class Chest extends GameDecoration with KeyboardEventListener {
  bool _observedPlayer = false;
  List<InteractableItem> contents;
  late TextPaint _textConfig;
  Chest(Vector2 position, this.contents)
      : super.withAnimation(
          animation: SpriteAnimation.load(
            "itens/chest_spritesheet.png",
            SpriteAnimationData.sequenced(
              amount: 8,
              stepTime: 0.1,
              textureSize: Vector2(16, 16),
            ),
          ),
          size: Vector2.all(DemoDungeonMap.tileSize * 0.6),
          position: position,
        ) {
    _textConfig = TextPaint(
      style: TextStyle(
        color: const Color(0xFFFFFFFF),
        fontSize: width / 2,
      ),
    );
  }

  @override
  bool onKeyboard(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.keyE)) {
      _open();
    }
    return super.onKeyboard(event, keysPressed);
  }

  @override
  void update(double dt) {
    if (gameRef.player != null) {
      seeComponent(
        gameRef.player!,
        observed: (player) {
          if (!_observedPlayer) {
            _observedPlayer = true;
            _showEmote();
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
  void render(Canvas canvas) {
    super.render(canvas);
    if (_observedPlayer) {
      _textConfig.render(
        canvas,
        'Open (E)',
        Vector2(x - width / 1.5, center.y - (height + 5)),
      );
    }
  }

  void _open() {
    if (_observedPlayer) {
      FlameAudio.play('door.wav');
      for (var element in contents) {
        const min = -30;
        const max = 30;
        var rnd = Random();
        roll() => min + rnd.nextInt(max - min);
        var newPosition = Vector2(position.x + roll(), position.y + roll());
        element.position = newPosition;
        element.changeParent(parent!);
        _addSmokeExplosion(newPosition);
      }
      _addSmokeExplosion(position);
      removeFromParent();
    }
  }

  void _addSmokeExplosion(Vector2 position) {
    gameRef.add(
      AnimatedObjectOnce(
        animation: SpriteAnimation.load(
          "smoke_explosin.png",
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
        position: position,
        size: Vector2.all(DemoDungeonMap.tileSize),
      ),
    );
  }

  @override
  void onTapCancel() {}

  void _showEmote() {
    add(
      AnimatedFollowerObject(
        animation: SpriteAnimation.load(
          "player/emote_exclamacao.png",
          SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
          ),
        ),
        size: size,
        positionFromTarget: size / -2,
      ),
    );
  }
}
