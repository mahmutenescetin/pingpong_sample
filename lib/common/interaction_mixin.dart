
import 'package:flutter/material.dart' show ThemeData, Widget;
import 'package:pingpong_sample/common/base_view_model.dart';
import 'package:pingpong_sample/common/enums/flush_bar_type.dart';
import 'package:pingpong_sample/common/models/action_sheet_item.dart';

mixin InteractionMixin {
  late Future<T?>? Function<T extends Object?>(
    String routeName, {
    Object? args,
    bool clearStack,
    bool rootNavigator,
  }) navigate;

  late Future<T?>? Function<T extends Object?>(
    String routeName, {
    Object? args,
    Object? result,
    bool rootNavigator,
  }) pushReplacement;

  late Future<T?>? Function<T extends Object?>(
    String routeName, {
    Object? args,
    Object? result,
    bool rootNavigator,
  }) popAndNavigate;

  late Future<T?>? Function<T extends Object?>(
    String routeName, {
    String removeUntilRoute,
    Object? args,
    bool rootNavigator,
  }) navigateAndRemoveUntil;

  late void Function<T extends Object?>({T result, bool rootNavigator}) pop;

  late void Function(String routeName, {bool rootNavigator}) popUntilRoute;

  late void Function({
    required String routeName,
    required String defaultRouteName,
    bool root,
  }) popUntilWithDefaultRoute;

  late Future<T?>? Function<T>({
    required Widget body,
    bool isScrollControlled,
    bool enableDrag,
    bool isDismissible,
  }) bottomSheet;

  late void Function(String message, {FlushBarType type}) showFlushBar;

  late void Function(bool loading) loadingOverlay;

  late ThemeData theme;

  late bool Function({bool rootNavigator}) canPop;

  late bool Function() isCurrent;

  late VM? Function<VM extends BaseViewModel>() getViewModel;

  late bool Function() inBottomSheetView;

  late void Function() rebuildAllChildren;

  late Future<ActionSheetItem?>? Function({
    required List<ActionSheetItem> items,
    String? title,
    bool isDismissible,
    bool useRootNavigator,
  }) actionSheet;

  late double screenHeight;
}
