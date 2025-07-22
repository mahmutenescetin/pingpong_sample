mixin StringTemplates {
  static const String viewModelTemplate = '''
import 'package:pingpong_sample/src/common/base_view_model.dart';

final class {VIEW_NAME}ViewModel extends BaseViewModel {
  @override
  void onBindingCreated() {}
}
''';

  static const String viewTemplate = '''
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingpong_sample/src/common/view_model_builder.dart';
import 'package:pingpong_sample/src/common/widgets/scaffold_view.dart';
import 'package:pingpong_sample/src/utils/extensions/context_extensions.dart';
import 'package:pingpong_sample/src/views/{SNAKE_NAME}/{SNAKE_NAME}_view_model.dart';

final class {VIEW_NAME}View extends StatelessWidget {
  const {VIEW_NAME}View({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<{VIEW_NAME}ViewModel>(
      initViewModel: () => {VIEW_NAME}ViewModel(),
      builder: (context, viewModel) => ScaffoldView(
        appBar: AppBar(
          title: const Text('{VIEW_NAME}View'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.hGap),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap(context.vGap),
              const Text(
                '{VIEW_NAME}ViewDescription',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''';

  static const String header = '''
// GENERATED CODE - DO NOT MODIFY BY HAND [gen_assets.dart]
''';

  static const String ignores = '''
// ignore_for_file: lines_longer_than_80_chars
''';
}
