import 'package:flutter/material.dart';
import 'package:pingpong_sample/common/widgets/blur_overlay.dart';

mixin OverlayMixin {
  OverlayEntry? _overlayEntry;

  void addOverlay(BuildContext context) {
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (context) => const BlurOverlay(),
      );

      Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
    }
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
