import 'package:flutter/material.dart';
import 'package:gptva/src/src.dart';
import 'package:provider/provider.dart';

extension BuildContextPlus on BuildContext {
  HomePageProvider get rHome => read<HomePageProvider>();
  HomePageProvider get wHome => watch<HomePageProvider>();

  // theme
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
}
