import 'dart:math';

import 'package:amuse/schemes/color.dart';
import 'package:amuse/screen/game_screen/game_screen.dart';
import 'package:amuse/widget/joy_stick/enum_direction.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class JoyStickWidget extends StatefulWidget {
  final ValueChanged<Direction>? onDirectionChanged;

  const JoyStickWidget({required this.onDirectionChanged, Key? key}) : super(key: key);

  @override
  State<JoyStickWidget> createState() => _JoyStickWidgetState();
}

class _JoyStickWidgetState extends State<JoyStickWidget> {
  Direction direction = Direction.none;
  Offset delta = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: GameWidget(
              game: AmuseGame(),
            ),
          ),
        ),
      ),
      child: SizedBox(
        width: 120,
        height: 120,
        child: GestureDetector(
          onPanDown: onDragDown,
          onPanUpdate: onDragUpdate,
          onPanEnd: onDragEnd,
          child: Container(
              decoration: BoxDecoration(
                color: context.color.tertiaryContainer,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Transform.translate(
                  offset: delta,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: context.color.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Direction getDirectionFromOffset(Offset offset) {
    if (offset.dx > 20) {
      return Direction.right;
    } else if (offset.dx < -20) {
      return Direction.left;
    } else if (offset.dy > 20) {
      return Direction.down;
    } else if (offset.dy < -20) {
      return Direction.up;
    }
    return Direction.none;
  }

  void updateDelta(Offset newDelta) {
    final newDirection = getDirectionFromOffset(newDelta);

    if (newDirection != direction) {
      direction = newDirection;
      widget.onDirectionChanged!(direction);
    }

    setState(() {
      delta = newDelta;
    });
  }

  void onDragDown(DragDownDetails d) {
    calculateDelta(d.localPosition);
  }

  void onDragUpdate(DragUpdateDetails d) {
    calculateDelta(d.localPosition);
  }

  void onDragEnd(DragEndDetails d) {
    updateDelta(Offset.zero);
  }

  void calculateDelta(Offset localPosition) {
    final newDelta = Offset(localPosition.dx - 50, localPosition.dy - 50);
    updateDelta(
      Offset.fromDirection(newDelta.direction, min(50, newDelta.distance)),
    );
  }
}
