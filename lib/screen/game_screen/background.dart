import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class Background extends PositionComponent {
  final Image image;
  final Vector2 gameSize;

  Background(this.image, this.gameSize);

  @override
  void render(Canvas canvas) {
    paintImage(canvas: canvas, rect: gameSize.toRect(), image: image);
    super.render(canvas);
  }
}