import 'package:pingpong_sample/themes/models/colors/primitives/solid_colors.dart';
import 'package:pingpong_sample/themes/models/colors/primitives/transparent_colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class GeneralTextColors extends ThemeExtension<GeneralTextColors>
    with EquatableMixin {
  final TextColors text;

  const GeneralTextColors({
    required this.text,
  });

  @override
  ThemeExtension<GeneralTextColors> lerp(
    ThemeExtension<GeneralTextColors>? other,
    double t,
  ) {
    return this;
  }

  @override
  GeneralTextColors copyWith({
    TextColors? text,
  }) {
    return GeneralTextColors(
      text: text ?? this.text,
    );
  }

  const GeneralTextColors.light({
    this.text = const TextColors.light(),
  });

  @override
  List<Object> get props => [
        text,
      ];
}

final class TextColors {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color positive;
  final Color negative;

  const TextColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.positive,
    required this.negative,
  });

  const TextColors.light({
    this.primary = SolidColors.gray900,
    this.secondary = SolidColors.gray200,
    this.tertiary = TransparentColors.gray200_50,
    this.positive = SolidColors.green300,
    this.negative = SolidColors.red300,
  });
}
