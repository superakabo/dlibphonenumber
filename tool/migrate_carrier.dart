import 'dart:convert';
import 'dart:io';

// This script migrates carrier data from the original Dart source files to JSON assets.
// Based on tool/migrate.dart

const sourceDir = 'lib/generated/metadata/carrier/';
const destinationDir = 'assets/carrier/';

void main() async {
  final source = Directory(sourceDir);
  if (!source.existsSync()) {
    print('❌ CRITICAL: Source directory not found at $sourceDir');
    exit(1);
  }

  final destination = Directory(destinationDir);
  if (!destination.existsSync()) {
    print('Destination directory $destinationDir not found, creating it...');
    await destination.create(recursive: true);
  }

  print('🏁 Starting Carrier migration...');
  print('   Source:      ${source.path}');
  print('   Destination: ${destination.path}');

  final files = source
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));
  print('Found ${files.length} Dart files to process.');

  // Regex to capture the map returned by the function.
  final mapContentRegex = RegExp(r'return\s*(\{[\s\S]*?\});');

  // Regex to match keys and values.
  final pairRegex = RegExp(r'(\d+)\s*:\s*(?:"([^"\\]*(?:\\.[^"\\]*)*)"|' +
      "'([^'\\\\]*(?:\\\\.[^'\\\\]*)*)')");

  int successCount = 0;
  int failCount = 0;

  for (final file in files) {
    final filename = file.uri.pathSegments.last;
    final jsonFilename = filename.replaceFirst('.dart', '.json');
    final destinationPath = '$destinationDir/$jsonFilename';

    try {
      final content = await file.readAsString();
      final match = mapContentRegex.firstMatch(content);

      if (match == null) {
        print('🟡 WARN: No data map found in $filename.');
        continue;
      }

      final mapString = match.group(1)!;

      final Map<String, String> inMemoryMap = {};
      final allMatches = pairRegex.allMatches(mapString);

      for (final pairMatch in allMatches) {
        final key = pairMatch.group(1)!;
        String value;

        if (pairMatch.group(2) != null) {
          // Double quoted string
          value = pairMatch
              .group(2)!
              .replaceAll(r'\"', '"')
              .replaceAll(r'\\', '\\');
        } else {
          // Single quoted string
          value = pairMatch
              .group(3)!
              .replaceAll(r"\'", "'")
              .replaceAll(r'\\', '\\');
        }
        inMemoryMap[key] = value;
      }

      final jsonString = JsonEncoder.withIndent('  ').convert(inMemoryMap);
      await File(destinationPath).writeAsString(jsonString);
      successCount++;
    } catch (e) {
      print('❌ ERROR: Failed to process $filename: $e');
      failCount++;
    }
  }

  print('\n' + ('-' * 20));
  print('🎉 Carrier Migration Complete!');
  print('   Successful: $successCount');
  print('   Failed:     $failCount');
  print(('-' * 20));
}
