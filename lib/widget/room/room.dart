import 'package:flame/components.dart';

class Room extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('room.png');
    size = sprite!.originalSize * 0.5;
  }
}
