import 'package:bonfire/bonfire.dart';

import '../overworld/player.dart';
import 'base_item.dart';

class Potion extends InteractableItem {
  Potion(Vector2 position): super(position, "itens/potion_life.png");

  @override
  void interact(MainPlayer player) {
    player.addLife(20);
  }
}