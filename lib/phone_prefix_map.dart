// Based on the Java code .../phonenumbers/prefixmapper/PhonePrefixMap.java
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
import 'phone_number_util.dart';

/// A utility that maps phone number prefixes to a description string,
/// which maybe, for example, the geographical area the prefix covers.
class PhonePrefixMap {
  PhonePrefixMap(this._metadata);

  final PhoneNumberUtil _phoneUtil = PhoneNumberUtil.instance;

  final List<MapEntry<int, String>> _metadata;

  /// As per [_lookup(long)], but receives the number as a PhoneNumber
  /// instead of a long.
  ///
  /// [number] the phone number to look up
  /// returns the description corresponding to the prefix that best matches this
  /// phone number
  String? lookup({PhoneNumber? phoneNumber, int? number}) {
    if (number != null) {
      return _lookup(number);
    }

    if (phoneNumber != null) {
      String nationalSignificantNumber =
          _phoneUtil.getNationalSignificantNumber(phoneNumber);
      int phonePrefix =
          int.parse('${phoneNumber.countryCode}$nationalSignificantNumber');
      return _lookup(phonePrefix);
    }

    return null;
  }

  /// Returns the description of the [number]. This method distinguishes the
  /// case of an invalid prefix and a prefix for which the name is not
  /// available in the current language. If the description is not available in
  /// the current language an empty string is returned. If no
  /// description was found for the provided number, null is returned.
  ///
  /// [number] the phone number to look up
  /// returns the description of the number
  String? _lookup(int number) {
    int numOfEntries = _metadata.length;
    if (numOfEntries == 0) return null;

    int phonePrefix = number;
    int currentIndex = numOfEntries - 1;
    SplayTreeSet<int> currentSetOfLengths =
        SplayTreeSet.from(_metadata.map((e) => '${e.key}'.length));

    while (currentSetOfLengths.isNotEmpty) {
      int possibleLength = currentSetOfLengths.last;
      String phonePrefixStr = '$phonePrefix';

      if (phonePrefixStr.length > possibleLength) {
        phonePrefix = int.parse(phonePrefixStr.substring(0, possibleLength));
      }

      currentIndex = _binarySearch(0, currentIndex, phonePrefix);
      if (currentIndex < 0) {
        return null;
      }

      int currentPrefix = _metadata[currentIndex].key;
      if (phonePrefix == currentPrefix) {
        return _metadata[currentIndex].value;
      }

      currentSetOfLengths = SplayTreeSet.from(
          currentSetOfLengths.where((e) => e < possibleLength));
    }
    return null;
  }

  int _binarySearch(int start, int end, int value) {
    int current = 0;
    while (start <= end) {
      current = (start + end) >>> 1;
      int currentValue = _metadata[current].key;
      if (currentValue == value) {
        return current;
      } else if (currentValue > value) {
        current--;
        end = current;
      } else {
        start = current + 1;
      }
    }
    return current;
  }
}
