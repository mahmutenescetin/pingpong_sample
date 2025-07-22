
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:pingpong_sample/routes/create_view.dart';

Route? onGenerateRoute(RouteSettings settings) {
  if (settings.name != null) {
    final child = createView(settings.name!);

    if (child != null) {
      return MaterialWithModalsPageRoute(
        builder: (_) => child,
        settings: settings,
      );
    }
    return null;
  } else {
    return null;
  }
}
