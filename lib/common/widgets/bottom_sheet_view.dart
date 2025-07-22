
import 'package:flutter/material.dart';
import 'package:pingpong_sample/routes/create_view.dart';
import 'package:pingpong_sample/routes/generate_routes.dart';
import 'package:pingpong_sample/utils/extensions/context_extensions.dart';

class BottomSheetView extends StatelessWidget {
  final double? heightFactor;
  final bool useBottomPadding;
  final bool useTopHolder;
  final String? initialRoute;
  final Widget? child;
  final Object? args;
  final Color? backgroundColor;
  final double? bottomGap;

  const BottomSheetView({
    super.key,
    this.heightFactor,
    this.useBottomPadding = false,
    this.useTopHolder = true,
    this.initialRoute,
    this.child,
    this.args,
    this.backgroundColor,
    this.bottomGap,
  });

  BottomSheetView copyWith({
    final double? heightFactor,
    final bool? useBottomPadding,
    final bool? useTopHolder,
    final String? initialRoute,
    final Widget? child,
    final Object? args,
    final Color? backgroundColor,
  }) {
    return BottomSheetView(
      heightFactor: heightFactor ?? this.heightFactor,
      useBottomPadding: useBottomPadding ?? this.useBottomPadding,
      useTopHolder: useTopHolder ?? this.useTopHolder,
      initialRoute: initialRoute ?? this.initialRoute,
      args: args ?? this.args,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      child: child ?? this.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final innerChild = SizedBox(
      height: heightFactor != null
          ? MediaQuery.of(context).size.height * heightFactor!
          : null,
      child: initialRoute == null && child != null
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: child,
              ),
            )
          : Navigator(
              onGenerateInitialRoutes: (state, name) {
                return [
                  MaterialPageRoute(
                    builder: (_) => createView(initialRoute!)!,
                    settings:
                        RouteSettings(name: initialRoute, arguments: args),
                  )
                ];
              },
              onGenerateRoute: onGenerateRoute,
            ),
    );

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colors.background.surface.standard,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Flexible(child: innerChild),
        ],
      ),
    );
  }
}
