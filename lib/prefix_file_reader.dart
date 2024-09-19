// Based on the Java code .../phonenumbers/prefixmapper/PrefixFileReader.java
//
// Copyright (C) 2011 The Libphonenumber Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:collection';

import 'generated/classes/phone_number/phonenumber.pb.dart';
import 'phone_prefix_map.dart';

/// A helper class doing file handling and lookup of phone number prefix mappings.
class PrefixFileReader {
  PrefixFileReader(this._configData, this._assetData) {
    _loadMappingFileProvider();
  }

  final Map<int, List<String>> _configData;
  final Map<String, Map<int, String>> _assetData;

  final List<Set<String>> _availableLanguages = [];

  final List<int> _countryCallingCodes = [];

  final HashMap<String, PhonePrefixMap> _availablePhonePrefixMaps = HashMap();

  final Map<String, String> _localeNormalizationMap = {
    'zh_TW': 'zh_Hant',
    'zh_HK': 'zh_Hant',
    'zh_MO': 'zh_Hant',
  };

  PhonePrefixMap? _getPhonePrefixDescriptions(
      int prefixMapKey, String language, String script, String region) {
    String fileName = _getFileName(prefixMapKey, language, script, region);
    if (fileName.isEmpty) {
      return null;
    }

    if (!_availablePhonePrefixMaps.containsKey(fileName)) {
      _loadPhonePrefixMapFromFile(fileName);
    }

    return _availablePhonePrefixMaps[fileName];
  }

  void _loadMappingFileProvider() {
    for (MapEntry<int, List<String>> e in _configData.entries) {
      _countryCallingCodes.add(e.key);
      _availableLanguages.add(Set.from(e.value));
    }
  }

  void _loadPhonePrefixMapFromFile(String fileName) {
    Map<int, String>? location = _assetData[fileName];

    if (location != null) {
      final map = PhonePrefixMap(location.entries.toList());
      _availablePhonePrefixMaps[fileName] = map;
    } else {
      throw Exception('could not find a file with name: $fileName');
    }
  }

  /// Gets the name of the file that contains the mapping data for the {@code countryCallingCode} in
  /// the language specified.
  ///
  /// [countryCallingCode] the country calling code of phone numbers which the data file contains
  /// [language] two or three-letter lowercase ISO language codes as defined by ISO 639. Note
  /// that where two different language codes exist (e.g. 'he' and 'iw' for Hebrew) we use the
  /// one that Java/Android canonicalized on ('iw' in this case).
  /// [script] four-letter titlecase (the first letter is uppercase and the rest of the letters
  /// are lowercase) ISO script codes as defined in ISO 15924
  /// [region] two-letter uppercase ISO country codes as defined by ISO 3166-1
  /// returns the name of the file, or empty string if no such file can be found
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

  /// Returns a text description in the given language for the given phone number.
  ///
  /// [number]    the phone number for which we want to get a text description
  /// [language]  two or three-letter lowercase ISO language codes as defined
  ///                 by ISO 639. Note
  ///                 that where two different language codes exist (e.g. 'he' and
  ///                 'iw' for Hebrew) we use the
  ///                 one that Java/Android canonicalized on ('iw' in this case).
  /// [script]    four-letter titlecase (the first letter is uppercase and the
  ///                 rest of the letters
  ///                 are lowercase) ISO script code as defined in ISO 15924
  /// [region]    two-letter uppercase ISO country code as defined by ISO 3166-1
  ///
  /// returns a text description in the given language for the given phone number,
  ///         or an empty string if a description is not available
  String getDescriptionForNumber(
      PhoneNumber number, String language, String script, String region) {
    int countryCallingCode = number.countryCode;
    // As the NANPA data is split into multiple files covering 3-digit areas, use a
    // phone number prefix of 4 digits for NANPA instead, e.g. 1650.
    int phonePrefix = (countryCallingCode != 1)
        ? countryCallingCode
        : (1000 + (number.nationalNumber.toInt() ~/ 10000000));
    PhonePrefixMap? phonePrefixDescriptions =
        _getPhonePrefixDescriptions(phonePrefix, language, script, region);

    String? description = (phonePrefixDescriptions != null)
        ? phonePrefixDescriptions.lookup(phoneNumber: number)
        : null;

    // When a location is not available in the requested language, fall back to English.
    if ((description == null || description.isEmpty) &&
        _mayFallBackToEnglish(language)) {
      PhonePrefixMap? defaultMap =
          _getPhonePrefixDescriptions(phonePrefix, "en", "", "");
      if (defaultMap == null) {
        return '';
      }
      description = defaultMap.lookup(phoneNumber: number);
    }

    return (description != null) ? description : '';
  }

  bool _mayFallBackToEnglish(String lang) {
    // Don't fall back to English if the requested language is among the following:
    // - Chinese
    // - Japanese
    // - Korean
    return lang != "zh" && lang != "ja" && lang != "ko";
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
