import 'dart:io';
import 'package:yaml_edit/yaml_edit.dart';

void main() async {
  final file = File('pubspec.yaml');
  if (!file.existsSync()) {
    print('❌ pubspec.yaml not found.');
    exit(1);
  }

  final content = await file.readAsString();
  final editor = YamlEditor(content);

  // 1. Add flutter SDK to dependencies if not present
  // We need to be careful not to overwrite valid existing deps
  final dependencies = editor.parseAt(['dependencies']);
  bool hasFlutterSdk = false;

  // Checking if flutter is already there.
  // yaml_edit doesn't give easy "exists" check without throwing sometimes,
  // using try-catch or simple check.
  try {
    final flutterDep = editor.parseAt(['dependencies', 'flutter']);
    // if no error, it exists.
    hasFlutterSdk = true;
  } catch (e) {
    // missing
  }

  if (!hasFlutterSdk) {
    print('📦 Adding flutter sdk dependency...');
    editor.update(['dependencies', 'flutter'], {'sdk': 'flutter'});
  }

  // 2. Add flutter assets
  // Upstream might (rarely) have other assets. We should ensure we don't wipe them if we want to be 100% safe,
  // but usually a pure dart package has none.
  try {
    final flutterSection = editor.parseAt(['flutter']);
    // If flutter section exists, check assets
    try {
      final assets = editor.parseAt(['flutter', 'assets']);
      // assets exists, we should append if not present
      final List existingAssets = assets.value as List;
      if (!existingAssets.contains('assets/geocoding/')) {
        print('📂 Appending assets/geocoding/ to existing assets...');
        editor.appendToList(['flutter', 'assets'], 'assets/geocoding/');
      }
      if (!existingAssets.contains('assets/carrier/')) {
        print('📂 Appending assets/carrier/ to existing assets...');
        editor.appendToList(['flutter', 'assets'], 'assets/carrier/');
      }
    } catch (e) {
      // assets missing in flutter section
      print('📂 Adding assets section...');
      editor.update(
          ['flutter', 'assets'], ['assets/geocoding/', 'assets/carrier/']);
    }
  } catch (e) {
    // flutter section missing
    print('🚀 Adding flutter section with assets...');
    editor.update([
      'flutter'
    ], {
      'assets': ['assets/geocoding/', 'assets/carrier/']
    });
  }

  await file.writeAsString(editor.toString());
  print('✅ pubspec.yaml updated successfully.');
}
