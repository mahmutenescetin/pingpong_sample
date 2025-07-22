import 'dart:io';

import 'utils.dart';

const String appPath = '../lib';

void main(List<String> args) {
  addRoutes();
  addViews();
}

void addRoutes() {
  const String routeFilePath = '$appPath/routes/routes.g.dart';
  final StringBuffer routeFileContent = StringBuffer();

  routeFileContent.writeln(
    '''
/// GENERATED CODE - DO NOT MODIFY BY HAND [gen_routes.dart]
''',
  );

  final viewDirectory = Directory('$appPath/views/');

  final List<String> views =
      viewDirectory.listSync().map((e) => e.path.split('/').last).toList()
        ..remove('.DS_Store')
        ..sort();

  views.sort();

  routeFileContent.writeln(
    'class Routes {',
  );

  final List<String> routes = [];

  for (final view in views) {
    String viewAsCamelCase = view.snakeToCamelCase();

    if (viewAsCamelCase.contains('Webview')) {
      viewAsCamelCase = viewAsCamelCase.replaceAll('Webview', 'WebView');
    }

    routes.add(
      '''  static const String $viewAsCamelCase = '/$viewAsCamelCase';\n''',
    );
  }

  routes.sortByLength();
  routeFileContent.writeAll(routes);

  routeFileContent.writeln('}');

  writeFile(routeFilePath, routeFileContent.toString());
}

void addViews() {
  const String createViewFilePath = '$appPath/routes/create_view.dart';
  final StringBuffer createViewFileContent = StringBuffer();

  createViewFileContent.writeln(
    '''
/// GENERATED CODE - DO NOT MODIFY BY HAND [gen_routes.dart]
import 'package:flutter/material.dart';
''',
  );

  final viewDirectory = Directory('$appPath/views/');

  final List<String> views =
      viewDirectory.listSync().map((e) => e.path.split('/').last).toList()
        ..remove('.DS_Store')
        ..sort();

  final List<String> importFiles = [];
  for (final view in views) {
    importFiles.add(
      '''import 'package:pingpong_sample/views/$view/${view}_view.dart';\n''',
    );
  }

  createViewFileContent.writeAll(importFiles);
  createViewFileContent.writeln(
      '''import 'package:pingpong_sample/routes/routes.g.dart';''');

  createViewFileContent.writeln(
    '''
\nWidget? createView(String route) {
  switch (route) {''',
  );

  views.sortByLength();

  for (final view in views) {
    final String viewAsCamelCase = view.snakeToCamelCase();
    final String viewAsPascalCase = view.snakeToPascalCase();

    createViewFileContent.writeln(
      '''
    case Routes.$viewAsCamelCase:
      return ${viewAsPascalCase}View();''',
    );
  }

  createViewFileContent.writeln(
    '''
    default:
      return null;
  }
}''',
  );

  writeFile(createViewFilePath, createViewFileContent.toString());
}
