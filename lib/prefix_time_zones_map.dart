///
/// Copyright (C) 2012 The Libphonenumber Authors
///
/// [license]
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
/// http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
library;

import 'package:dlibphonenumber/phone_prefix_map.dart';

import 'dlibphonenumber.dart';

/// A utility that maps phone number prefixes to a list of strings describing the
/// time zones to which each prefix belongs.
class PrefixTimeZonesMap {
  PrefixTimeZonesMap(List<MapEntry<int, String>> metadata)
      : _phonePrefixMap = PhonePrefixMap(metadata);

  final PhonePrefixMap _phonePrefixMap;

  final String _rawStringTimezonesSeparator = "&";

  /// Returns the list of time zones key] corresponds to.
  ///
  /// <p>
  /// [key] could be the calling country code and the full significant number
  /// of a certain number, or it could be just a phone-number prefix.
  /// For example, the full number 16502530000 (from the phone-number +1 650 253
  /// 0000) is a valid input. Also, any of its prefixes, such as 16502, is also valid.
  ///
  /// [key] the key to look up
  /// returns the list of corresponding time zones.
  List<String> _lookupTimeZonesForNumber(int key) {
    String? timezonesString = _phonePrefixMap.lookup(number: key);
    if (timezonesString == null) {
      return [];
    }
    return _tokenizeRawOutputString(timezonesString);
  }

  /// As per [lookupTimeZonesForNumber(long)], but receives the number as a
  /// PhoneNumber instead of a long.
  ///
  /// [number] the phone number to look up
  /// returns the list of corresponding time zones
  List<String> lookupTimeZonesForNumber(PhoneNumber number) {
    String nationalSignificantNumber =
        PhoneNumberUtil.instance.getNationalSignificantNumber(number);
    int phonePrefix =
        int.parse('${number.countryCode}$nationalSignificantNumber');
    return _lookupTimeZonesForNumber(phonePrefix);
  }

  /// Returns the list of time zones [number]'s calling country code
  /// corresponds to.
  ///
  /// [number] the phone number to look up
  /// returns the list of corresponding time zones
  List<String> lookupCountryLevelTimeZonesForNumber(PhoneNumber number) {
    return _lookupTimeZonesForNumber(number.countryCode);
  }

  /// Split [timezonesString] into all the time zones that are part of it.
  List<String> _tokenizeRawOutputString(String timezonesString) {
    return timezonesString.split(_rawStringTimezonesSeparator);
  }
}
