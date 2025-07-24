import 'package:flutter/material.dart';
import 'package:pingpong_sample/common/base_view_model.dart';
import 'package:pingpong_sample/common/interaction_mixin.dart';
import 'package:pingpong_sample/common/repositories/app_repository.dart';
import 'package:pingpong_sample/common/widgets/bottom_sheet_view.dart';
import 'package:pingpong_sample/common/widgets/reusable_custom_progress.dart';
import 'package:pingpong_sample/themes/models/colors/primitives/transparent_colors.dart';
import 'package:pingpong_sample/utils/extensions/context_extensions.dart';
import 'package:pingpong_sample/utils/locator.dart';
import 'package:pingpong_sample/utils/navigator_util.dart';
import 'package:provider/provider.dart';
import 'package:pingpong_sample/common/enums/flush_bar_type.dart';

class ViewModelBuilder<T extends ChangeNotifier> extends StatefulWidget {
  const ViewModelBuilder({
    required this.initViewModel,
    required this.builder,
    super.key,
  }) : reactive = true;

  final T Function() initViewModel;
  final Widget Function(BuildContext context, T value) builder;
  final bool reactive;

  const ViewModelBuilder.nonReactive({
    required this.initViewModel,
    required this.builder,
    super.key,
  }) : reactive = false;

  @override
  State<ViewModelBuilder<T>> createState() => _ViewModelBuilder<T>();
}

class _ViewModelBuilder<T extends ChangeNotifier>
    extends State<ViewModelBuilder<T>> {
  late final T viewModel;
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_init) {
      viewModel = widget.initViewModel();

      if (viewModel is InteractionMixin) {
        final interactionMixin = viewModel as InteractionMixin;
        interactionMixin.navigate = _navigate;
        interactionMixin.popAndNavigate = _popAndNavigate;
        interactionMixin.pushReplacement = _pushReplacement;
        interactionMixin.pop = _pop;
        interactionMixin.canPop = _canPop;
        interactionMixin.popUntilRoute = _popUntilRoute;
        interactionMixin.bottomSheet = _bottomSheet;
        interactionMixin.inBottomSheetView = _inBottomSheetView;
        interactionMixin.popUntilWithDefaultRoute = _popUntilWithDefaultRoute;
        interactionMixin.loadingOverlay = _loading;
        interactionMixin.theme = Theme.of(context);
        interactionMixin.isCurrent = _isCurrent;
        interactionMixin.navigateAndRemoveUntil = _navigateAndRemoveUntil;
        interactionMixin.getViewModel = _getViewModel;
        interactionMixin.screenHeight = context.height;
        interactionMixin.showFlushBar = (String message, {FlushBarType type = FlushBarType.success}) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        };
      }

      if (viewModel is BaseViewModel) {
        final baseViewModel = viewModel as BaseViewModel;
        baseViewModel.parseArgs(ModalRoute.of(context)?.settings.arguments);
        locator<AppRepository>().addBaseViewModel(baseViewModel);
      }
    }
    _init = true;
  }

  bool _canPop({final bool rootNavigator = false}) {
    return NavigatorUtil.instance.canPop(root: rootNavigator);
  }

  Future<R?>? _pushReplacement<R extends Object?>(
    String routeName, {
    Object? args,
    Object? result,
    bool rootNavigator = false,
  }) {
    return NavigatorUtil.instance.pushReplacement(
      routeName,
      args: args,
      root: rootNavigator,
      result: result,
    );
  }

  Future<R?>? _popAndNavigate<R extends Object?>(
    String routeName, {
    Object? args,
    Object? result,
    bool rootNavigator = false,
  }) {
    return NavigatorUtil.instance.popAndNavigate(
      routeName,
      args: args,
      root: rootNavigator,
      result: result,
    );
  }

  void _popUntilRoute(String routeName, {bool rootNavigator = false}) {
    return NavigatorUtil.instance.popUntilRoute(routeName, root: rootNavigator);
  }

  Future<R?>? _navigateAndRemoveUntil<R extends Object?>(
    String routeName, {
    String? removeUntilRoute,
    Object? args,
    bool rootNavigator = false,
  }) {
    return NavigatorUtil.instance.pushNamedAndRemoveUntil<R>(
      routeName,
      predicate: (route) => route.settings.name == removeUntilRoute,
      root: rootNavigator,
      args: args,
    );
  }

  bool _isCurrent() => ModalRoute.of(context)?.isCurrent ?? false;

  void _popUntilWithDefaultRoute({
    required String routeName,
    required String defaultRouteName,
    final bool root = false,
  }) {
    Navigator.of(context, rootNavigator: root).popUntil(
      (route) =>
          route.settings.name == routeName ||
          route.settings.name == defaultRouteName,
    );
  }

  Future<R?>? _navigate<R extends Object?>(
    String routeName, {
    Object? args,
    bool clearStack = false,
    bool rootNavigator = false,
  }) {
    print("asdas");
    return NavigatorUtil.instance.call<R>(
      routeName,
      args: args,
      clearStack: clearStack,
      root: rootNavigator,
    );
  }

  void _pop<R extends Object?>({R? result, final bool rootNavigator = false}) {
    return NavigatorUtil.instance.pop<R>(result: result, root: rootNavigator);
  }

  VM? _getViewModel<VM extends BaseViewModel<Object?>>() {
    try {
      return context.read<VM>();
    } catch (e) {
      return null;
    }
  }

  bool _inBottomSheetView() =>
      context.findAncestorWidgetOfExactType<BottomSheetView>() != null;

  Future<U?> _bottomSheet<U>({
    required Widget body,
    bool isScrollControlled = true,
    bool enableDrag = true,
    bool isDismissible = true,
  }) async {
    return showModalBottomSheet(
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      barrierColor: TransparentColors.gray900_50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.defaultBorderRadius),
          topRight: Radius.circular(context.defaultBorderRadius),
        ),
      ),
      context: context,
      builder: (context) {
        return PopScope(
          canPop: locator<AppRepository>().onBottomSheetDismiss(),
          child: body,
        );
      },
    ).then((value) {
      locator<AppRepository>().onBottomSheetDismissed(value);
      return value;
    });
  }

  OverlayEntry? _overlayEntry;

  void _loading(bool loading) {
    if (loading) {
      try {
        _overlayEntry?.remove();
      } catch (_) {
      } finally {
        _overlayEntry = OverlayEntry(
          builder: (context) => Stack(
            alignment: Alignment.center,
            children: [
              Container(color: Colors.black.withValues(alpha: 0.3)),
              const ReusableCustomProgress(),
            ],
          ),
        );

        if (rootNavigator.currentState != null &&
            rootNavigator.currentState!.overlay != null) {
          rootNavigator.currentState!.overlay!.insert(_overlayEntry!);
        } else {
          Overlay.of(context).insert(_overlayEntry!);
        }
      }
    } else {
      try {
        _overlayEntry?.remove();
      } catch (_) {
      } finally {
        _overlayEntry = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      child: widget.reactive
          ? ChangeNotifierProvider<T>(
              create: (_) => viewModel,
              child: Consumer<T>(
                builder: (context, viewModel, _) =>
                    widget.builder(context, viewModel),
              ),
            )
          : widget.builder(context, viewModel),
    );
  }

  @override
  void deactivate() {
    if (viewModel is BaseViewModel) {
      (viewModel as BaseViewModel).willDispose();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _overlayEntry?.dispose();
    if (viewModel is BaseViewModel) {
      locator<AppRepository>().removeViewModel(viewModel as BaseViewModel);
    }
    super.dispose();
  }
}
