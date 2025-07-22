import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyTextStyles extends ThemeExtension<BodyTextStyles>
    with EquatableMixin {
  final TextStyle b60Light;
  final TextStyle b40Semibold;
  final TextStyle b35Semibold;
  final TextStyle b32Semibold;
  final TextStyle b30Regular;
  final TextStyle b25Semibold;
  final TextStyle b20Semibold;
  final TextStyle b18Semibold;
  final TextStyle b14Semibold;
  final TextStyle b18Regular;
  final TextStyle b16Regular;
  final TextStyle b16Medium;
  final TextStyle b14Regular;
  final TextStyle b12Regular;

  const BodyTextStyles({
    required this.b60Light,
    required this.b40Semibold,
    required this.b35Semibold,
    required this.b32Semibold,
    required this.b30Regular,
    required this.b25Semibold,
    required this.b20Semibold,
    required this.b18Semibold,
    required this.b14Semibold,
    required this.b18Regular,
    required this.b16Regular,
    required this.b16Medium,
    required this.b14Regular,
    required this.b12Regular,
  });

  @override
  ThemeExtension<BodyTextStyles> lerp(
    ThemeExtension<BodyTextStyles>? other,
    double t,
  ) {
    return this;
  }

  @override
  BodyTextStyles copyWith({
    TextStyle? b60Light,
    TextStyle? b40Semibold,
    TextStyle? b35Semibold,
    TextStyle? b32Semibold,
    TextStyle? b30Regular,
    TextStyle? b25Semibold,
    TextStyle? b20Semibold,
    TextStyle? b18Semibold,
    TextStyle? b14Semibold,
    TextStyle? b18Regular,
    TextStyle? b16Regular,
    TextStyle? b16Medium,
    TextStyle? b14Regular,
    TextStyle? b12Regular,
  }) {
    return BodyTextStyles(
      b60Light: b60Light ?? this.b60Light,
      b40Semibold: b40Semibold ?? this.b40Semibold,
      b35Semibold: b35Semibold ?? this.b35Semibold,
      b32Semibold: b32Semibold ?? this.b32Semibold,
      b30Regular: b30Regular ?? this.b30Regular,
      b25Semibold: b25Semibold ?? this.b25Semibold,
      b20Semibold: b20Semibold ?? this.b20Semibold,
      b18Semibold: b18Semibold ?? this.b18Semibold,
      b14Semibold: b14Semibold ?? this.b14Semibold,
      b18Regular: b18Regular ?? this.b18Regular,
      b16Regular: b16Regular ?? this.b16Regular,
      b16Medium: b16Medium ?? this.b16Medium,
      b14Regular: b14Regular ?? this.b14Regular,
      b12Regular: b12Regular ?? this.b12Regular,
    );
  }

  BodyTextStyles.light()
      : b60Light = TextStyle(
          fontSize: 60.sp,
          fontWeight: FontWeight.w300,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 60).sp,
        ),
        b40Semibold = TextStyle(
          fontSize: 40.sp,
          fontWeight: FontWeight.w600,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 40).sp,
        ),
        b35Semibold = TextStyle(
          fontSize: 35.sp,
          fontWeight: FontWeight.w600,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 35).sp,
        ),
        b32Semibold = TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w600,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 32).sp,
        ),
        b30Regular = TextStyle(
          fontSize: 30.sp,
          fontWeight: FontWeight.w400,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 30).sp,
        ),
        b25Semibold = TextStyle(
          fontSize: 25.sp,
          fontWeight: FontWeight.w600,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 25).sp,
        ),
        b20Semibold = TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 20).sp,
        ),
        b18Semibold = TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 18).sp,
        ),
        b14Semibold = TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 14).sp,
        ),
        b18Regular = TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 18).sp,
        ),
        b16Regular = TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 16).sp,
        ),
        b16Medium = TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 16).sp,
        ),
        b14Regular = TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 14).sp,
        ),
        b12Regular = TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 12).sp,
        );

  @override
  List<Object> get props => [
        b60Light,
        b40Semibold,
        b35Semibold,
        b32Semibold,
        b30Regular,
        b25Semibold,
        b20Semibold,
        b18Semibold,
        b14Semibold,
        b18Regular,
        b16Regular,
        b16Medium,
        b14Regular,
        b12Regular,
      ];
}
