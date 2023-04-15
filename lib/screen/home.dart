import 'package:amuse/schemes/color.dart';
import 'package:amuse/screen/amuse_nation_game.dart';
import 'package:amuse/widget/joy_stick/enum_direction.dart';
import 'package:amuse/widget/joy_stick/joy_stick.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AmuseNationGame game = AmuseNationGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: context.color.background,
            title: Text(widget.title, style: TextStyle(color: context.color.primary))),
        body: Stack(
          children: [
            GameWidget(game: game),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: JoyStickWidget(onDirectionChanged: onJoyStickDirectionChanged),
              ),
            )
          ],
        ));
  }

  void onJoyStickDirectionChanged(final Direction direction) {
    game.onJoyStickDirectionChanged(direction);
  }
}
