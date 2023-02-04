import 'package:bonfire/bonfire.dart';
import 'package:flutter/widgets.dart';
import 'package:hackerspace_game_jam_2023/inventory_item.dart';
import 'package:hackerspace_game_jam_2023/overworld/player.dart';

import 'dungeon_map.dart';

class Chest extends GameDecoration with TapGesture {
  bool _observedPlayer = false;
  List<InventoryItem> contents;
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
    size: Vector2.all(DungeonMap.tileSize * 0.6),
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
        radiusVision: DungeonMap.tileSize,
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
        'Open',
        Vector2(x - width / 1.5, center.y - (height + 5)),
      );
    }
  }

  @override
  void onTap() {
    if (_observedPlayer) {
      (gameRef.player as MainPlayer).inventory.addAll(contents);
      removeFromParent();
      _addSmokeExplosion(position.translate(0, 0));
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
        size: Vector2.all(DungeonMap.tileSize),
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
