/// Based on the original Java code: .../phonenumbers/geocoding/PhoneNumberOfflineGeocoderTest.java
///
/// [license]
/// Copyright (C) 2011 The Libphonenumber Authors
///
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

import 'generated/metadata/geocoding_metadata_map.dart';

void main() {
  final geocoder = PhoneNumberOfflineGeocoder(GeocodingMetadataMap.config, GeocodingMetadataMap.locations);

  group('PhoneNumberOfflineGeocoderTest', () {
    // Set up some test numbers to re-use.
    final PhoneNumber koNumber1 = PhoneNumber()
      ..countryCode = 82
      ..nationalNumber = Int64(22123456);

    final PhoneNumber koNumber2 = PhoneNumber()
      ..countryCode = 82
      ..nationalNumber = Int64(322123456);

    final PhoneNumber koNumber3 = PhoneNumber()
      ..countryCode = 82
      ..nationalNumber = Int64(6421234567);

    final PhoneNumber koInvalidNumber = PhoneNumber()
      ..countryCode = 82
      ..nationalNumber = Int64(1234);

    final PhoneNumber koMobile = PhoneNumber()
      ..countryCode = 82
      ..nationalNumber = Int64(101234567);

    final PhoneNumber usNumber1 = PhoneNumber()
      ..countryCode = 1
      ..nationalNumber = Int64(6502530000);

    final PhoneNumber usNumber2 = PhoneNumber()
      ..countryCode = 1
      ..nationalNumber = Int64(6509600000);

    final PhoneNumber usNumber3 = PhoneNumber()
      ..countryCode = 1
      ..nationalNumber = Int64(2128120000);

    final PhoneNumber usNumber4 = PhoneNumber()
      ..countryCode = 1
      ..nationalNumber = Int64(6174240000);

    final PhoneNumber usInvalidNumber = PhoneNumber()
      ..countryCode = 1
      ..nationalNumber = Int64(123456789);

    final PhoneNumber nanpaTollFree = PhoneNumber()
      ..countryCode = 1
      ..nationalNumber = Int64(8002431234);

    final PhoneNumber bsNumber1 = PhoneNumber()
      ..countryCode = 1
      ..nationalNumber = Int64(2423651234);

    final PhoneNumber auNumber = PhoneNumber()
      ..countryCode = 61
      ..nationalNumber = Int64(236618300);

    final PhoneNumber arMobileNumber = PhoneNumber()
      ..countryCode = 54
      ..nationalNumber = Int64(92214000000);

    final PhoneNumber numberWithInvalidCountryCode = PhoneNumber()
      ..countryCode = 999
      ..nationalNumber = Int64(2423651234);

    final PhoneNumber internationalTollFree = PhoneNumber()
      ..countryCode = 800
      ..nationalNumber = Int64(12345678);

    test('testGetDescriptionForNumberWithNoDataFile', () {
      // No data file containing mappings for US numbers is available in Chinese for the unittests. As
      // a result, the country name of United States in simplified Chinese is returned.
      expect(geocoder.getDescriptionForNumber(usNumber1, Locale.simplifiedChinese), '\u7F8E\u56FD');
      expect(geocoder.getDescriptionForNumber(bsNumber1, Locale(language: 'en', country: 'US')), 'Bahamas');

      expect(geocoder.getDescriptionForNumber(auNumber, Locale(language: 'en', country: 'US')), 'Australia');
      expect(geocoder.getDescriptionForNumber(numberWithInvalidCountryCode, Locale(language: 'en', country: 'US')), '');
      expect(geocoder.getDescriptionForNumber(internationalTollFree, Locale(language: 'en', country: 'US')), '');
    });

    test('testGetDescriptionForNumberWithMissingPrefix', () {
      // Test that the name of the country is returned when the number passed in is
      // valid but not covered by the geocoding data file.
      expect(geocoder.getDescriptionForNumber(usNumber4, Locale(language: 'en', country: 'US')), 'United States');
    });

    test('testGetDescriptionForNumberBelongingToMultipleCountriesIsEmpty', () {
      // Test that nothing is returned when the number passed in is valid but not
      // covered by the geocoding data file and belongs to multiple countries
      expect(geocoder.getDescriptionForNumber(nanpaTollFree, Locale(language: 'en', country: 'US')), '');
    });

    test('testGetDescriptionForNumber_en_US', () {
      expect(geocoder.getDescriptionForNumber(usNumber1, Locale(language: 'en', country: 'US')), 'CA');
      expect(geocoder.getDescriptionForNumber(usNumber2, Locale(language: 'en', country: 'US')), 'Mountain View, CA');
      expect(geocoder.getDescriptionForNumber(usNumber3, Locale(language: 'en', country: 'US')), 'New York, NY');
    });

    test('testGetDescriptionForKoreanNumber', () {
      expect(geocoder.getDescriptionForNumber(koNumber1, Locale.english), 'Seoul');
      expect(geocoder.getDescriptionForNumber(koNumber2, Locale.english), 'Incheon');
      expect(geocoder.getDescriptionForNumber(koNumber3, Locale.english), 'Jeju');
      expect(geocoder.getDescriptionForNumber(koNumber1, Locale.korean), '\uC11C\uC6B8');
      expect(geocoder.getDescriptionForNumber(koNumber2, Locale.korean), '\uC778\uCC9C');
    });

    test('testGetDescriptionForArgentinianMobileNumber', () {
      expect(geocoder.getDescriptionForNumber(arMobileNumber, Locale.english), 'La Plata');
    });

    test('testGetDescriptionForFallBack', () {
      // No fallback, as the location name for the given phone number is available in
      // the requested language.
      expect(geocoder.getDescriptionForNumber(usNumber1, Locale.german), 'Kalifornien');
      // German falls back to English.
      expect(geocoder.getDescriptionForNumber(usNumber3, Locale.german), 'New York, NY');
      // Italian falls back to English.
      expect(geocoder.getDescriptionForNumber(usNumber1, Locale.italian), 'CA');
      // Korean doesn't fall back to English.
      expect(geocoder.getDescriptionForNumber(koNumber3, Locale.korean), '\uB300\uD55C\uBBFC\uAD6D');
    });

    test('testGetDescriptionForNumberWithUserRegion', () {
      // User in Italy, American number. We should just show United States, in
      // Spanish, and not more detailed information.
      expect(
        geocoder.getDescriptionForNumber(usNumber1, Locale(language: 'es', country: 'ES'), 'IT'),
        'Estados Unidos',
      );
      // Unknown region - should just show country name.
      expect(
        geocoder.getDescriptionForNumber(usNumber1, Locale(language: 'es', country: 'ES'), 'ZZ'),
        'Estados Unidos',
      );
      // User in the States, language German, should show detailed data.
      expect(
        geocoder.getDescriptionForNumber(usNumber1, Locale.german, 'US'),
        'Kalifornien',
      );
      // User in the States, language French, no data for French, so we fallback to
      // English detailed data.
      expect(geocoder.getDescriptionForNumber(usNumber1, Locale.french, 'US'), 'CA');
      // Invalid number - return an empty string.
      expect(geocoder.getDescriptionForNumber(usInvalidNumber, Locale.english, 'US'), '');
    });

    test('testGetDescriptionForInvalidNumber', () {
      expect(geocoder.getDescriptionForNumber(koInvalidNumber, Locale.english), '');
      expect(geocoder.getDescriptionForNumber(usInvalidNumber, Locale.english), '');
    });

    test('testGetDescriptionForNonGeographicalNumberWithGeocodingPrefix', () {
      // We have a geocoding prefix, but we shouldn't use it since this is not
      // geographical.
      expect(geocoder.getDescriptionForNumber(koMobile, Locale.english), 'South Korea');
    });
  });
}
