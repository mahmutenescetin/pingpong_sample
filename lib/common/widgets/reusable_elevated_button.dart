import 'package:pingpong_sample/common/widgets/reusable_text.dart';
import 'package:pingpong_sample/utils/extensions/context_extensions.dart';
import 'package:pingpong_sample/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReusableElevatedButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Widget? prefix;
  final Widget? suffix;
  final bool expanded;
  final bool enabled;
  final double? borderRadius;
  final BoxDecoration? boxDecoration;
  final TextStyle? textStyle;
  final EdgeInsets? containerPadding;
  final Color? buttonTextColor;
  final Color? enableButtonColor;
  final bool isSecondaryButton;

  const ReusableElevatedButton({
    required this.text,
    required this.onPressed,
    this.prefix,
    this.suffix,
    this.borderRadius,
    this.expanded = false,
    this.enabled = true,
    this.boxDecoration,
    this.textStyle,
    this.containerPadding,
    this.buttonTextColor,
    this.enableButtonColor,
    this.isSecondaryButton = false,
    super.key,
  });

  const ReusableElevatedButton.secondaryButton({
    required this.text,
    required this.onPressed,
    this.prefix,
    this.suffix,
    this.borderRadius,
    this.expanded = false,
    this.enabled = true,
    this.boxDecoration,
    this.textStyle,
    this.containerPadding,
    this.isSecondaryButton = true,
    this.enableButtonColor = Colors.transparent,
    super.key,
    this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        padding: containerPadding ??
            EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: context.vGap,
            ),
        decoration: boxDecoration ??
            BoxDecoration(
              color: enabled
                  ? enableButtonColor ?? context.colors.button.surface.standard
                  : context.colors.button.surface.passive,
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
              border: isSecondaryButton
                  ? Border.all(
                      color: context.colors.button.surface.standard,
                    )
                  : null,
            ),
        child: Row(
          mainAxisAlignment: suffix.isNotNull || prefix.isNotNull
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
          children: [
            if (prefix.isNotNull) ...[prefix!, Gap(8.w)],
            Flexible(
              child: ReusableText(
                text,
                style: textStyle ??
                    context.textStyles.cta.cta14Semibold.copyWith(
                      color: isSecondaryButton
                          ? context.colors.button.surface.standard
                          : context.colors.button.text.standard,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            if (suffix.isNotNull) ...[Gap(8.w), suffix!],
          ],
        ),
      ),
    );
  }
}
