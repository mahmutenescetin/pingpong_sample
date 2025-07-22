import 'package:pingpong_sample/themes/models/styles/body_text_styles.dart';
import 'package:pingpong_sample/themes/models/styles/caption_text_styles.dart';
import 'package:pingpong_sample/themes/models/styles/cta_text_styles.dart';
import 'package:pingpong_sample/themes/models/styles/text_button_text_styles.dart';
import 'package:pingpong_sample/themes/models/styles/text_link_text_styles.dart';
import 'package:pingpong_sample/themes/models/styles/title_text_styles.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TextStyles extends ThemeExtension<TextStyles> with EquatableMixin {
  final TitleTextStyles title;
  final BodyTextStyles body;
  final CaptionTextStyles caption;
  final CtaTextStyles cta;
  final TextLinkTextStyles textLink;
  final TextButtonTextStyles textButton;

  const TextStyles({
    required this.title,
    required this.body,
    required this.caption,
    required this.cta,
    required this.textLink,
    required this.textButton,
  });

  @override
  ThemeExtension<TextStyles> lerp(
    ThemeExtension<TextStyles>? other,
    double t,
  ) {
    return this;
  }

  @override
  TextStyles copyWith({
    TitleTextStyles? title,
    BodyTextStyles? body,
    CaptionTextStyles? caption,
    CtaTextStyles? cta,
    TextLinkTextStyles? textLink,
    TextButtonTextStyles? textButton,
  }) {
    return TextStyles(
      title: title ?? this.title,
      body: body ?? this.body,
      caption: caption ?? this.caption,
      cta: cta ?? this.cta,
      textLink: textLink ?? this.textLink,
      textButton: textButton ?? this.textButton,
    );
  }

  factory TextStyles.light() {
    return TextStyles(
      title: TitleTextStyles.light(),
      body: BodyTextStyles.light(),
      caption: CaptionTextStyles.light(),
      cta: CtaTextStyles.light(),
      textLink: TextLinkTextStyles.light(),
      textButton: TextButtonTextStyles.light(),
    );
  }

  @override
  List<Object> get props => [
        title,
        body,
        caption,
        cta,
        textLink,
        textButton,
      ];
}
