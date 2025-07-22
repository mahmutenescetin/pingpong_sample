import 'package:pingpong_sample/themes/models/colors/primitives/primitive_colors.dart';
import 'package:pingpong_sample/themes/models/colors/primitives/transparent_colors.dart';
import 'package:flutter/material.dart';

mixin Gradients {
  static const LinearGradient white = LinearGradient(
    colors: [
      TransparentColors.gray900_50,
      PrimitiveColors.white,
    ],
  );

  static const LinearGradient graphicDefault = LinearGradient(
    colors: [
      TransparentColors.gray900_35,
      Colors.white,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient graphicDefaultMoreOpacity = LinearGradient(
    colors: [
      TransparentColors.gray900_15,
      Colors.transparent,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
