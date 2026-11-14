// Based on the original Java code .../phonenumbers/PhoneNumberToCarrierMapper.java
//
// Copyright (C) 2013 The Libphonenumber Authors
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

import 'enums/phone_number_type.dart';
import 'generated/classes/phone_number/phonenumber.pb.dart';
import 'generated/metadata/carrier_metadata_map.dart';
import 'locale.dart';
import 'phone_number_util.dart';
import 'prefix_file_reader.dart';
import 'carrier_loader.dart';

/// A phone prefix mapper which provides carrier information related to a phone number.
class PhoneNumberToCarrierMapper {
  static PhoneNumberToCarrierMapper get instance => _instance;
  static final PhoneNumberToCarrierMapper _instance =
      PhoneNumberToCarrierMapper(
    CarrierMetadataMap.config,
    CarrierMetadataMap.carriers,
  );

  final PrefixFileReader _prefixFileReader;
  final CarrierLoader _loader;
  final PhoneNumberUtil _phoneUtil = PhoneNumberUtil.instance;

  @internal
  PhoneNumberToCarrierMapper(
    Map<int, List<String>> configData,
    Map<String, Map<int, String>> carriers,
  )   : _prefixFileReader = PrefixFileReader(configData, carriers),
        _loader = CarrierLoader(configData, carriers);

  /// Returns a carrier name for the given phone number, in the language provided. The carrier name
  /// is the one the number was originally allocated to, however if the country supports mobile
  /// number portability the number might not belong to the returned carrier anymore. If no mapping
  /// is found an empty string is returned.
  ///
  /// <p>This method assumes the validity of the number passed in has already been checked, and that
  /// the number is suitable for carrier lookup. We consider mobile and pager numbers possible
  /// candidates for carrier lookup.
  ///
  /// param [number] a valid phone number for which we want to get a carrier name
  /// param [languageCode] the language code in which the name should be written
  /// returns a carrier name for the given phone number
  Future<String> getNameForValidNumber(
      PhoneNumber number, Locale languageCode) async {
    // Ensure data is loaded
    int countryCallingCode = number.countryCode;
    // NANPA check (same as geocoding) - though carrier data might be less split?
    // Checking file list: 1242_en.dart, 1340_en.dart exists. So NANPA is split.
    int phonePrefix = (countryCallingCode != 1)
        ? countryCallingCode
        : (1000 + (number.nationalNumber.toInt() ~/ 10000000));

    await _loader.ensureLoaded(
        phonePrefix, languageCode.language, "", languageCode.country);

    String langStr = languageCode.language;
    String scriptStr = ""; // No script is specified
    String regionStr = languageCode.country;
    return _prefixFileReader.getDescriptionForNumber(
        number, langStr, scriptStr, regionStr);
  }

  /// Gets the name of the carrier for the given phone number, in the language provided. As per
  /// [getNameForValidNumber(PhoneNumber, Locale)] but explicitly checks the validity of
  /// the number passed in.
  ///
  /// [number]  the phone number for which we want to get a carrier name
  /// [languageCode]  the language code in which the name should be written
  /// returns a carrier name for the given phone number, or empty string
  /// if the number passed in is invalid
  Future<String> getNameForNumber(
      PhoneNumber number, Locale languageCode) async {
    PhoneNumberType numberType = _phoneUtil.getNumberType(number);
    if (isMobile(numberType)) {
      return await getNameForValidNumber(number, languageCode);
    }
    return "";
  }

  /// Gets the name of the carrier for the given phone number only when it is 'safe' to display to
  /// users. A carrier name is considered safe if the number is valid and for a region that doesn't
  /// support
  /// <a href="http://en.wikipedia.org/wiki/Mobile_number_portability">mobile number portability</a>.
  ///
  /// [number] the phone number for which we want to get a carrier name
  /// [languageCode]  the language code in which the name should be written
  /// returns a carrier name that is safe to display to users, or the empty string
  Future<String> getSafeDisplayName(
      PhoneNumber number, Locale languageCode) async {
    if (_phoneUtil.isMobileNumberPortableRegion(
        _phoneUtil.getRegionCodeForNumber(number))) {
      return "";
    }
    return await getNameForNumber(number, languageCode);
  }

  /// Checks if the supplied number type supports carrier lookup.
  bool isMobile(PhoneNumberType numberType) {
    return (numberType == PhoneNumberType.mobile ||
        numberType == PhoneNumberType.fixedLineOrMobile ||
        numberType == PhoneNumberType.pager);
  }
}
