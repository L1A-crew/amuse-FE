import 'package:amuse/schemes/color.dart';
import 'package:amuse/screen/home.dart';
import 'package:flutter/material.dart';

class AmuseApp extends StatelessWidget {
  static const String appFontFamily = "NeoDunggeunmoPro";

  const AmuseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '어뮤즈',
      home: const HomeScreen(title: '어뮤즈'),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: AmuseApp.appFontFamily,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: AmuseApp.appFontFamily,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      themeMode: ThemeMode.system,
    );
  }
}
