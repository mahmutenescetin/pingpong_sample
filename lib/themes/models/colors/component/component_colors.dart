import 'package:pingpong_sample/themes/models/colors/component/background_colors.dart';
import 'package:pingpong_sample/themes/models/colors/component/button_colors.dart';

import 'package:pingpong_sample/themes/models/colors/component/general_text_colors.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class ComponentColors extends ThemeExtension<ComponentColors>
    with EquatableMixin {
  final BackgroundColors background;

  final GeneralTextColors generalText;
  final ButtonColors button;

  const ComponentColors({
    required this.background,

    required this.generalText,
    required this.button,
  });

  @override
  ThemeExtension<ComponentColors> lerp(
    ThemeExtension<ComponentColors>? other,
    double t,
  ) {
    return this;
  }

  @override
  ComponentColors copyWith({
    BackgroundColors? background,

    GeneralTextColors? generalText,
    ButtonColors? button,
  }) {
    return ComponentColors(
      background: background ?? this.background,
      generalText: generalText ?? this.generalText,
      button: button ?? this.button,
    );
  }

  const ComponentColors.light({
    this.background = const BackgroundColors.light(),

    this.generalText = const GeneralTextColors.light(),
    this.button = const ButtonColors.light(),
  });

  @override
  List<Object?> get props => [background, generalText, button];
}
