import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextButtonTextStyles extends ThemeExtension<TextButtonTextStyles>
    with EquatableMixin {
  final TextStyle tb16Medium;

  const TextButtonTextStyles({
    required this.tb16Medium,
  });

  @override
  ThemeExtension<TextButtonTextStyles> lerp(
    ThemeExtension<TextButtonTextStyles>? other,
    double t,
  ) {
    return this;
  }

  @override
  TextButtonTextStyles copyWith({
    TextStyle? tb16Medium,
  }) {
    return TextButtonTextStyles(
      tb16Medium: tb16Medium ?? this.tb16Medium,
    );
  }

  TextButtonTextStyles.light()
      : tb16Medium = TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          height: 1.2.sp,
          letterSpacing: (-0.02 * 16).sp,
        );

  @override
  List<Object> get props => [
        tb16Medium,
      ];
}
