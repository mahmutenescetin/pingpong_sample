import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pingpong_sample/themes/models/colors/primitives/primitive_colors.dart';

final class BackgroundColors extends ThemeExtension<BackgroundColors>
    with EquatableMixin {
  final SurfaceColors surface;

  const BackgroundColors({
    required this.surface,
  });

  @override
  ThemeExtension<BackgroundColors> lerp(
    ThemeExtension<BackgroundColors>? other,
    double t,
  ) {
    return this;
  }

  @override
  BackgroundColors copyWith({
    SurfaceColors? surface,
  }) {
    return BackgroundColors(
      surface: surface ?? this.surface,
    );
  }

  const BackgroundColors.light({
    this.surface = const SurfaceColors.light(),
  });

  @override
  List<Object> get props => [
        surface,
      ];
}

final class SurfaceColors {
  final Color standard;

  const SurfaceColors({
    required this.standard,
  });

  const SurfaceColors.light({
    this.standard = PrimitiveColors.white,
  });
}
