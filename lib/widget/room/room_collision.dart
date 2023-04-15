import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class RoomCollidable extends PositionComponent with HasGameRef, CollisionCallbacks {
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
    } else if (other is RoomCollidable) {}
  }
}
