import 'dart:ui';

import 'package:flame/components.dart';

enum CharacterState { idle, jumping, falling }

class Character extends SpriteAnimationGroupComponent with HasGameRef {
  final Image characterImage;
  double _jumpVelocity = 0;
  bool _idleDirection = true;
  final int _maxPauseCount = 100;
  int _pauseCount = 100;
  int _idleCount = 0;
  final double gravity = 1;

  Offset get initialPosition => Offset(gameRef.size.x / 2, gameRef.size.y / 2);

  Character(this.characterImage) : super();

  @override
  Future<void> onLoad() async {
    x = initialPosition.dx;
    y = initialPosition.dy;
    height = 100;
    width = 100;
    animations = {
      CharacterState.idle: SpriteAnimation.fromFrameData(
        characterImage,
        SpriteAnimationData.sequenced(
          amount: 1,
          textureSize: Vector2.all(1024),
          stepTime: 0.1,
          loop: true,
        ),
      ),
      CharacterState.jumping: SpriteAnimation.fromFrameData(
        characterImage,
        SpriteAnimationData.sequenced(
          amount: 1,
          textureSize: Vector2.all(1024),
          stepTime: 0.1,
          loop: true,
        ),
      ),
      CharacterState.falling: SpriteAnimation.fromFrameData(
        characterImage,
        SpriteAnimationData.sequenced(
          amount: 1,
          textureSize: Vector2.all(1024),
          stepTime: 0.1,
          loop: true,
        ),
      ),
    };
    current = CharacterState.idle;
    return super.onLoad();
  }

  void jump() {
    if (current == CharacterState.jumping) return;
    current = CharacterState.jumping;
    _jumpVelocity = 15;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (current == CharacterState.idle) {
      if (_pauseCount > 0) {
        _pauseCount -= 1;
        if (_pauseCount == 0) {
          _idleCount = 4;
        }
      } else {
        if (_idleCount > 0) {
          _idleCount -= 1;
          if (_idleDirection) {
            x += 1;
            _idleDirection = false;
          } else {
            x -= 1;
            _idleDirection = true;
          }
        } else {
          _pauseCount = _maxPauseCount;
        }
      }
    }
    if (current == CharacterState.jumping) {
      x = initialPosition.dx;
      y -= _jumpVelocity;
      _jumpVelocity -= gravity;
      if (_jumpVelocity < 0) {
        current = CharacterState.falling;
      }
    } else if (current == CharacterState.falling) {
      y += _jumpVelocity;
      _jumpVelocity += gravity;
      if (y > initialPosition.dy) {
        current = CharacterState.idle;
      }
    }
  }
}
