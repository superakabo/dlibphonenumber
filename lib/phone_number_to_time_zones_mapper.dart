/*
 * Copyright (C) 2012 The Libphonenumber Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:meta/meta.dart';

import 'enums/phone_number_type.dart';
import 'generated/classes/phone_number/phonenumber.pb.dart';
import 'generated/metadata/timezone_metadata_map.dart';
import 'phone_number_util.dart';
import 'prefix_time_zones_map.dart';

/// An offline mapper from phone numbers to time zones.
class PhoneNumberToTimeZonesMapper {
  static PhoneNumberToTimeZonesMapper get instance => _instance;
  static final PhoneNumberToTimeZonesMapper _instance =
      PhoneNumberToTimeZonesMapper(TimezoneMetadataMap.timezones);

  // This is defined by ICU as the unknown time zone.
  static final String _unknownTimezone = "Etc/Unknown";

  // A list with the ICU unknown time zone as single element.
  @visibleForTesting
  static final List<String> unknownTimeZoneList = [_unknownTimezone];

  late PrefixTimeZonesMap _prefixTimeZonesMap;

  @internal
  PhoneNumberToTimeZonesMapper(Map<int, String> timezones) {
    _prefixTimeZonesMap = PrefixTimeZonesMap(timezones.entries.toList());
  }

  /// Returns a list of time zones to which a phone number belongs.
  ///
  /// <p>
  /// This method assumes the validity of the number passed in has already been
  /// checked, and that
  /// the number is geo-localizable. We consider fixed-line and mobile numbers
  /// possible candidates
  /// for geo-localization.
  ///
  /// [number] a valid phone number for which we want to get the time zones to
  /// which it belongs.
  /// returns a list of the corresponding time zones or a single element list with
  /// the default unknown time zone if no other time zone was found or if the number
  /// was invalid
  List<String> getTimeZonesForGeographicalNumber(PhoneNumber number) {
    return _getTimeZonesForGeocodableNumber(number);
  }

  /// As per [getTimeZonesForGeographicalNumber(PhoneNumber)] but explicitly
  /// checks the validity of the number passed in.
  ///
  /// [number] the phone number for which we want to get the time zones to
  /// which it belongs.
  /// returns a list of the corresponding time zones or a single element list with
  /// the default unknown time zone if no other time zone was found or if the number
  /// was invalid
  List<String> getTimeZonesForNumber(PhoneNumber number) {
    PhoneNumberUtil util = PhoneNumberUtil.instance;
    PhoneNumberType numberType = util.getNumberType(number);
    if (numberType == PhoneNumberType.unknown) {
      return unknownTimeZoneList;
    } else if (!util.isNumberGeographical(
        phoneNumberType: numberType, countryCallingCode: number.countryCode)) {
      return _getCountryLevelTimeZonesforNumber(number);
    }

    return getTimeZonesForGeographicalNumber(number);
  }

  /// Returns a String with the ICU unknown time zone.
  static String get unknownTimeZone {
    return _unknownTimezone;
  }

  /// Returns a list of time zones to which a geocodable phone number belongs.
  ///
  /// [number] the phone number for which we want to get the time zones to
  /// which it belongs.
  /// returns the list of corresponding time zones or a single element list with
  /// the default unknown time zone if no other time zone was found or if the number
  /// was invalid
  List<String> _getTimeZonesForGeocodableNumber(PhoneNumber number) {
    List<String> timezones =
        _prefixTimeZonesMap.lookupTimeZonesForNumber(number);
    return timezones.isEmpty ? unknownTimeZoneList : timezones;
  }

  /// Returns the list of time zones corresponding to the country calling code of [number].
  ///
  /// [number] the phone number to look up
  /// returns the list of corresponding time zones or a single element list with
  /// the default unknown time zone if no other time zone was found
  List<String> _getCountryLevelTimeZonesforNumber(PhoneNumber number) {
    List<String> timezones =
        _prefixTimeZonesMap.lookupCountryLevelTimeZonesForNumber(number);
    return timezones.isEmpty ? unknownTimeZoneList : timezones;
  }
}
