import 'dart:ui';

enum ActionSheetItemType {
  defaultAction,
  destructiveAction,
}

final class ActionSheetItem {
  final String text;
  final bool isDefault;
  final ActionSheetItemType type;
  final VoidCallback? onPressed;
  final bool isEnabled;


  final String? svgPath;

  bool get isDestructive => type == ActionSheetItemType.destructiveAction;

  const ActionSheetItem({
    required this.text,
    this.isDefault = false,
    this.type = ActionSheetItemType.defaultAction,
    this.onPressed,
    this.svgPath,
    this.isEnabled = true,
  });
}
