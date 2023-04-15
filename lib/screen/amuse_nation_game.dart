import 'package:amuse/widget/joy_stick/enum_direction.dart';
import 'package:amuse/widget/player/player.dart';
import 'package:amuse/widget/room/map_loader.dart';
import 'package:amuse/widget/room/room.dart';
import 'package:amuse/widget/room/room_collision.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmuseNationGame extends FlameGame with HasCollisionDetection, KeyboardEvents {
  final Player _player = Player();
  final Room _room = Room();

  @override
  Future<void> onLoad() async {
    await add(_room);
    await add(_player);
    addRoomCollision();
    _player.position = _room.size / 2;
    camera.followComponent(
      _player,
      worldBounds: Rect.fromLTRB(0, 0, _room.size.x, _room.size.y),
    );
  }

  void addRoomCollision() async {
    for (var rect in (await MapLoader.readRayWorldCollisionMap())) {
      add(RoomCollidable()
        ..position = Vector2(rect.left, rect.top)
        ..width = rect.width
        ..height = rect.height);
    }
  }

  void onJoyStickDirectionChanged(Direction direction) {
    _player.direction = direction;
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;
    Direction? keyDirection;

    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      keyDirection = Direction.left;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      keyDirection = Direction.right;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      keyDirection = Direction.up;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      keyDirection = Direction.down;
    }

    if (isKeyDown && keyDirection != null) {
      _player.direction = keyDirection;
    } else if (!isKeyDown && _player.direction == keyDirection) {
      _player.direction = Direction.none;
    }

    return super.onKeyEvent(event, keysPressed);
  }
}
