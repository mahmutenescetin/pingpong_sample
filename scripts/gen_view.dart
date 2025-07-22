import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Kullanım: dart gen_view.dart <view_name>');
    exit(1);
  }

  final viewName = args[0];
  createView(viewName);
}

void createView(String viewName) {
  final viewDirectory = Directory('../lib/views/$viewName');
  if (!viewDirectory.existsSync()) {
    viewDirectory.createSync(recursive: true);
  }

  // View dosyası oluştur
  final viewFile = File('../lib/views/$viewName/${viewName}_view.dart');
  final viewContent = '''
import 'package:flutter/material.dart';

class ${viewName[0].toUpperCase() + viewName.substring(1)}View extends StatelessWidget {
  const ${viewName[0].toUpperCase() + viewName.substring(1)}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${viewName[0].toUpperCase() + viewName.substring(1)}'),
      ),
      body: const Center(
        child: Text('${viewName[0].toUpperCase() + viewName.substring(1)} View'),
      ),
    );
  }
}
''';

  viewFile.writeAsStringSync(viewContent);
  print('✅ ${viewName}_view.dart oluşturuldu');

  // View model dosyası oluştur
  final viewModelFile = File('../lib/views/$viewName/${viewName}_view_model.dart');
  final viewModelContent = '''
import 'package:flutter/material.dart';

class ${viewName[0].toUpperCase() + viewName.substring(1)}ViewModel extends ChangeNotifier {
  // View model logic buraya gelecek
}
''';

  viewModelFile.writeAsStringSync(viewModelContent);
  print('✅ ${viewName}_view_model.dart oluşturuldu');

  // Routes'ları güncelle
  print('🔄 Routes güncelleniyor...');
  Process.runSync('dart', ['gen_routes.dart'], workingDirectory: 'scripts');
  print('✅ Routes güncellendi');
} 