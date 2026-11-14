import 'dart:convert';
import 'dart:io';

// This script migrates data from the original Dart source files to JSON assets.
// It is designed to be run once to perform the data format conversion.

// Adjusted path based on actual project structure.
const sourceDir = 'lib/generated/metadata/geocoding/';
const destinationDir = 'assets/geocoding/';

void main() async {
  final source = Directory(sourceDir);
  if (!source.existsSync()) {
    print('❌ CRITICAL: Source directory not found at $sourceDir.');
    print('Current working directory: ${Directory.current.path}');
    exit(1);
  }

  final destination = Directory(destinationDir);
  if (!destination.existsSync()) {
    print('Destination directory $destinationDir not found, creating it...');
    await destination.create(recursive: true);
  }

  print('🏁 Starting migration...');
  print('   Source:      ${source.path}');
  print('   Destination: ${destination.path}');

  final files = source
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));
  print('Found ${files.length} Dart files to process.');

  // Regex to capture the map returned by the function.
  // Matches "return {" ... "};"
  // Using [\s\S] to match across lines.
  final mapContentRegex = RegExp(r'return\s*(\{[\s\S]*?\});');

  // Regex to match keys and values.
  // Supports both single quotes 'value' and double quotes "value".
  // Group 1: key (digits)
  // Group 2: double quoted value content
  // Group 3: single quoted value content
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
        print(
            '🟡 WARN: No data map found in $filename. Content preview: ${content.substring(0, content.length > 100 ? 100 : content.length).replaceAll('\n', ' ')}');
        continue;
      }

      final mapString = match.group(1)!;

      // --- Step 2: Parse and Build In-Memory Map ---
      final Map<String, String> inMemoryMap = {};
      final allMatches = pairRegex.allMatches(mapString);

      if (allMatches.isEmpty) {
        // print('🟡 WARN: Empty map in $filename?');
      }

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

      // --- Step 3: Serialize to JSON ---
      final jsonString = JsonEncoder.withIndent('  ').convert(inMemoryMap);

      // --- Step 4: Write to file ---
      await File(destinationPath).writeAsString(jsonString);
      // print('✅ Migrated $filename');
      successCount++;
    } catch (e, s) {
      print('❌ ERROR: Failed to process $filename: $e');
      // print(s);
      failCount++;
    }
  }

  print('\n' + ('-' * 20));
  print('🎉 Migration Complete!');
  print('   Successful: $successCount');
  print('   Failed:     $failCount');
  print(('-' * 20));
}
