import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaptionTextStyles extends ThemeExtension<CaptionTextStyles>
    with EquatableMixin {
  final TextStyle c12Regular;
  final TextStyle c12Semibold;
  final TextStyle c11Regular;
  final TextStyle c10Regular;

  const CaptionTextStyles({
    required this.c12Regular,
    required this.c12Semibold,
    required this.c11Regular,
    required this.c10Regular,
  });

  @override
  ThemeExtension<CaptionTextStyles> lerp(
    ThemeExtension<CaptionTextStyles>? other,
    double t,
  ) {
    return this;
  }

  @override
  CaptionTextStyles copyWith({
    TextStyle? c12Regular,
    TextStyle? c12Semibold,
    TextStyle? c11Regular,
    TextStyle? c10Regular,
  }) {
    return CaptionTextStyles(
      c12Regular: c12Regular ?? this.c12Regular,
      c12Semibold: c12Semibold ?? this.c12Semibold,
      c11Regular: c11Regular ?? this.c11Regular,
      c10Regular: c10Regular ?? this.c10Regular,
    );
  }

  CaptionTextStyles.light()
      : c12Regular = TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 12).sp,
        ),
        c12Semibold = TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 12).sp,
        ),
        c11Regular = TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 11).sp,
        ),
        c10Regular = TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 10).sp,
        );

  @override
  List<Object> get props => [
        c12Regular,
        c11Regular,
        c10Regular,
      ];
}
