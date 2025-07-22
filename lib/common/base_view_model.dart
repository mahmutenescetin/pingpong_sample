import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:pingpong_sample/common/enums/dynamic_result_type.dart';
import 'package:pingpong_sample/common/interaction_mixin.dart';
import 'package:pingpong_sample/common/widgets/bottom_sheet_view.dart';
import 'package:pingpong_sample/common/widgets/dynamic_result_bottom_sheet.dart';

abstract class BaseViewModel<VA> extends ChangeNotifier with InteractionMixin {
  VA? arguments;

  VA get args => arguments!;
  bool isBusy = false;
  bool mounted = false;
  bool _showLoading = false;
  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  bool get showLoading => _showLoading;

  set showLoading(bool value) {
    _showLoading = value;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadingOverlay(value);
    });
  }

  @protected
  @visibleForTesting
  VA parseArgsFromJson(Map<String, dynamic> args) {
    throw UnimplementedError(
      'parseArgsFromJson method must be implemented in child class',
    );
  }

  void parseArgs([Object? args]) {
    if (args != null && args is VA) {
      arguments = args as VA?;
    } else if (args != null && args is Map) {
      arguments = parseArgsFromJson(args as Map<String, dynamic>);
    }

    if (!mounted) {
      onBindingCreated();
      mounted = true;
    }
  }

  void notify() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @protected
  @visibleForTesting
  void onBindingCreated() {}

  void willDispose() {}

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  int _flowCount = 0;

  Future<void> flowWithFirestore<T>({
    required Future<T> Function() callback,
    ValueChanged<T>? onSuccess,
    void Function(FirebaseException exception)? onError,
    void Function()? onFinally,
    bool showLoading = true,
    bool shouldWaitOtherFlows = false,
    bool showGenericErrorPopUp = true,
  }) async {
    _flowCount++;
    this.showLoading = showLoading;
    isBusy = true;
    notify();

    try {
      final T result = await callback();
      onSuccess?.call(result);
    } on FirebaseException catch (e) {
      if (showGenericErrorPopUp) {
        bottomSheet(
          body: BottomSheetView(
            child: DynamicResultBottomSheet(
              title: e.message ?? "Firestore Hatası",
              description: "Bir hata oluştu",
              status: DynamicResultType.fail,
            ),
          ),
        );
      }
      onError?.call(e);
      if (kDebugMode) {
        throw Exception('${e.message}\n${e.stackTrace}');
      }
    } catch (e, s) {
      bottomSheet(
        body: BottomSheetView(
          child: DynamicResultBottomSheet(
            title: "Hata",
            description: "Hata",
            status: DynamicResultType.fail,
          ),
        ),
      );

      if (kDebugMode) {
        throw Exception('$e\n$s');
      }
    } finally {
      onFinally?.call();

      _flowCount--;
      if (!shouldWaitOtherFlows || _flowCount == 0) {
        this.showLoading = false;
      }

      isBusy = false;
      notify();
    }
  }

  bool onBottomSheetDismiss() {
    return true;
  }

  Future<void> onBottomSheetDismissed<T>(T value) async {}

  bool get onBottomSheetDraggable => true;
}
