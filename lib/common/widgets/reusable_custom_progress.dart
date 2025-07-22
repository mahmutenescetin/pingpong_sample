import 'dart:io';
import 'package:pingpong_sample/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ReusableCustomProgress extends StatelessWidget {
  final double? androidRadius;
  final double? iosRadius;
  final double? strokeWidth;
  final Color? color;
  final double? value;

  const ReusableCustomProgress({
    this.androidRadius,
    this.iosRadius,
    this.strokeWidth,
    this.color,
    this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final androidRadius = this.androidRadius ?? 200.r;
    final iosRadius = this.iosRadius ?? 200.r;
    final strokeWidth = this.strokeWidth ?? 4.r;

    return Container(
      margin: EdgeInsets.all(strokeWidth / 2),
      width: Platform.isAndroid ? androidRadius : iosRadius,
      height: Platform.isAndroid ? androidRadius : iosRadius,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 165.w,
            child: LinearProgressIndicator(
              color: context.colors.background.surface.standard,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: context.colors.background.surface.standard,
            ),
          ),
        ],
      ),
    );
  }
}
