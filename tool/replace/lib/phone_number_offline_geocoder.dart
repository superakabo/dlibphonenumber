// Based on the original Java code: .../phonenumbers/geocoding/PhoneNumberOfflineGeocoder.java
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

import 'package:meta/meta.dart';

import 'dlibphonenumber.dart';
import 'generated/metadata/geocoding_metadata_map.dart';
import 'prefix_file_reader.dart';

/// An offline geocoder which provides geographical information related to a phone number.
import 'geocoding_loader.dart';

/// An offline geocoder which provides geographical information related to a phone number.
class PhoneNumberOfflineGeocoder {
  static PhoneNumberOfflineGeocoder get instance => _instance;
  static final PhoneNumberOfflineGeocoder _instance =
      PhoneNumberOfflineGeocoder(
          GeocodingMetadataMap.config, GeocodingMetadataMap.locations);

  final GeocodingLoader _loader;
  final Map<int, List<String>> _configData;
  final Map<String, Map<int, String>> _locations;

  @internal
  PhoneNumberOfflineGeocoder(
    this._configData,
    this._locations,
  )   : _prefixFileReader = PrefixFileReader(_configData, _locations),
        _loader = GeocodingLoader(_configData, _locations);

  final PhoneNumberUtil _phoneUtil = PhoneNumberUtil.instance;

  final PrefixFileReader _prefixFileReader;

  /// Returns the customary display name in the given language for the given territory the phone
  /// number is from. If it could be from many territories, nothing is returned.
  Future<String> _getCountryNameForNumber(
      PhoneNumber number, Locale language) async {
    List<String> regionCodes =
        _phoneUtil.getRegionCodesForCountryCode(number.countryCode);
    if (regionCodes.length == 1) {
      return _getRegionDisplayName(regionCodes[0], language);
    } else {
      String regionWhereNumberIsValid = "ZZ";
      for (String regionCode in regionCodes) {
        if (_phoneUtil.isValidNumberForRegion(number, regionCode)) {
          // If the number has already been found valid for one region, then we don't know which
          // region it belongs to so we return nothing.
          if (regionWhereNumberIsValid != "ZZ") {
            return "";
          }
          regionWhereNumberIsValid = regionCode;
        }
      }
      return _getRegionDisplayName(regionWhereNumberIsValid, language);
    }
  }

  /// Returns the customary display name in the given language for the given region.
  String _getRegionDisplayName(String? regionCode, Locale language) {
    return (regionCode == null ||
            regionCode == "ZZ" ||
            regionCode == PhoneNumberUtil.regionCodeForNonGeoEntity)
        ? ""
        : Locale(language: "", country: regionCode).getDisplayCountry(language);
  }

  /// Returns a text description for the given phone number, in the language provided. The
  /// description might consist of the name of the country where the phone number is from, or the
  /// name of the geographical area the phone number is from if more detailed information is
  /// available.
  Future<String> getDescriptionForValidNumber(
      PhoneNumber number, Locale languageCode,
      [String? userRegion]) async {
    int countryCallingCode = number.countryCode;
    // As the NANPA data is split into multiple files covering 3-digit areas, use a
    // phone number prefix of 4 digits for NANPA instead, e.g. 1650.
    int phonePrefix = (countryCallingCode != 1)
        ? countryCallingCode
        : (1000 + (number.nationalNumber.toInt() ~/ 10000000));

    // Ensure data is loaded
    await _loader.ensureLoaded(
        phonePrefix, languageCode.language, "", languageCode.country);

    if (userRegion == null) {
      String langStr = languageCode.language;
      String scriptStr = ""; // No script is specified
      String regionStr = languageCode.country;

      String? areaDescription;
      String mobileToken =
          PhoneNumberUtil.getCountryMobileToken(number.countryCode);
      String nationalNumber = _phoneUtil.getNationalSignificantNumber(number);

      if (mobileToken != "" && nationalNumber.startsWith(mobileToken)) {
        // In some countries, eg. Argentina, mobile numbers have a mobile token before the national
        // destination code, this should be removed before geocoding.
        nationalNumber = nationalNumber.substring(mobileToken.length);
        String region =
            _phoneUtil.getRegionCodeForCountryCode(number.countryCode);
        PhoneNumber copiedNumber;
        try {
          copiedNumber = _phoneUtil.parse(nationalNumber, region);
        } on NumberParseException catch (_) {
          // If this happens, just reuse what we had.
          copiedNumber = number;
        }
        areaDescription = _prefixFileReader.getDescriptionForNumber(
            copiedNumber, langStr, scriptStr, regionStr);
      } else {
        areaDescription = _prefixFileReader.getDescriptionForNumber(
            number, langStr, scriptStr, regionStr);
      }

      return (areaDescription.isNotEmpty)
          ? areaDescription
          : await _getCountryNameForNumber(number, languageCode);
    } //
    else {
      // If the user region matches the number's region, then we just show the lower-level
      // description, if one exists - if no description exists, we will show the region(country) name
      // for the number.
      String? regionCode = _phoneUtil.getRegionCodeForNumber(number);
      if (userRegion == regionCode) {
        return await getDescriptionForValidNumber(number, languageCode);
      }
      // Otherwise, we just show the region(country) name for now.
      return _getRegionDisplayName(regionCode, languageCode);
      // TODO: Concatenate the lower-level and country-name information in an appropriate
      // way for each language.
    }
  }

  /// As per [getDescriptionForValidNumber(PhoneNumber, Locale, String)] but
  /// explicitly checks the validity of the number passed in.
  Future<String> getDescriptionForNumber(
      PhoneNumber number, Locale languageCode,
      [String? userRegion]) async {
    if (userRegion == null) {
      PhoneNumberType numberType = _phoneUtil.getNumberType(number);
      if (numberType == PhoneNumberType.unknown) {
        return "";
      } else if (!_phoneUtil.isNumberGeographical(
          phoneNumberType: numberType,
          countryCallingCode: number.countryCode)) {
        return await _getCountryNameForNumber(number, languageCode);
      }
      return await getDescriptionForValidNumber(number, languageCode);
    } else {
      PhoneNumberType numberType = _phoneUtil.getNumberType(number);
      if (numberType == PhoneNumberType.unknown) {
        return "";
      } else if (!_phoneUtil.isNumberGeographical(
          phoneNumberType: numberType,
          countryCallingCode: number.countryCode)) {
        return await _getCountryNameForNumber(number, languageCode);
      }
      return await getDescriptionForValidNumber(
          number, languageCode, userRegion);
    }
  }
}
