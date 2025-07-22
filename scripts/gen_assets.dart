// ignore_for_file: cascade_invocations

import 'string_templates.dart';
import 'utils.dart';

void main(List<String> args) {
  const assetsPath = '../assets';
  const folders = <String>['images'];

  /// Generates [app_assets.g.dart] file with all the assets.
  generateAppAssetsFile(
    assetsPath: assetsPath,
    folders: folders,
  );
}

void generateAppAssetsFile({
  required String assetsPath,
  required List<String> folders,
}) {
  final assetFileContent = StringBuffer();

  assetFileContent.writeln(StringTemplates.header);
  assetFileContent.writeln('''
part of 'package:pingpong_sample/themes/models/assets.g.dart';
''');

  assetFileContent.writeln('mixin _AppAssets {');
  assetFileContent.writeln('  // Base Asset Paths');

  for (final folder in folders) {
    final assets = getAssets('$assetsPath/$folder/');

    assetFileContent.writeln(
      '''  ${assets.isEmpty ? '// ' : ''}static const String _base${folder.pluralToSingular().toFirstUpperCase()}Path = 'assets/$folder';''',
    );
  }

  for (final folder in folders) {
    assetFileContent.writeln();

    assetFileContent.writeln('  // ${folder.toUpperCase()}');

    final rawAssets = getAssets('$assetsPath/$folder/');

    if (rawAssets.isEmpty) {
      continue;
    }
    final assets = rawAssets.map((e) => e.path.split('/').last).toList()
      ..sortByLength();

    for (final asset in assets) {
      assetFileContent.write(
        '''
  static const String ${asset.split('.').first.snakeToCamelCase()} = '\$_base${folder.pluralToSingular().toFirstUpperCase()}Path/$asset';
''',
      );
    }
  }

  assetFileContent.writeln('}');

  writeFile(
    '../lib/constants/app_assets.g.dart',
    assetFileContent.toString(),
  );
}
