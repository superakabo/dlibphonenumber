import 'dart:convert';
import 'package:flutter/services.dart';

/// Class to handle lazy loading of carrier data from JSON assets.
class CarrierLoader {
  final Map<int, List<String>> _configData;
  final Map<String, Map<int, String>> _locations;
  final List<int> _countryCallingCodes = [];
  final List<Set<String>> _availableLanguages = [];

  // Cache loaded files to avoid re-decoding JSON (though _locations already acts as cache)
  final Set<String> _loadedFiles = {};

  // Manifest mapping country code to list of available files
  // e.g. "86": ["86_en.json", "86_zh.json"]
  Map<String, List<String>>? _manifest;

  CarrierLoader(this._configData, this._locations) {
    _loadMappingFileProvider();
  }

  Future<void> init() async {
    if (_manifest != null) return;
    try {
      final manifestJson = await rootBundle
          .loadString('packages/dlibphonenumber/assets/carrier/manifest.json');
      final Map<String, dynamic> decoded = jsonDecode(manifestJson);
      _manifest = decoded.map((k, v) => MapEntry(k, List<String>.from(v)));
    } catch (e) {
      print('Error loading carrier manifest: $e');
      _manifest = {};
    }
  }

  /// Ensures that the metadata for the given number and locale is loaded into the carrier map.
  Future<void> ensureLoaded(int countryCallingCode, String language,
      String script, String region) async {
    if (_manifest == null) await init();

    final fileName = _getFileName(countryCallingCode, language, script, region);
    if (fileName.isEmpty) return;

    if (_loadedFiles.contains(fileName)) return;
    if (_locations.containsKey(fileName)) {
      _loadedFiles.add(fileName);
      return;
    }

    // Load from asset
    final assetPath = 'packages/dlibphonenumber/assets/carrier/$fileName.json';
    try {
      final jsonStr = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
      // Convert Map<String, dynamic> to Map<int, String>
      final Map<int, String> data = {};
      jsonMap.forEach((key, value) {
        if (value is String) {
          data[int.parse(key)] = value;
        }
      });

      _locations[fileName] = data;
      _loadedFiles.add(fileName);
    } catch (e) {
      // print('Failed to load asset $assetPath: $e');
      _loadedFiles.add(fileName);
    }
  }

  void _loadMappingFileProvider() {
    for (MapEntry<int, List<String>> e in _configData.entries) {
      _countryCallingCodes.add(e.key);
      _availableLanguages.add(Set.from(e.value));
    }
  }

  // --- Logic copied and adapted from PrefixFileReader ---

  final Map<String, String> _localeNormalizationMap = {
    'zh_TW': 'zh_Hant',
    'zh_HK': 'zh_Hant',
    'zh_MO': 'zh_Hant',
  };

  String _getFileName(
      int countryCallingCode, String language, String script, String region) {
    if (language.isEmpty) {
      return "";
    }

    int index = _binarySearch(_countryCallingCodes, countryCallingCode);
    if (index < 0) {
      return "";
    }
    Set<String> setOfLangs = _availableLanguages[index];
    if (setOfLangs.isNotEmpty) {
      String languageCode =
          _findBestMatchingLanguageCode(setOfLangs, language, script, region);
      if (languageCode.isNotEmpty) {
        StringBuffer fileName = StringBuffer();
        fileName
          ..write(countryCallingCode)
          ..write('_')
          ..write(languageCode);

        return fileName.toString();
      }
    }
    return "";
  }

  String _findBestMatchingLanguageCode(
      Set<String> setOfLangs, String language, String script, String region) {
    StringBuffer fullLocale = _constructFullLocale(language, script, region);
    String fullLocaleStr = fullLocale.toString();
    String? normalizedLocale = _localeNormalizationMap[fullLocaleStr];
    if (normalizedLocale != null) {
      if (setOfLangs.contains(normalizedLocale)) {
        return normalizedLocale;
      }
    }
    if (setOfLangs.contains(fullLocaleStr)) {
      return fullLocaleStr;
    }

    if (_onlyOneOfScriptOrRegionIsEmpty(script, region)) {
      if (setOfLangs.contains(language)) {
        return language;
      }
    } else if (script.isNotEmpty && region.isNotEmpty) {
      StringBuffer langWithScript = StringBuffer(language)
        ..write('_')
        ..write(script);
      String langWithScriptStr = langWithScript.toString();
      if (setOfLangs.contains(langWithScriptStr)) {
        return langWithScriptStr;
      }

      StringBuffer langWithRegion = StringBuffer(language)
        ..write('_')
        ..write(region);
      String langWithRegionStr = langWithRegion.toString();
      if (setOfLangs.contains(langWithRegionStr)) {
        return langWithRegionStr;
      }

      if (setOfLangs.contains(language)) {
        return language;
      }
    }
    return "";
  }

  bool _onlyOneOfScriptOrRegionIsEmpty(String script, String region) {
    return (script.isEmpty && region.isNotEmpty) ||
        (region.isEmpty && script.isNotEmpty);
  }

  StringBuffer _constructFullLocale(
      String language, String script, String region) {
    StringBuffer fullLocale = StringBuffer(language);
    _appendSubsequentLocalePart(script, fullLocale);
    _appendSubsequentLocalePart(region, fullLocale);
    return fullLocale;
  }

  void _appendSubsequentLocalePart(
      String subsequentLocalePart, StringBuffer fullLocale) {
    if (subsequentLocalePart.isNotEmpty) {
      fullLocale
        ..write('_')
        ..write(subsequentLocalePart);
    }
  }

  int _binarySearch(List<int> list, int key) {
    int min = 0;
    int max = list.length - 1;

    while (min <= max) {
      int mid = min + ((max - min) ~/ 2);
      int midValue = list[mid];

      if (midValue == key) {
        return mid;
      } else if (midValue < key) {
        min = mid + 1;
      } else {
        max = mid - 1;
      }
    }

    return -1;
  }
}
