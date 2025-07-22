// ignore_for_file: cascade_invocations

import 'dart:convert';
import 'dart:io';

dynamic readFile({required String path, bool isJson = false}) {
  final file = File(path);

  final String result = file.readAsStringSync();

  if (isJson) {
    json.decode(result);
  }

  return result;
}

void writeFile(String path, String data) {
  final File file = File(path);

  file.writeAsStringSync(data);
}

List<FileSystemEntity> getAssets(String path) {
  final directory = Directory(path);

  if (directory.existsSync()) {
    return directory.listSync()
      ..removeWhere((asset) => asset.path.contains('.DS_Store'));
  }

  return [];
}

extension StringExtensions on String {
  String toFirstUpperCase() => this[0].toUpperCase() + substring(1);

  String snakeToPascalCase() {
    final words = split('_');

    for (int i = 0; i < words.length; i++) {
      words[i] = words[i].toFirstUpperCase();
    }

    return words.join().replaceMistakenWords();
  }

  String snakeToCamelCase() {
    final words = split('_');

    for (int i = 0; i < words.length; i++) {
      if (i == 0) {
        continue;
      }
      words[i] = words[i].toFirstUpperCase();
    }

    return words.join().replaceMistakenWords();
  }

  String pluralToSingular() {
    if (endsWith('s')) {
      return substring(0, length - 1);
    } else {
      return this;
    }
  }

  String replaceMistakenWords() {
    if (startsWith('Qr')) {
      return replaceFirst('Qr', 'QR');
    }

    return replaceAll('Iban', 'IBAN')
        .replaceAll('Faq', 'FAQ')
        .replaceAll('Otp', 'OTP')
        .replaceAll('Sms', 'SMS');
  }
}

extension ListExtensions on List<String> {
  void sortByLength() => sort((a, b) => a.length.compareTo(b.length));
}
