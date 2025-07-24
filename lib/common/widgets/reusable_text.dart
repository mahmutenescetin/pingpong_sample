import 'package:flutter/material.dart';
import 'package:pingpong_sample/utils/extensions/context_extensions.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  const ReusableText(
    this.text, {
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? context.textStyles.body.b16Regular,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
