import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';

import '../overworld/player.dart';
import 'base_item.dart';

class Potion extends InteractableItem {
  Potion(Vector2 position) : super(position, "itens/potion_life.png");

  @override
  bool interact(MainPlayer player) {
    FlameAudio.play('bottle.wav');
    player.addLife(20);
    return false;
  }
}
