
import 'package:flutter/material.dart';
import 'package:pingpong_sample/constants/size_constants.dart';
import 'package:pingpong_sample/themes/models/assets.g.dart';
import 'package:pingpong_sample/themes/models/colors/component/component_colors.dart';
import 'package:pingpong_sample/themes/models/styles/text_styles.dart';


extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TargetPlatform get _platform => Theme.of(this).platform;

  bool get isAndroid => _platform == TargetPlatform.android;

  bool get isIOS => _platform == TargetPlatform.iOS;
}

extension MediaQueryExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => MediaQuery.sizeOf(this);
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  double get width => size.width;

  double get height => size.height;

  double get defaultBorderRadius => SizeConstants.defaultBorderRadius;

  double get allGap => SizeConstants.allGap;

  double get hGap => SizeConstants.hGap;

  double get vGap => SizeConstants.vGap;

  double get keyboardGap => viewInsets.bottom;

  double get _bottomGap => padding.bottom;

  double get safeTopGap => padding.top + SizeConstants.vGap;

  double get safeBottomGap => _bottomGap + SizeConstants.vGap;

  EdgeInsets get viewGaps => EdgeInsets.only(
        left: hGap,
        right: hGap,
        top: vGap,
        bottom: safeBottomGap,
      );

  Assets get assets => theme.extension<Assets>()!;
  TextStyles get textStyles => theme.extension<TextStyles>()!;
  ComponentColors get colors => theme.extension<ComponentColors>()!;

  bool get isLightMode => theme.brightness == Brightness.light;
  bool get isDarkMode => theme.brightness == Brightness.dark;
  Brightness get currentBrightness => theme.brightness;

  bool get canPop => ModalRoute.of(this)?.canPop ?? false;
}
