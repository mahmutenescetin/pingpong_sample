import 'package:flutter/cupertino.dart';
import 'package:pingpong_sample/common/base_view_model.dart';
import 'package:pingpong_sample/common/mixins/overlay_mixin.dart';

class AppRepository extends ChangeNotifier with OverlayMixin {
  final List<BaseViewModel> _baseViewModels = [];

  void addBaseViewModel(BaseViewModel baseViewModel) {
    _baseViewModels.add(baseViewModel);
    Future.delayed(const Duration(milliseconds: 100), () => notifyListeners());
  }

  void removeViewModel(BaseViewModel baseViewModel) {
    _baseViewModels.remove(baseViewModel);
    Future.delayed(const Duration(milliseconds: 100), () => notifyListeners());
  }

  BaseViewModel get lastViewModel => _baseViewModels.last;

  bool onBottomSheetDismiss() {
    if (_baseViewModels.length > 1) {
      return lastViewModel.onBottomSheetDismiss();
    }

    return false;
  }

  Future<void> onBottomSheetDismissed<T>(T value) async =>
      await lastViewModel.onBottomSheetDismissed(value);

  bool get onBottomSheetDraggable => lastViewModel.onBottomSheetDraggable;
}
