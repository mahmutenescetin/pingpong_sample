import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CtaTextStyles extends ThemeExtension<CtaTextStyles> with EquatableMixin {
  final TextStyle cta16Semibold;
  final TextStyle cta16Medium;
  final TextStyle cta14Semibold;

  const CtaTextStyles({
    required this.cta16Semibold,
    required this.cta16Medium,
    required this.cta14Semibold,
  });

  @override
  ThemeExtension<CtaTextStyles> lerp(
    ThemeExtension<CtaTextStyles>? other,
    double t,
  ) {
    return this;
  }

  @override
  CtaTextStyles copyWith({
    TextStyle? cta16Semibold,
    TextStyle? cta16Medium,
    TextStyle? cta14Semibold,
  }) {
    return CtaTextStyles(
      cta16Semibold: cta16Semibold ?? this.cta16Semibold,
      cta16Medium: cta16Medium ?? this.cta16Medium,
      cta14Semibold: cta14Semibold ?? this.cta14Semibold,
    );
  }

  CtaTextStyles.light()
      : cta16Semibold = TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 16).sp,
        ),
        cta16Medium = TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 16).sp,
        ),
        cta14Semibold = TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 14).sp,
        );

  @override
  List<Object> get props => [
        cta16Semibold,
        cta14Semibold,
        cta16Medium,
      ];
}
