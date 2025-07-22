import 'package:pingpong_sample/themes/models/colors/primitives/primitive_colors.dart';
import 'package:pingpong_sample/themes/models/colors/primitives/solid_colors.dart';
import 'package:pingpong_sample/themes/models/colors/primitives/transparent_colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class ButtonColors extends ThemeExtension<ButtonColors>
    with EquatableMixin {
  final SurfaceColors surface;
  final TextColors text;

  const ButtonColors({
    required this.surface,
    required this.text,
  });

  @override
  ThemeExtension<ButtonColors> lerp(
    ThemeExtension<ButtonColors>? other,
    double t,
  ) {
    return this;
  }

  @override
  ButtonColors copyWith({
    SurfaceColors? surface,
    TextColors? text,
  }) {
    return ButtonColors(
      surface: surface ?? this.surface,
      text: text ?? this.text,
    );
  }

  const ButtonColors.light({
    this.surface = const SurfaceColors.light(),
    this.text = const TextColors.light(),
  });

  @override
  List<Object> get props => [
        surface,
        text,
      ];
}

final class SurfaceColors {
  final Color standard;
  final Color passive;
  final Color negative;

  const SurfaceColors({
    required this.standard,
    required this.passive,
    required this.negative,
  });

  const SurfaceColors.light({
    this.standard = SolidColors.gray900,
    this.passive = TransparentColors.gray200_15,
    this.negative = SolidColors.red300,
  });
}

final class TextColors {
  final Color standard;

  const TextColors({
    required this.standard,
  });

  const TextColors.light({
    this.standard = PrimitiveColors.white,
  });
}
