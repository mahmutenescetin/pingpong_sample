import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextLinkTextStyles extends ThemeExtension<TextLinkTextStyles>
    with EquatableMixin {
  final TextStyle tl16Medium;

  const TextLinkTextStyles({
    required this.tl16Medium,
  });

  @override
  ThemeExtension<TextLinkTextStyles> lerp(
    ThemeExtension<TextLinkTextStyles>? other,
    double t,
  ) {
    return this;
  }

  @override
  TextLinkTextStyles copyWith({
    TextStyle? tl16Medium,
  }) {
    return TextLinkTextStyles(
      tl16Medium: tl16Medium ?? this.tl16Medium,
    );
  }

  TextLinkTextStyles.light()
      : tl16Medium = TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 16).sp,
        );

  @override
  List<Object> get props => [
        tl16Medium,
      ];
}
