/// Based on the original Java code .../phonenumbers/PhoneNumberToCarrierMapperTest.java
///
/// Copyright (C) 2013 The Libphonenumber Authors
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

import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:test/test.dart';

import 'generated/metadata/carrier_metadata_map.dart';

// Set up some test numbers to re-use.
final PhoneNumber _aoMobile1 = PhoneNumber()
  ..countryCode = 244
  ..nationalNumber = Int64(917654321);

final PhoneNumber _aoMobile2 = PhoneNumber()
  ..countryCode = 244
  ..nationalNumber = Int64(927654321);

final PhoneNumber _aoFixed1 = PhoneNumber()
  ..countryCode = 244
  ..nationalNumber = Int64(22254321);

final PhoneNumber _aoFixed2 = PhoneNumber()
  ..countryCode = 244
  ..nationalNumber = Int64(26254321);

final PhoneNumber _aoInvalidNumber = PhoneNumber()
  ..countryCode = 244
  ..nationalNumber = Int64(101234);

final PhoneNumber _ukMobile1 = PhoneNumber()
  ..countryCode = 44
  ..nationalNumber = Int64(7387654321);

final PhoneNumber _ukMobile2 = PhoneNumber()
  ..countryCode = 44
  ..nationalNumber = Int64(7487654321);

final PhoneNumber _ukFixed1 = PhoneNumber()
  ..countryCode = 44
  ..nationalNumber = Int64(1123456789);

final PhoneNumber _ukFixed2 = PhoneNumber()
  ..countryCode = 44
  ..nationalNumber = Int64(2987654321);

final PhoneNumber _ukInvalidNumber = PhoneNumber()
  ..countryCode = 44
  ..nationalNumber = Int64(7301234);

final PhoneNumber _ukPager = PhoneNumber()
  ..countryCode = 44
  ..nationalNumber = Int64(7601234567);

final PhoneNumber _usFixedOrMobile = PhoneNumber()
  ..countryCode = 1
  ..nationalNumber = Int64(6502123456);

final PhoneNumber _numberWithInvalidCountryCode = PhoneNumber()
  ..countryCode = 999
  ..nationalNumber = Int64(2423651234);

final PhoneNumber _internationalTollFree = PhoneNumber()
  ..countryCode = 800
  ..nationalNumber = Int64(12345678);

void main() {
  final PhoneNumberToCarrierMapper carrierMapper = PhoneNumberToCarrierMapper(
    CarrierMetadataMap.config,
    CarrierMetadataMap.carriers,
  );

  group('PhoneNumberToCarrierMapperTest', () {
    test('testGetNameForMobilePortableRegion', () {
      expect(carrierMapper.getNameForNumber(_ukMobile1, Locale.english),
          "British carrier");
      expect(
          carrierMapper.getNameForNumber(
              _ukMobile1, Locale(language: "sv", country: "SE")),
          "Brittisk operat\u00F6r");
      expect(carrierMapper.getNameForNumber(_ukMobile1, Locale.french),
          "British carrier");
      // Returns an empty string because the UK implements mobile number portability.
      expect(carrierMapper.getSafeDisplayName(_ukMobile1, Locale.english), "");
    });

    test('testGetNameForNonMobilePortableRegion', () {
      expect(carrierMapper.getNameForNumber(_aoMobile1, Locale.english),
          "Angolan carrier");
      expect(carrierMapper.getSafeDisplayName(_aoMobile1, Locale.english),
          "Angolan carrier");
    });

    test('testGetNameForFixedLineNumber', () {
      expect(carrierMapper.getNameForNumber(_aoFixed1, Locale.english), "");
      expect(carrierMapper.getNameForNumber(_ukFixed1, Locale.english), "");
      // If the carrier information is present in the files and the method that assumes a valid
      // number is used, a carrier is returned.
      expect(carrierMapper.getNameForValidNumber(_aoFixed2, Locale.english),
          "Angolan fixed line carrier");
      expect(
          carrierMapper.getNameForValidNumber(_ukFixed2, Locale.english), "");
    });

    test('testGetNameForFixedOrMobileNumber', () {
      expect(carrierMapper.getNameForNumber(_usFixedOrMobile, Locale.english),
          "US carrier");
    });

    test('testGetNameForPagerNumber', () {
      expect(carrierMapper.getNameForNumber(_ukPager, Locale.english),
          "British pager");
    });

    test('testGetNameForNumberWithNoDataFile', () {
      expect(
          carrierMapper.getNameForNumber(
              _numberWithInvalidCountryCode, Locale.english),
          "");
      expect(
          carrierMapper.getNameForNumber(
              _internationalTollFree, Locale.english),
          "");
      expect(
          carrierMapper.getNameForValidNumber(
              _numberWithInvalidCountryCode, Locale.english),
          "");
      expect(
          carrierMapper.getNameForValidNumber(
              _internationalTollFree, Locale.english),
          "");
    });

    test('testGetNameForNumberWithMissingPrefix', () {
      expect(carrierMapper.getNameForNumber(_ukMobile2, Locale.english), "");
      expect(carrierMapper.getNameForNumber(_aoMobile2, Locale.english), "");
    });

    test('testGetNameForInvalidNumber', () {
      expect(
          carrierMapper.getNameForNumber(_ukInvalidNumber, Locale.english), "");
      expect(
          carrierMapper.getNameForNumber(_aoInvalidNumber, Locale.english), "");
    });
  });
}
