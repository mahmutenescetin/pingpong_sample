import 'package:flutter/material.dart';
import 'package:pingpong_sample/themes/models/assets.g.dart';
import 'package:pingpong_sample/themes/models/colors/component/component_colors.dart';
import 'package:pingpong_sample/themes/models/styles/text_styles.dart';

part 'dark_theme.dart';
part 'light_theme.dart';

mixin Themes {
  static ThemeData get lightTheme => _lightTheme;
  static ThemeData get darkTheme => _darkTheme;
}
