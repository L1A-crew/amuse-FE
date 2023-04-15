import 'dart:ui';

import 'package:amuse/screen/game_screen/background.dart';
import 'package:amuse/screen/game_screen/character.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Image;

class AmuseGame extends FlameGame with TapDetector, HasGameRef {
  late final Image characterImage;
  late final Character character;
  late final Background background;

  @override
  Color backgroundColor() => Colors.black;

  @override
  void onTapDown(TapDownInfo info) {
    onAction();
  }

  void onAction() {
    character.jump();
  }

  @override
  Future<void> onLoad() async {
    characterImage = await Flame.images.load('bear.png');
    final gameSize = gameRef.size;
    background = Background(
      await Flame.images.load('room_background_01.jpeg'),
      gameSize,
    );
    character = Character(characterImage);
    add(background);
    add(character);
  }
}
