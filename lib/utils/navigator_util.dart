import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> rootNavigator = GlobalKey();

GlobalKey<NavigatorState>? childNavigator;

class NavigatorUtil {
  const NavigatorUtil._();

  static const NavigatorUtil instance = NavigatorUtil._();

  Future<T?> push<T extends Object?>(
    final String routeName, {
    final bool pop = false,
    final Object? args,
    final Object? result,
    final bool root = false,
    final bool clearStack = false,
  }) async {
    final state = getCurrentNavigatorState(root);

    if (clearStack) {
      return state.pushNamedAndRemoveUntil<T>(
        routeName,
        (route) => false,
        arguments: args,
      );
    }
    if (pop) {
      return state.pushReplacementNamed<T, Object>(
        routeName,
        arguments: args,
        result: result,
      );
    }
    return state.pushNamed<T>(routeName, arguments: args);
  }

  Future<T?> call<T extends Object?>(
    final String routeName, {
    final bool pop = false,
    final Object? args,
    final bool root = false,
    final bool clearStack = false,
  }) =>
      push<T>(
        routeName,
        pop: pop,
        args: args,
        root: root,
        clearStack: clearStack,
      );

  void popUntilRoute(
    final String routeName, {
    final bool root = false,
  }) {
    final state = getCurrentNavigatorState(root);
    state.popUntil(
      (route) => route.settings.name == routeName,
    );
  }

  void popUntilWithDefaultRoute({
    required String routeName,
    required String defaultRouteName,
    final bool root = false,
  }) {
    final state = getCurrentNavigatorState(root);
    state.popUntil(
      (route) =>
          route.settings.name == routeName ||
          route.settings.name == defaultRouteName,
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    final String routeName, {
    required final bool Function(Route<dynamic>) predicate,
    final Object? args,
    final bool root = false,
  }) async {
    final state = getCurrentNavigatorState(root);
    return state.pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: args,
    );
  }

  Future<T?> pushReplacement<T extends Object?>(
    final String routeName, {
    final Object? args,
    final Object? result,
    final bool root = false,
  }) async {
    final state = getCurrentNavigatorState(root);
    return state.pushReplacementNamed(routeName,
        arguments: args, result: result);
  }

  Future<T?> popAndNavigate<T extends Object?>(
    final String routeName, {
    final Object? args,
    final Object? result,
    final bool root = false,
  }) async {
    final state = getCurrentNavigatorState(root);
    return state.popAndPushNamed(routeName, arguments: args, result: result);
  }

  bool canPop({final bool root = false}) {
    final state = getCurrentNavigatorState(root);
    return state.canPop();
  }

  void clearStack([
    final bool root = true,
  ]) {
    final state = getCurrentNavigatorState(root);
    state.popUntil((route) => false);
  }

  void pop<T extends Object?>({
    final T? result,
    final bool root = false,
  }) {
    final state = getCurrentNavigatorState(root);
    final canPop = state.canPop();
    if (canPop) {
      state.pop<T>(result);
    } else {
      getCurrentNavigatorState(true).pop<T>(result);
    }
  }

  NavigatorState getCurrentNavigatorState(bool root) {
    NavigatorState state = rootNavigator.currentState!;

    if (childNavigator != null &&
        childNavigator!.currentState != null &&
        !root) {
      state = childNavigator!.currentState!;
    }

    return state;
  }
}
