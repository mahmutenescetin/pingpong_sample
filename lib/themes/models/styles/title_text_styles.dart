import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleTextStyles extends ThemeExtension<TitleTextStyles>
    with EquatableMixin {
  final TextStyle t30Semibold;
  final TextStyle t22Semibold;
  final TextStyle t18Semibold;
  final TextStyle t16Semibold;
  final TextStyle t16Medium;

  const TitleTextStyles({
    required this.t30Semibold,
    required this.t22Semibold,
    required this.t18Semibold,
    required this.t16Semibold,
    required this.t16Medium,
  });

  @override
  ThemeExtension<TitleTextStyles> lerp(
    ThemeExtension<TitleTextStyles>? other,
    double t,
  ) {
    return this;
  }

  @override
  TitleTextStyles copyWith({
    TextStyle? t30Semibold,
    TextStyle? t22Semibold,
    TextStyle? t18Semibold,
    TextStyle? t16Semibold,
    TextStyle? t16Medium,
  }) {
    return TitleTextStyles(
      t30Semibold: t30Semibold ?? this.t30Semibold,
      t22Semibold: t22Semibold ?? this.t22Semibold,
      t18Semibold: t18Semibold ?? this.t18Semibold,
      t16Semibold: t16Semibold ?? this.t16Semibold,
      t16Medium: t16Medium ?? this.t16Medium,
    );
  }

  TitleTextStyles.light()
      : t30Semibold = TextStyle(
          fontSize: 30.sp,
          fontWeight: FontWeight.w600,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 30).sp,
        ),
        t22Semibold = TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 22).sp,
        ),
        t18Semibold = TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 18).sp,
        ),
        t16Semibold = TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 16).sp,
        ),
        t16Medium = TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 16).sp,
        );

  @override
  List<Object> get props => [
        t30Semibold,
        t22Semibold,
        t18Semibold,
        t16Semibold,
        t16Medium,
      ];
}
