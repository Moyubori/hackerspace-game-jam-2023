import 'package:bonfire/base/game_component.dart';
import 'package:bonfire/bonfire.dart';

import '../dungeon/demo_dungeon_map.dart';
import '../overworld/player.dart';

abstract class InteractableItem extends GameDecoration with Sensor<Player> {
  InteractableItem(Vector2 position, String file): super.withSprite(
    sprite: Sprite.load(file),
    position: position,
    size: Vector2.all(DemoDungeonMap.tileSize * 0.5),
  );

  InteractableItem.noPosition(String file): this(Vector2(0, 0), file);

  @override
  void onContact(GameComponent component) {
    if (component is MainPlayer) {
      interact(component);
      removeFromParent();
    }
  }

  void interact(MainPlayer player);

  @override
  void onContactExit(GameComponent component) {}
}