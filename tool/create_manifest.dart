import 'dart:convert';
import 'dart:io';

const configs = [
  {'dir': 'assets/geocoding/'},
  {'dir': 'assets/carrier/'},
];

void main() {
  for (final config in configs) {
    _generate(config['dir']!);
  }
}

void _generate(String assetsDir) {
  final manifestPath = '${assetsDir}manifest.json';
  final directory = Directory(assetsDir);
  if (!directory.existsSync()) {
    print('❌ Error: Assets directory not found at $assetsDir');
    return;
  }

  print('🏁 Generating manifest for $assetsDir...');
  final files = directory.listSync().whereType<File>().where(
      (f) => f.path.endsWith('.json') && !f.path.endsWith('manifest.json'));

  // structure: { "countryCode": ["file1.json", "file2.json"] }
  final Map<String, List<String>> manifest = {};

  for (final file in files) {
    final filename = file.uri.pathSegments.last;
    // filename format: 86_en.json
    final parts = filename.split('_');
    if (parts.length >= 2) {
      final countryCode = parts[0];
      if (!manifest.containsKey(countryCode)) {
        manifest[countryCode] = [];
      }
      manifest[countryCode]!.add(filename);
    }
  }

  // Sort lists for consistency
  for (final key in manifest.keys) {
    manifest[key]!.sort();
  }

  // Sort keys
  final sortedKeys = manifest.keys.toList()..sort();
  final Map<String, List<String>> sortedManifest = {
    for (var key in sortedKeys) key: manifest[key]!
  };

  final jsonString = JsonEncoder.withIndent('  ').convert(sortedManifest);
  File(manifestPath).writeAsStringSync(jsonString);

  print('✅ Manifest generated at $manifestPath');
  print('   Covered ${sortedManifest.length} country codes.');
}
