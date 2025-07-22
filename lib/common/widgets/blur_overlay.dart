import 'dart:ui';

import 'package:flutter/material.dart';

final class BlurOverlay extends StatelessWidget {
  const BlurOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: const SizedBox.expand(),
    );
  }
}
