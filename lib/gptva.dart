import 'package:flutter/material.dart';
import 'package:gptva/pages.dart';
import 'package:gptva/src/src.dart';

class GPTVA extends StatelessWidget {
  const GPTVA({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: context.wHome.themeMode,
      home:Pages.splash.page,
    );
  }
}
