/// Based on the original Java code: .../phonenumbers/PhoneNumberUtilTest.java
///
/// [license]
/// Copyright (C) 2010 The Libphonenumber Authors.
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
library;

import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:test/test.dart';

import 'generated/metadata/phone_number_metadata_map.dart';

/// @fileoverview  Unit tests for the PhoneNumberUtil.
///
/// Note that these tests use the metadata contained in metadatafortesting.js,
/// not the normal metadata files, so should not be used for regression test
/// purposes - these tests are illustrative only and test functionality.
final phoneUtil = PhoneNumberUtil(const PhoneNumberMetadataMap());

/// Set up some test numbers to re-use.
/// TODO: Rewrite this as static functions that return new numbers each time to
/// avoid any risk of accidental changes to mutable static state affecting many
/// tests.
final _alphaNumericNumber = PhoneNumber()
  ..countryCode = 1
  ..nationalNumber = Int64(80074935247);

final _aeUan = PhoneNumber()
  ..countryCode = 971
  ..nationalNumber = Int64(600123456);

final _arMobile = PhoneNumber()
  ..countryCode = 54
  ..nationalNumber = Int64(91187654321);

final _arNumber = PhoneNumber()
  ..countryCode = 54
  ..nationalNumber = Int64(1187654321);

final _auNumber = PhoneNumber()
  ..countryCode = 61
  ..nationalNumber = Int64(236618300);

final _bsMobile = PhoneNumber()
  ..countryCode = 1
  ..nationalNumber = Int64(2423570000);

final _bsNumber = PhoneNumber()
  ..countryCode = 1
  ..nationalNumber = Int64(2423651234);

final _coFixedLine = PhoneNumber()
  ..countryCode = 57
  ..nationalNumber = Int64(6012345678);

// Note that this is the same as the example number for DE in the metadata.
final _deNumber = PhoneNumber()
  ..countryCode = 49
  ..nationalNumber = Int64(30123456);

final _deShortNumber = PhoneNumber()
  ..countryCode = 49
  ..nationalNumber = Int64(1234);

final _gbMobile = PhoneNumber()
  ..countryCode = 44
  ..nationalNumber = Int64(7912345678);

final _gbNumber = PhoneNumber()
  ..countryCode = 44
  ..nationalNumber = Int64(2070313000);

final _itMobile = PhoneNumber()
  ..countryCode = 39
  ..nationalNumber = Int64(345678901);

final _itNumber = PhoneNumber()
  ..countryCode = 39
  ..nationalNumber = Int64(236618300)
  ..italianLeadingZero = true;

final _jpStarNumber = PhoneNumber()
  ..countryCode = 81
  ..nationalNumber = Int64(2345);

// Numbers to test the formatting rules from Mexico.
final _mxMobile1 = PhoneNumber()
  ..countryCode = 52
  ..nationalNumber = Int64(12345678900);

final _mxMobile2 = PhoneNumber()
  ..countryCode = 52
  ..nationalNumber = Int64(15512345678);

final _mxNumber1 = PhoneNumber()
  ..countryCode = 52
  ..nationalNumber = Int64(3312345678);

final _mxNumber2 = PhoneNumber()
  ..countryCode = 52
  ..nationalNumber = Int64(8211234567);

final _nzNumber = PhoneNumber()
  ..countryCode = 64
  ..nationalNumber = Int64(33316005);

final _sgNumber = PhoneNumber()
  ..countryCode = 65
  ..nationalNumber = Int64(65218000);

final _usLongNumber = PhoneNumber()
  ..countryCode = 1
  ..nationalNumber = Int64(65025300001);

final _usNumber = PhoneNumber()
  ..countryCode = 1
  ..nationalNumber = Int64(6502530000);

final _usPremium = PhoneNumber()
  ..countryCode = 1
  ..nationalNumber = Int64(9002530000);

// Too short, but still possible US numbers.
final _usLocalNumber = PhoneNumber()
  ..countryCode = 1
  ..nationalNumber = Int64(2530000);

final _usShortByOneNumber = PhoneNumber()
  ..countryCode = 1
  ..nationalNumber = Int64(650253000);

final _usTollfree = PhoneNumber()
  ..countryCode = 1
  ..nationalNumber = Int64(8002530000);

final _usSpoof = PhoneNumber()
  ..countryCode = 1
  ..nationalNumber = Int64(0);

final _usSpoofWithRawInput = PhoneNumber()
  ..countryCode = 1
  ..nationalNumber = Int64(0)
  ..rawInput = '000-000-0000';

final _uzFixedLine = PhoneNumber()
  ..countryCode = 998
  ..nationalNumber = Int64(612201234);

final _uzMobile = PhoneNumber()
  ..countryCode = 998
  ..nationalNumber = Int64(950123456);

final _internationalTollFree = PhoneNumber()
  ..countryCode = 800
  ..nationalNumber = Int64(12345678);

// We set this to be the same length as numbers for the other non-geographical
// country prefix that we have in our test metadata. However, this is not
// considered valid because they differ in their country calling code.
final _internationalTollFreeTooLong = PhoneNumber()
  ..countryCode = 800
  ..nationalNumber = Int64(123456789);

final _universalPremiumRate = PhoneNumber()
  ..countryCode = 979
  ..nationalNumber = Int64(123456789);

final _unknownCountryCodeNoRawInput = PhoneNumber()
  ..countryCode = 2
  ..nationalNumber = Int64(12345);

void main() {
  group('PhoneNumberUtilTest', () {
    test('testGetSupportedRegions', () {
      expect(phoneUtil.supportedRegions.isNotEmpty, true);
      expect(phoneUtil.supportedRegions.contains('US'), true);
      expect(phoneUtil.supportedRegions.contains('001'), false);
      expect(phoneUtil.supportedRegions.contains('800'), false);
    });

    test('testGetSupportedGlobalNetworkCallingCodes', () {
      expect(phoneUtil.supportedGlobalNetworkCallingCodes.isNotEmpty, true);
      expect(phoneUtil.supportedGlobalNetworkCallingCodes.contains(1), false);
      expect(phoneUtil.supportedGlobalNetworkCallingCodes.contains(800), true);
      for (final countryCallingCode
          in phoneUtil.supportedGlobalNetworkCallingCodes) {
        expect(
            phoneUtil.getRegionCodeForCountryCode(countryCallingCode), '001');
      }
    });

    test('testGetSupportedCallingCodes', () {
      expect(phoneUtil.getSupportedCallingCodes().isNotEmpty, true);
      phoneUtil.getSupportedCallingCodes().forEach((callingCode) {
        expect(callingCode > 0, true);
        expect(
            phoneUtil.getRegionCodeForCountryCode(callingCode) != 'ZZ', true);
      });
      // There should be more than just the global network calling codes in this
      // set.
      expect(
          phoneUtil.getSupportedCallingCodes().length >
              phoneUtil.supportedGlobalNetworkCallingCodes.length,
          true);
      // But they should be included. Testing one of them.
      expect(phoneUtil.supportedGlobalNetworkCallingCodes.contains(979), true);
    });

    test('testGetInstanceLoadBadMetadata', () {
      expect(
          phoneUtil.getMetadataForRegion(regionCode: "No Such Region"), isNull);
      expect(phoneUtil.getMetadataForNonGeographicalRegion(-1), isNull);
    });

    test('testGetSupportedTypesForRegion', () {
      List<PhoneNumberType> types = phoneUtil.getSupportedTypesForRegion('BR');
      expect(types.contains(PhoneNumberType.fixedLine), true);
      // Our test data has no mobile numbers for Brazil.
      expect(types.contains(PhoneNumberType.mobile), false);
      // UNKNOWN should never be returned.
      expect(types.contains(PhoneNumberType.unknown), false);

      // In the US, many numbers are classified as FIXED_LINE_OR_MOBILE; but we
      // don't want to expose this as a supported type, instead we say FIXED_LINE
      // and MOBILE are both present.
      types = phoneUtil.getSupportedTypesForRegion('US');
      expect(types.contains(PhoneNumberType.fixedLine), true);
      expect(types.contains(PhoneNumberType.mobile), true);
      expect(types.contains(PhoneNumberType.fixedLineOrMobile), false);

      types = phoneUtil.getSupportedTypesForRegion('ZZ');
      expect(types.isEmpty, true);
    });

    test('testGetSupportedTypesForNonGeoEntity', () {
      List<PhoneNumberType> types =
          phoneUtil.getSupportedTypesForNonGeoEntity(999);
      // No data exists for 999 at all, no types should be returned.
      expect(types.isEmpty, true);

      types = phoneUtil.getSupportedTypesForNonGeoEntity(979);
      expect(types.contains(PhoneNumberType.premiumRate), true);
      // Our test data has no mobile numbers for Brazil.
      expect(types.contains(PhoneNumberType.mobile), false);
      // UNKNOWN should never be returned.
      expect(types.contains(PhoneNumberType.unknown), false);
    });

    test('testGetInstanceLoadUSMetadata', () {
      PhoneMetadata metadata =
          phoneUtil.getMetadataForRegion(regionCode: 'US')!;
      expect(metadata.id, 'US');
      expect(metadata.countryCode, 1);
      expect(metadata.internationalPrefix, '011');
      expect(metadata.hasNationalPrefix(), true);
      expect(metadata.numberFormat.length, 2);
      expect(metadata.numberFormat[1].pattern, '(\\d{3})(\\d{3})(\\d{4})');
      expect(metadata.numberFormat[1].format, r'$1 $2 $3');
      expect(metadata.generalDesc.nationalNumberPattern,
          '[13-689]\\d{9}|2[0-35-9]\\d{8}');
      expect(metadata.fixedLine.nationalNumberPattern,
          '[13-689]\\d{9}|2[0-35-9]\\d{8}');
      expect(metadata.premiumRate.nationalNumberPattern, '900\\d{7}');
      expect(metadata.sharedCost.hasNationalNumberPattern(), false);
    });

    test('testGetInstanceLoadDEMetadata', () {
      PhoneMetadata metadata =
          phoneUtil.getMetadataForRegion(regionCode: 'DE')!;
      expect(metadata.id, 'DE');
      expect(metadata.countryCode, 49);
      expect(metadata.internationalPrefix, '00');
      expect(metadata.nationalPrefix, '0');
      expect(metadata.numberFormat.length, 6);
      expect(metadata.numberFormat[5].leadingDigitsPattern.length, 1);
      expect(metadata.numberFormat[5].leadingDigitsPattern[0], '900');
      expect(metadata.numberFormat[5].pattern, '(\\d{3})(\\d{3,4})(\\d{4})');
      expect(metadata.numberFormat[5].format, r'$1 $2 $3');
      expect(metadata.fixedLine.nationalNumberPattern,
          '(?:[24-6]\\d{2}|3[03-9]\\d|[789](?:0[2-9]|[1-9]\\d))\\d{1,8}');
      expect(metadata.fixedLine.exampleNumber, '30123456');
      expect(metadata.premiumRate.nationalNumberPattern,
          '900([135]\\d{6}|9\\d{7})');
    });

    test('testGetInstanceLoadARMetadata', () {
      PhoneMetadata metadata =
          phoneUtil.getMetadataForRegion(regionCode: 'AR')!;
      expect(metadata.id, 'AR');
      expect(metadata.countryCode, 54);
      expect(metadata.internationalPrefix, '00');
      expect(metadata.nationalPrefix, '0');
      expect(metadata.nationalPrefixForParsing, '0(?:(11|343|3715)15)?');
      expect(metadata.nationalPrefixTransformRule, r'9$1');
      expect(metadata.numberFormat[2].format, r'$2 15 $3-$4');
      expect(metadata.numberFormat[3].pattern, '(\\d)(\\d{4})(\\d{2})(\\d{4})');
      expect(metadata.intlNumberFormat[3].pattern,
          '(\\d)(\\d{4})(\\d{2})(\\d{4})');
      expect(metadata.intlNumberFormat[3].format, r'$1 $2 $3 $4');
    });

    test('testGetInstanceLoadInternationalTollFreeMetadata', () {
      PhoneMetadata metadata =
          phoneUtil.getMetadataForNonGeographicalRegion(800)!;
      expect(metadata.id, '001');
      expect(metadata.countryCode, 800);
      expect(metadata.numberFormat[0].format, r'$1 $2');
      expect(metadata.numberFormat[0].pattern, '(\\d{4})(\\d{4})');
      expect(metadata.generalDesc.possibleLengthLocalOnly.length, 0);
      expect(metadata.generalDesc.possibleLength.length, 1);
      expect(metadata.tollFree.exampleNumber, '12345678');
    });

    test('testIsNumberGeographical', () {
      // Bahamas, mobile phone number.
      expect(phoneUtil.isNumberGeographical(phoneNumber: _bsMobile), false);
      // Australian fixed line number.
      expect(phoneUtil.isNumberGeographical(phoneNumber: _auNumber), true);
      // International toll free number.
      expect(
          phoneUtil.isNumberGeographical(phoneNumber: _internationalTollFree),
          false);
      // We test that mobile phone numbers in relevant regions are indeed considered
      // geographical.
      // Argentina, mobile phone number.
      expect(phoneUtil.isNumberGeographical(phoneNumber: _arMobile), true);
      // Mexico, mobile phone number.
      expect(phoneUtil.isNumberGeographical(phoneNumber: _mxMobile1), true);
      // Mexico, another mobile phone number.
      expect(phoneUtil.isNumberGeographical(phoneNumber: _mxMobile2), true);
    });

    test('testGetLengthOfGeographicalAreaCode', () {
      // Google MTV, which has area code '650'.
      expect(phoneUtil.getLengthOfGeographicalAreaCode(_usNumber), 3);

      // A North America toll-free number, which has no area code.
      expect(phoneUtil.getLengthOfGeographicalAreaCode(_usTollfree), 0);

      // Google London, which has area code '20'.
      expect(phoneUtil.getLengthOfGeographicalAreaCode(_gbNumber), 2);

      // A UK mobile phone, which has no area code.
      expect(phoneUtil.getLengthOfGeographicalAreaCode(_gbMobile), 0);

      // Google Buenos Aires, which has area code '11'.
      expect(phoneUtil.getLengthOfGeographicalAreaCode(_arNumber), 2);

      // Google Sydney, which has area code '2'.
      expect(phoneUtil.getLengthOfGeographicalAreaCode(_auNumber), 1);

      // Italian numbers - there is no national prefix, but it still has an area
      // code.
      expect(phoneUtil.getLengthOfGeographicalAreaCode(_itNumber), 2);

      // Google Singapore. Singapore has no area code and no national prefix.
      expect(phoneUtil.getLengthOfGeographicalAreaCode(_sgNumber), 0);

      // An invalid US number (1 digit shorter), which has no area code.
      expect(phoneUtil.getLengthOfGeographicalAreaCode(_usShortByOneNumber), 0);

      // An international toll free number, which has no area code.
      expect(
          phoneUtil.getLengthOfGeographicalAreaCode(_internationalTollFree), 0);
    });

    test('testGetLengthOfNationalDestinationCode', () {
      // Google MTV, which has national destination code (NDC) '650'.
      expect(phoneUtil.getLengthOfNationalDestinationCode(_usNumber), 3);

      // A North America toll-free number, which has NDC '800'.
      expect(phoneUtil.getLengthOfNationalDestinationCode(_usTollfree), 3);

      // Google London, which has NDC '20'.
      expect(phoneUtil.getLengthOfNationalDestinationCode(_gbNumber), 2);

      // A UK mobile phone, which has NDC '7912'.
      expect(phoneUtil.getLengthOfNationalDestinationCode(_gbMobile), 4);

      // Google Buenos Aires, which has NDC '11'.
      expect(phoneUtil.getLengthOfNationalDestinationCode(_arNumber), 2);

      // An Argentinian mobile which has NDC '911'.
      expect(phoneUtil.getLengthOfNationalDestinationCode(_arMobile), 3);

      // Google Sydney, which has NDC '2'.
      expect(phoneUtil.getLengthOfNationalDestinationCode(_auNumber), 1);

      // Google Singapore, which has NDC '6521'.
      expect(phoneUtil.getLengthOfNationalDestinationCode(_sgNumber), 4);

      // An invalid US number (1 digit shorter), which has no NDC.
      expect(
          phoneUtil.getLengthOfNationalDestinationCode(_usShortByOneNumber), 0);

      // A number containing an invalid country calling code, which shouldn't have
      // any NDC.
      final number = PhoneNumber()
        ..countryCode = 123
        ..nationalNumber = Int64(6502530000);
      expect(phoneUtil.getLengthOfNationalDestinationCode(number), 0);

      // An international toll free number, which has NDC '1234'.
      expect(
          phoneUtil.getLengthOfNationalDestinationCode(_internationalTollFree),
          4);
    });

    test('testGetCountryMobileToken', () {
      expect(
          PhoneNumberUtil.getCountryMobileToken(
              phoneUtil.getCountryCodeForRegion('AR')),
          '9');
      // Country calling code for Sweden, which has no mobile token.
      expect(
          PhoneNumberUtil.getCountryMobileToken(
              phoneUtil.getCountryCodeForRegion('SE')),
          '');
    });

    test('testGetNationalSignificantNumber', () {
      expect(phoneUtil.getNationalSignificantNumber(_usNumber), '6502530000');

      // An Italian mobile number.
      expect(phoneUtil.getNationalSignificantNumber(_itMobile), '345678901');

      // An Italian fixed line number.
      expect(phoneUtil.getNationalSignificantNumber(_itNumber), '0236618300');

      expect(phoneUtil.getNationalSignificantNumber(_internationalTollFree),
          '12345678');

      // An empty number.
      final emptyNumber = PhoneNumber();
      expect(phoneUtil.getNationalSignificantNumber(emptyNumber), '');
    });

    test('testGetNationalSignificantNumber_ManyLeadingZeros', () {
      final number = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(650)
        ..italianLeadingZero = true
        ..numberOfLeadingZeros = 2;
      expect(phoneUtil.getNationalSignificantNumber(number), '00650');

      // Set a bad value; we shouldn't crash, we shouldn't output any leading zeros
      // at all.
      number.numberOfLeadingZeros = -3;
      expect(phoneUtil.getNationalSignificantNumber(number), '650');
    });

    test('testGetExampleNumber', () {
      expect(phoneUtil.getExampleNumber('DE'), _deNumber);
      expect(
          phoneUtil.getExampleNumberForType(
              regionCode: 'DE', type: PhoneNumberType.fixedLine),
          _deNumber);

      // Should return the same response if asked for FIXED_LINE_OR_MOBILE too.
      expect(
          phoneUtil.getExampleNumberForType(
              regionCode: 'DE', type: PhoneNumberType.fixedLineOrMobile),
          _deNumber);
      // We have data for the US, but no data for VOICEMAIL.
      expect(
          phoneUtil.getExampleNumberForType(
              regionCode: 'US', type: PhoneNumberType.voicemail),
          isNull);

      expect(
          phoneUtil.getExampleNumberForType(
              regionCode: 'US', type: PhoneNumberType.fixedLine),
          isNotNull);
      expect(
          phoneUtil.getExampleNumberForType(
              regionCode: 'US', type: PhoneNumberType.mobile),
          isNotNull);
      // CS is an invalid region, so we have no data for it.
      expect(
          phoneUtil.getExampleNumberForType(
              regionCode: 'CS', type: PhoneNumberType.mobile),
          isNull);
      // RegionCode 001 is reserved for supporting non-geographical country calling
      // code. We don't support getting an example number for it with this method.
      expect(phoneUtil.getExampleNumber('001'), isNull);
    });

    test('testGetInvalidExampleNumber', () {
      // RegionCode 001 is reserved for supporting non-geographical country calling
      // codes. We don't support getting an invalid example number for it with
      // getInvalidExampleNumber.
      expect(phoneUtil.getInvalidExampleNumber('UN001'), isNull);
      expect(phoneUtil.getInvalidExampleNumber('CS'), isNull);
      PhoneNumber? usInvalidNumber = phoneUtil.getInvalidExampleNumber('US');
      expect(usInvalidNumber?.countryCode, 1);
      expect(usInvalidNumber?.nationalNumber == 0, false);
    });

    test('testGetExampleNumberForNonGeoEntity', () {
      expect(phoneUtil.getExampleNumberForNonGeoEntity(800),
          _internationalTollFree);
      expect(phoneUtil.getExampleNumberForNonGeoEntity(979),
          _universalPremiumRate);
    });

    test('testGetExampleNumberWithoutRegion', () {
      // In our test metadata we don't cover all types: in our real metadata, we do.
      expect(phoneUtil.getExampleNumberForType(type: PhoneNumberType.fixedLine),
          isNotNull);
      expect(phoneUtil.getExampleNumberForType(type: PhoneNumberType.mobile),
          isNotNull);
      expect(
          phoneUtil.getExampleNumberForType(type: PhoneNumberType.premiumRate),
          isNotNull);
    });

    test('testConvertAlphaCharactersInNumber', () {
      final input = '1800-ABC-DEF';
      // Alpha chars are converted to digits; everything else is left untouched.
      final expectedOutput = '1800-222-333';
      expect(phoneUtil.convertAlphaCharactersInNumber(input), expectedOutput);
    });

    test('testNormaliseRemovePunctuation', () {
      final inputNumber = '034-56&+#2\u00AD34';
      final expectedOutput = '03456234';
      expect(
        phoneUtil.normalize(StringBuffer(inputNumber)),
        expectedOutput,
        reason: 'Conversion did not correctly remove punctuation',
      );
    });

    test('testNormaliseReplaceAlphaCharacters', () {
      final inputNumber = '034-I-am-HUNGRY';
      final expectedOutput = '034426486479';
      expect(
        phoneUtil.normalize(StringBuffer(inputNumber)),
        expectedOutput,
        reason: 'Conversion did not correctly replace alpha characters',
      );
    });

    test('testNormaliseOtherDigits', () {
      String inputNumber = '\uFF125\u0665';
      String expectedOutput = '255';
      expect(
        phoneUtil.normalize(StringBuffer(inputNumber)),
        expectedOutput,
        reason: 'Conversion did not correctly replace non-latin digits',
      );
      // Eastern-Arabic digits.
      inputNumber = '\u06F52\u06F0';
      expectedOutput = '520';
      expect(
        phoneUtil.normalize(StringBuffer(inputNumber)),
        expectedOutput,
        reason: 'Conversion did not correctly replace non-latin digits',
      );
    });

    test('testNormaliseStripAlphaCharacters', () {
      final inputNumber = '034-56&+a#234';
      final expectedOutput = '03456234';
      expect(
        PhoneNumberUtil.normalizeDigitsOnly(inputNumber),
        expectedOutput,
        reason: 'Conversion did not correctly remove alpha character',
      );
    });

    test('testNormaliseStripNonDiallableCharacters', () {
      final inputNumber = '03*4-56&+1a#234';
      final expectedOutput = '03*456+1#234';
      expect(
        phoneUtil.normalizeDiallableCharsOnly(inputNumber),
        expectedOutput,
        reason: 'Conversion did not correctly remove non-diallable characters',
      );
    });

    test('testFormatUSNumber', () {
      expect(phoneUtil.format(_usNumber, PhoneNumberFormat.national),
          '650 253 0000');
      expect(phoneUtil.format(_usNumber, PhoneNumberFormat.international),
          '+1 650 253 0000');

      expect(phoneUtil.format(_usTollfree, PhoneNumberFormat.national),
          '800 253 0000');
      expect(phoneUtil.format(_usTollfree, PhoneNumberFormat.international),
          '+1 800 253 0000');

      expect(phoneUtil.format(_usPremium, PhoneNumberFormat.national),
          '900 253 0000');
      expect(phoneUtil.format(_usPremium, PhoneNumberFormat.international),
          '+1 900 253 0000');
      expect(phoneUtil.format(_usPremium, PhoneNumberFormat.rfc3966),
          'tel:+1-900-253-0000');
      // Numbers with all zeros in the national number part will be formatted by
      // using the raw_input if that is available no matter which format is
      // specified.
      expect(phoneUtil.format(_usSpoofWithRawInput, PhoneNumberFormat.national),
          '000-000-0000');
      expect(phoneUtil.format(_usSpoof, PhoneNumberFormat.national), '0');
    });

    test('testFormatBSNumber', () {
      expect(phoneUtil.format(_bsNumber, PhoneNumberFormat.national),
          '242 365 1234');
      expect(phoneUtil.format(_bsNumber, PhoneNumberFormat.international),
          '+1 242 365 1234');
    });

    test('testFormatGBNumber', () {
      expect(phoneUtil.format(_gbNumber, PhoneNumberFormat.national),
          '(020) 7031 3000');
      expect(phoneUtil.format(_gbNumber, PhoneNumberFormat.international),
          '+44 20 7031 3000');

      expect(phoneUtil.format(_gbMobile, PhoneNumberFormat.national),
          '(07912) 345 678');
      expect(phoneUtil.format(_gbMobile, PhoneNumberFormat.international),
          '+44 7912 345 678');
    });

    test('testFormatDENumber', () {
      var deNumber = PhoneNumber()
        ..countryCode = 49
        ..nationalNumber = Int64(301234);
      expect(
          phoneUtil.format(deNumber, PhoneNumberFormat.national), '030/1234');
      expect(phoneUtil.format(deNumber, PhoneNumberFormat.international),
          '+49 30/1234');
      expect(phoneUtil.format(deNumber, PhoneNumberFormat.rfc3966),
          'tel:+49-30-1234');

      deNumber = PhoneNumber()
        ..countryCode = 49
        ..nationalNumber = Int64(291123);
      expect(
          phoneUtil.format(deNumber, PhoneNumberFormat.national), '0291 123');
      expect(phoneUtil.format(deNumber, PhoneNumberFormat.international),
          '+49 291 123');

      deNumber = PhoneNumber()
        ..countryCode = 49
        ..nationalNumber = Int64(29112345678);
      expect(phoneUtil.format(deNumber, PhoneNumberFormat.national),
          '0291 12345678');
      expect(phoneUtil.format(deNumber, PhoneNumberFormat.international),
          '+49 291 12345678');

      deNumber = PhoneNumber()
        ..countryCode = 49
        ..nationalNumber = Int64(912312345);
      expect(phoneUtil.format(deNumber, PhoneNumberFormat.national),
          '09123 12345');
      expect(phoneUtil.format(deNumber, PhoneNumberFormat.international),
          '+49 9123 12345');

      deNumber = PhoneNumber()
        ..countryCode = 49
        ..nationalNumber = Int64(80212345);
      expect(
          phoneUtil.format(deNumber, PhoneNumberFormat.national), '08021 2345');
      expect(phoneUtil.format(deNumber, PhoneNumberFormat.international),
          '+49 8021 2345');

      // Note this number is correctly formatted without national prefix. Most of
      // the numbers that are treated as invalid numbers by the library are short
      // numbers, and they are usually not dialed with national prefix.
      expect(
          phoneUtil.format(_deShortNumber, PhoneNumberFormat.national), '1234');
      expect(phoneUtil.format(_deShortNumber, PhoneNumberFormat.international),
          '+49 1234');

      deNumber = PhoneNumber()
        ..countryCode = 49
        ..nationalNumber = Int64(41341234);
      expect(
          phoneUtil.format(deNumber, PhoneNumberFormat.national), '04134 1234');
    });

    test('testFormatITNumber', () {
      expect(phoneUtil.format(_itNumber, PhoneNumberFormat.national),
          '02 3661 8300');
      expect(phoneUtil.format(_itNumber, PhoneNumberFormat.international),
          '+39 02 3661 8300');
      expect(
          phoneUtil.format(_itNumber, PhoneNumberFormat.e164), '+390236618300');

      expect(phoneUtil.format(_itMobile, PhoneNumberFormat.national),
          '345 678 901');
      expect(phoneUtil.format(_itMobile, PhoneNumberFormat.international),
          '+39 345 678 901');
      expect(
          phoneUtil.format(_itMobile, PhoneNumberFormat.e164), '+39345678901');
    });

    test('testFormatAUNumber', () {
      expect(phoneUtil.format(_auNumber, PhoneNumberFormat.national),
          '02 3661 8300');
      expect(phoneUtil.format(_auNumber, PhoneNumberFormat.international),
          '+61 2 3661 8300');
      expect(
          phoneUtil.format(_auNumber, PhoneNumberFormat.e164), '+61236618300');

      final auNumber = PhoneNumber()
        ..countryCode = 61
        ..nationalNumber = Int64(1800123456);
      expect(phoneUtil.format(auNumber, PhoneNumberFormat.national),
          '1800 123 456');
      expect(phoneUtil.format(auNumber, PhoneNumberFormat.international),
          '+61 1800 123 456');
      expect(
          phoneUtil.format(auNumber, PhoneNumberFormat.e164), '+611800123456');
    });

    test('testFormatARNumber', () {
      expect(phoneUtil.format(_arNumber, PhoneNumberFormat.national),
          '011 8765-4321');
      expect(phoneUtil.format(_arNumber, PhoneNumberFormat.international),
          '+54 11 8765-4321');
      expect(
          phoneUtil.format(_arNumber, PhoneNumberFormat.e164), '+541187654321');

      expect(phoneUtil.format(_arMobile, PhoneNumberFormat.national),
          '011 15 8765-4321');
      expect(phoneUtil.format(_arMobile, PhoneNumberFormat.international),
          '+54 9 11 8765 4321');
      expect(phoneUtil.format(_arMobile, PhoneNumberFormat.e164),
          '+5491187654321');
    });

    test('testFormatMXNumber', () {
      expect(phoneUtil.format(_mxMobile1, PhoneNumberFormat.national),
          '045 234 567 8900');
      expect(phoneUtil.format(_mxMobile1, PhoneNumberFormat.international),
          '+52 1 234 567 8900');
      expect(phoneUtil.format(_mxMobile1, PhoneNumberFormat.e164),
          '+5212345678900');

      expect(phoneUtil.format(_mxMobile2, PhoneNumberFormat.national),
          '045 55 1234 5678');
      expect(phoneUtil.format(_mxMobile2, PhoneNumberFormat.international),
          '+52 1 55 1234 5678');
      expect(phoneUtil.format(_mxMobile2, PhoneNumberFormat.e164),
          '+5215512345678');

      expect(phoneUtil.format(_mxNumber1, PhoneNumberFormat.national),
          '01 33 1234 5678');
      expect(phoneUtil.format(_mxNumber1, PhoneNumberFormat.international),
          '+52 33 1234 5678');
      expect(phoneUtil.format(_mxNumber1, PhoneNumberFormat.e164),
          '+523312345678');

      expect(phoneUtil.format(_mxNumber2, PhoneNumberFormat.national),
          '01 821 123 4567');
      expect(phoneUtil.format(_mxNumber2, PhoneNumberFormat.international),
          '+52 821 123 4567');
      expect(phoneUtil.format(_mxNumber2, PhoneNumberFormat.e164),
          '+528211234567');
    });

    test('testFormatOutOfCountryCallingNumber', () {
      expect(phoneUtil.formatOutOfCountryCallingNumber(_usPremium, 'DE'),
          '00 1 900 253 0000');

      expect(phoneUtil.formatOutOfCountryCallingNumber(_usNumber, 'BS'),
          '1 650 253 0000');

      expect(phoneUtil.formatOutOfCountryCallingNumber(_usNumber, 'PL'),
          '00 1 650 253 0000');

      expect(phoneUtil.formatOutOfCountryCallingNumber(_gbMobile, 'US'),
          '011 44 7912 345 678');

      expect(phoneUtil.formatOutOfCountryCallingNumber(_deShortNumber, 'GB'),
          '00 49 1234');
      // Note this number is correctly formatted without national prefix. Most of
      // the numbers that are treated as invalid numbers by the library are short
      // numbers, and they are usually not dialed with national prefix.
      expect(phoneUtil.formatOutOfCountryCallingNumber(_deShortNumber, 'DE'),
          '1234');

      expect(phoneUtil.formatOutOfCountryCallingNumber(_itNumber, 'US'),
          '011 39 02 3661 8300');
      expect(phoneUtil.formatOutOfCountryCallingNumber(_itNumber, 'IT'),
          '02 3661 8300');
      expect(phoneUtil.formatOutOfCountryCallingNumber(_itNumber, 'SG'),
          '+39 02 3661 8300');

      expect(phoneUtil.formatOutOfCountryCallingNumber(_sgNumber, 'SG'),
          '6521 8000');

      expect(phoneUtil.formatOutOfCountryCallingNumber(_arMobile, 'US'),
          '011 54 9 11 8765 4321');
      expect(
          phoneUtil.formatOutOfCountryCallingNumber(
              _internationalTollFree, 'US'),
          '011 800 1234 5678');

      PhoneNumber arNumberWithExtn = _arMobile.deepCopy();
      arNumberWithExtn.extension_3 = '1234';
      expect(phoneUtil.formatOutOfCountryCallingNumber(arNumberWithExtn, 'US'),
          '011 54 9 11 8765 4321 ext. 1234');
      expect(phoneUtil.formatOutOfCountryCallingNumber(arNumberWithExtn, 'AU'),
          '0011 54 9 11 8765 4321 ext. 1234');
      expect(phoneUtil.formatOutOfCountryCallingNumber(arNumberWithExtn, 'AR'),
          '011 15 8765-4321 ext. 1234');
    });

    test('testFormatOutOfCountryWithInvalidRegion', () {
      // AQ/Antarctica isn't a valid region code for phone number formatting,
      // so this falls back to intl formatting.
      expect(phoneUtil.formatOutOfCountryCallingNumber(_usNumber, 'AQ'),
          '+1 650 253 0000');
      // For region code 001, the out-of-country format always turns into the
      // international format.
      expect(phoneUtil.formatOutOfCountryCallingNumber(_usNumber, '001'),
          '+1 650 253 0000');
    });

    test('testFormatOutOfCountryWithPreferredIntlPrefix', () {
      // This should use 0011, since that is the preferred international prefix
      // (both 0011 and 0012 are accepted as possible international prefixes in our
      // test metadta.)
      expect(phoneUtil.formatOutOfCountryCallingNumber(_itNumber, 'AU'),
          '0011 39 02 3661 8300');

      // Testing preferred international prefixes with ~ are supported (designates
      // waiting).
      expect(phoneUtil.formatOutOfCountryCallingNumber(_itNumber, 'UZ'),
          '8~10 39 02 3661 8300');
    });

    test('testFormatOutOfCountryKeepingAlphaChars', () {
      final alphaNumericNumber = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(8007493524)
        ..rawInput = '1800 six-flag';
      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumber, 'AU'),
          '0011 1 800 SIX-FLAG');

      alphaNumericNumber.rawInput = '1-800-SIX-flag';
      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumber, 'AU'),
          '0011 1 800-SIX-FLAG');

      alphaNumericNumber.rawInput = 'Call us from UK: 00 1 800 SIX-flag';
      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumber, 'AU'),
          '0011 1 800 SIX-FLAG');

      alphaNumericNumber.rawInput = '800 SIX-flag';
      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumber, 'AU'),
          '0011 1 800 SIX-FLAG');

      // Formatting from within the NANPA region.
      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumber, 'US'),
          '1 800 SIX-FLAG');

      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumber, 'BS'),
          '1 800 SIX-FLAG');

      // Testing a number with extension.
      PhoneNumber alphaNumericNumberWithExtn =
          phoneUtil.parseAndKeepRawInput("800 SIX-flag ext. 1234", 'US');
      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumberWithExtn, 'AU'),
          "0011 1 800 SIX-FLAG extn. 1234");

      // Testing that if the raw input doesn't exist, it is formatted using
      // formatOutOfCountryCallingNumber.
      alphaNumericNumber.clearRawInput();
      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumber, 'DE'),
          '00 1 800 749 3524');

      // Testing AU alpha number formatted from Australia.
      alphaNumericNumber.countryCode = 61;
      alphaNumericNumber.nationalNumber = Int64(827493524);
      alphaNumericNumber.rawInput = '+61 82749-FLAG';
      // This number should have the national prefix fixed.
      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumber, 'AU'),
          '082749-FLAG');

      alphaNumericNumber.rawInput = '082749-FLAG';
      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumber, 'AU'),
          '082749-FLAG');

      alphaNumericNumber.nationalNumber = Int64(18007493524);
      alphaNumericNumber.rawInput = '1-800-SIX-flag';
      // This number should not have the national prefix prefixed, in accordance
      // with the override for this specific formatting rule.
      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumber, 'AU'),
          '1-800-SIX-FLAG');

      // The metadata should not be permanently changed, since we copied it before
      // modifying patterns. Here we check this.
      alphaNumericNumber.nationalNumber = Int64(1800749352);
      expect(
          phoneUtil.formatOutOfCountryCallingNumber(alphaNumericNumber, 'AU'),
          '1800 749 352');

      // Testing a region with multiple international prefixes.
      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumber, 'SG'),
          '+61 1-800-SIX-FLAG');
      // Testing the case of calling from a non-supported region.
      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumber, 'AQ'),
          '+61 1-800-SIX-FLAG');

      // Testing the case with an invalid country calling code.
      alphaNumericNumber.countryCode = 0;
      alphaNumericNumber.nationalNumber = Int64(18007493524);
      alphaNumericNumber.rawInput = '1-800-SIX-flag';
      // Uses the raw input only.
      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumber, 'DE'),
          '1-800-SIX-flag');

      // Testing the case of an invalid alpha number.
      alphaNumericNumber.countryCode = 1;
      alphaNumericNumber.nationalNumber = Int64(80749);
      alphaNumericNumber.rawInput = '180-SIX';
      // No country-code stripping can be done.
      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumber, 'DE'),
          '00 1 180-SIX');

      // Testing the case of calling from a non-supported region.
      alphaNumericNumber.countryCode = 1;
      alphaNumericNumber.nationalNumber = Int64(80749);
      alphaNumericNumber.rawInput = '180-SIX';
      // No country-code stripping can be done since the number is invalid.
      expect(
          phoneUtil.formatOutOfCountryKeepingAlphaChars(
              alphaNumericNumber, 'AQ'),
          '+1 180-SIX');
    });

    test('testFormatWithCarrierCode', () {
      // We only support this for AR in our test metadata, and only for mobile
      // numbers starting with certain values.
      final arMobile = PhoneNumber()
        ..countryCode = 54
        ..nationalNumber = Int64(92234654321);
      expect(phoneUtil.format(arMobile, PhoneNumberFormat.national),
          '02234 65-4321');
      // Here we force 14 as the carrier code.
      expect(phoneUtil.formatNationalNumberWithCarrierCode(arMobile, '14'),
          '02234 14 65-4321');
      // Here we force the number to be shown with no carrier code.
      expect(phoneUtil.formatNationalNumberWithCarrierCode(arMobile, ''),
          '02234 65-4321');
      // Here the international rule is used, so no carrier code should be present.
      expect(
          phoneUtil.format(arMobile, PhoneNumberFormat.e164), '+5492234654321');
      // We don't support this for the US so there should be no change.
      expect(phoneUtil.formatNationalNumberWithCarrierCode(_usNumber, '15'),
          '650 253 0000');
      // Invalid country code should just get the NSN.
      expect(
          phoneUtil.formatNationalNumberWithCarrierCode(
              _unknownCountryCodeNoRawInput, '89'),
          '12345');
    });

    test('testFormatWithPreferredCarrierCode', () {
      // We only support this for AR in our test metadata.
      final arNumber = PhoneNumber()
        ..countryCode = 54
        ..nationalNumber = Int64(91234125678);
      // Test formatting with no preferred carrier code stored in the number itself.
      expect(
          phoneUtil.formatNationalNumberWithPreferredCarrierCode(
              arNumber, '15'),
          '01234 15 12-5678');
      expect(
          phoneUtil.formatNationalNumberWithPreferredCarrierCode(arNumber, ''),
          '01234 12-5678');
      // Test formatting with preferred carrier code present.
      arNumber.preferredDomesticCarrierCode = '19';
      expect(phoneUtil.format(arNumber, PhoneNumberFormat.national),
          '01234 12-5678');
      expect(
          phoneUtil.formatNationalNumberWithPreferredCarrierCode(
              arNumber, '15'),
          '01234 19 12-5678');
      expect(
          phoneUtil.formatNationalNumberWithPreferredCarrierCode(arNumber, ''),
          '01234 19 12-5678');
      // When the preferred_domestic_carrier_code is present (even when it is just a
      // space), use it instead of the default carrier code passed in.
      arNumber.preferredDomesticCarrierCode = ' ';
      expect(
          phoneUtil.formatNationalNumberWithPreferredCarrierCode(
              arNumber, '15'),
          '01234   12-5678');
      // When the preferred_domestic_carrier_code is present but empty, treat it as
      // unset and use instead the default carrier code passed in.
      arNumber.preferredDomesticCarrierCode = '';
      expect(
          phoneUtil.formatNationalNumberWithPreferredCarrierCode(
              arNumber, '15'),
          '01234 15 12-5678');
      // We don't support this for the US so there should be no change.
      final usNumber = PhoneNumber();
      usNumber.countryCode = 1;
      usNumber.nationalNumber = Int64(4241231234);
      usNumber.preferredDomesticCarrierCode = '99';
      expect(phoneUtil.format(usNumber, PhoneNumberFormat.national),
          '424 123 1234');
      expect(
          phoneUtil.formatNationalNumberWithPreferredCarrierCode(
              usNumber, '15'),
          '424 123 1234');
    });

    test('testFormatNumberForMobileDialing', () {
      // Numbers are normally dialed in national format in-country, and
      // international format from outside the country.
      expect(phoneUtil.formatNumberForMobileDialing(_coFixedLine, 'CO', false),
          '6012345678');
      expect(phoneUtil.formatNumberForMobileDialing(_deNumber, 'DE', false),
          '030123456');
      expect(phoneUtil.formatNumberForMobileDialing(_deNumber, 'CH', false),
          '+4930123456');

      final deNumberWithExtn = _deNumber.deepCopy();
      deNumberWithExtn.extension_3 = '1234';
      expect(
          phoneUtil.formatNumberForMobileDialing(deNumberWithExtn, 'DE', false),
          '030123456');
      expect(
          phoneUtil.formatNumberForMobileDialing(deNumberWithExtn, 'CH', false),
          '+4930123456');

      // US toll free numbers are marked as noInternationalDialling in the test
      // metadata for testing purposes. For such numbers, we expect nothing to be
      // returned when the region code is not the same one.
      expect(phoneUtil.formatNumberForMobileDialing(_usTollfree, 'US', true),
          '800 253 0000');
      expect(
          phoneUtil.formatNumberForMobileDialing(_usTollfree, 'CN', true), '');
      expect(phoneUtil.formatNumberForMobileDialing(_usNumber, 'US', true),
          '+1 650 253 0000');

      PhoneNumber usNumberWithExtn = _usNumber.deepCopy();
      usNumberWithExtn.extension_3 = '1234';
      expect(
          phoneUtil.formatNumberForMobileDialing(usNumberWithExtn, 'US', true),
          '+1 650 253 0000');

      expect(phoneUtil.formatNumberForMobileDialing(_usTollfree, 'US', false),
          '8002530000');
      expect(
          phoneUtil.formatNumberForMobileDialing(_usTollfree, 'CN', false), '');
      expect(phoneUtil.formatNumberForMobileDialing(_usNumber, 'US', false),
          '+16502530000');
      expect(
          phoneUtil.formatNumberForMobileDialing(usNumberWithExtn, 'US', false),
          '+16502530000');

      // An invalid US number, which is one digit too long.
      expect(phoneUtil.formatNumberForMobileDialing(_usLongNumber, 'US', false),
          '+165025300001');
      expect(phoneUtil.formatNumberForMobileDialing(_usLongNumber, 'US', true),
          '+1 65025300001');

      // Star numbers. In real life they appear in Israel, but we have them in JP
      // in our test metadata.
      expect(phoneUtil.formatNumberForMobileDialing(_jpStarNumber, 'JP', false),
          '*2345');
      expect(phoneUtil.formatNumberForMobileDialing(_jpStarNumber, 'JP', true),
          '*2345');

      expect(
          phoneUtil.formatNumberForMobileDialing(
              _internationalTollFree, 'JP', false),
          '+80012345678');
      expect(
          phoneUtil.formatNumberForMobileDialing(
              _internationalTollFree, 'JP', true),
          '+800 1234 5678');

      // UAE numbers beginning with 600 (classified as UAN) need to be dialled
      // without +971 locally.
      expect(phoneUtil.formatNumberForMobileDialing(_aeUan, 'JP', false),
          '+971600123456');
      expect(phoneUtil.formatNumberForMobileDialing(_aeUan, 'AE', false),
          '600123456');

      expect(phoneUtil.formatNumberForMobileDialing(_mxNumber1, 'MX', false),
          '+523312345678');
      expect(phoneUtil.formatNumberForMobileDialing(_mxNumber1, 'US', false),
          '+523312345678');

      // Test whether Uzbek phone numbers are returned in international format even
      // when dialled from same region or other regions.
      // Fixed-line number
      expect(phoneUtil.formatNumberForMobileDialing(_uzFixedLine, 'UZ', false),
          '+998612201234');
      // Mobile number
      expect(phoneUtil.formatNumberForMobileDialing(_uzMobile, 'UZ', false),
          '+998950123456');
      expect(phoneUtil.formatNumberForMobileDialing(_uzMobile, 'US', false),
          '+998950123456');

      // Non-geographical numbers should always be dialed in international format.
      expect(
          phoneUtil.formatNumberForMobileDialing(
              _internationalTollFree, 'US', false),
          '+80012345678');
      expect(
          phoneUtil.formatNumberForMobileDialing(
              _internationalTollFree, '001', false),
          '+80012345678');

      // Test that a short number is formatted correctly for mobile dialing within
      // the region, and is not diallable from outside the region.
      final deShortNumber = PhoneNumber()
        ..countryCode = 49
        ..nationalNumber = Int64(123);
      expect(phoneUtil.formatNumberForMobileDialing(deShortNumber, 'DE', false),
          '123');
      expect(phoneUtil.formatNumberForMobileDialing(deShortNumber, 'IT', false),
          '');

      // Test the special logic for NANPA countries, for which regular length phone
      // numbers are always output in international format, but short numbers are in
      // national format.
      expect(phoneUtil.formatNumberForMobileDialing(_usNumber, 'US', false),
          '+16502530000');
      expect(phoneUtil.formatNumberForMobileDialing(_usNumber, 'CA', false),
          '+16502530000');
      expect(phoneUtil.formatNumberForMobileDialing(_usNumber, 'BR', false),
          '+16502530000');
      final usShortNumber = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(911);
      expect(phoneUtil.formatNumberForMobileDialing(usShortNumber, 'US', false),
          '911');
      expect(phoneUtil.formatNumberForMobileDialing(usShortNumber, 'CA', false),
          '');
      expect(phoneUtil.formatNumberForMobileDialing(usShortNumber, 'BR', false),
          '');

      // Test that the Australian emergency number 000 is formatted correctly.
      final auShortNumber = PhoneNumber()
        ..countryCode = 61
        ..nationalNumber = Int64(0)
        ..italianLeadingZero = true
        ..numberOfLeadingZeros = 2;
      expect(phoneUtil.formatNumberForMobileDialing(auShortNumber, 'AU', false),
          '000');
      expect(phoneUtil.formatNumberForMobileDialing(auShortNumber, 'NZ', false),
          '');
    });

    test('testFormatByPattern', () {
      final newNumFormat = NumberFormat()
        ..pattern = '(\\d{3})(\\d{3})(\\d{4})'
        ..format = r'($1) $2-$3';

      expect(
          phoneUtil.formatByPattern(
              _usNumber, PhoneNumberFormat.national, [newNumFormat]),
          '(650) 253-0000');
      expect(
          phoneUtil.formatByPattern(
              _usNumber, PhoneNumberFormat.international, [newNumFormat]),
          '+1 (650) 253-0000');
      expect(
          phoneUtil.formatByPattern(
              _usNumber, PhoneNumberFormat.rfc3966, [newNumFormat]),
          'tel:+1-650-253-0000');

      // $NP is set to '1' for the US. Here we check that for other NANPA countries
      // the US rules are followed.
      newNumFormat.nationalPrefixFormattingRule = r'$NP ($FG)';
      newNumFormat.format = r'$1 $2-$3';
      expect(
          phoneUtil.formatByPattern(
              _bsNumber, PhoneNumberFormat.national, [newNumFormat]),
          '1 (242) 365-1234');
      expect(
          phoneUtil.formatByPattern(
              _bsNumber, PhoneNumberFormat.international, [newNumFormat]),
          '+1 242 365-1234');

      newNumFormat.pattern = '(\\d{2})(\\d{5})(\\d{3})';
      newNumFormat.format = r'$1-$2 $3';
      expect(
          phoneUtil.formatByPattern(
              _itNumber, PhoneNumberFormat.national, [newNumFormat]),
          '02-36618 300');
      expect(
          phoneUtil.formatByPattern(
              _itNumber, PhoneNumberFormat.international, [newNumFormat]),
          '+39 02-36618 300');

      newNumFormat.nationalPrefixFormattingRule = r'$NP$FG';
      newNumFormat.pattern = '(\\d{2})(\\d{4})(\\d{4})';
      newNumFormat.format = r'$1 $2 $3';
      expect(
          phoneUtil.formatByPattern(
              _gbNumber, PhoneNumberFormat.national, [newNumFormat]),
          '020 7031 3000');

      newNumFormat.nationalPrefixFormattingRule = r'($NP$FG)';
      expect(
          phoneUtil.formatByPattern(
              _gbNumber, PhoneNumberFormat.national, [newNumFormat]),
          '(020) 7031 3000');

      newNumFormat.nationalPrefixFormattingRule = '';
      expect(
          phoneUtil.formatByPattern(
              _gbNumber, PhoneNumberFormat.national, [newNumFormat]),
          '20 7031 3000');
      expect(
          phoneUtil.formatByPattern(
              _gbNumber, PhoneNumberFormat.international, [newNumFormat]),
          '+44 20 7031 3000');
    });

    test('testFormatE164Number', () {
      expect(
          phoneUtil.format(_usNumber, PhoneNumberFormat.e164), '+16502530000');
      expect(
          phoneUtil.format(_deNumber, PhoneNumberFormat.e164), '+4930123456');
      expect(phoneUtil.format(_internationalTollFree, PhoneNumberFormat.e164),
          '+80012345678');
    });

    test('testFormatNumberWithExtension', () {
      PhoneNumber nzNumber = _nzNumber.deepCopy();
      nzNumber.extension_3 = '1234';
      // Uses default extension prefix:
      expect(phoneUtil.format(nzNumber, PhoneNumberFormat.national),
          '03-331 6005 ext. 1234');
      // Uses RFC 3966 syntax.
      expect(phoneUtil.format(nzNumber, PhoneNumberFormat.rfc3966),
          'tel:+64-3-331-6005;ext=1234');
      // Extension prefix overridden in the territory information for the US:
      PhoneNumber usNumberWithExtension = _usNumber.deepCopy();
      usNumberWithExtension.extension_3 = '4567';
      expect(
          phoneUtil.format(usNumberWithExtension, PhoneNumberFormat.national),
          '650 253 0000 extn. 4567');
    });

    test('testFormatInOriginalFormat', () {
      PhoneNumber number1 =
          phoneUtil.parseAndKeepRawInput('+442087654321', 'GB');
      expect(
          phoneUtil.formatInOriginalFormat(number1, 'GB'), '+44 20 8765 4321');

      PhoneNumber number2 = phoneUtil.parseAndKeepRawInput('02087654321', 'GB');
      expect(
          phoneUtil.formatInOriginalFormat(number2, 'GB'), '(020) 8765 4321');

      PhoneNumber number3 =
          phoneUtil.parseAndKeepRawInput('011442087654321', 'US');
      expect(phoneUtil.formatInOriginalFormat(number3, 'US'),
          '011 44 20 8765 4321');

      PhoneNumber number4 =
          phoneUtil.parseAndKeepRawInput('442087654321', 'GB');
      expect(
          phoneUtil.formatInOriginalFormat(number4, 'GB'), '44 20 8765 4321');

      PhoneNumber number5 = phoneUtil.parse('+442087654321', 'GB');
      expect(
          phoneUtil.formatInOriginalFormat(number5, 'GB'), '(020) 8765 4321');

      // Invalid numbers that we have a formatting pattern for should be formatted
      // properly. Note area codes starting with 7 are intentionally excluded in
      // the test metadata for testing purposes.
      PhoneNumber number6 = phoneUtil.parseAndKeepRawInput('7345678901', 'US');
      expect(phoneUtil.formatInOriginalFormat(number6, 'US'), '734 567 8901');

      // US is not a leading zero country, and the presence of the leading zero
      // leads us to format the number using raw_input.
      PhoneNumber number7 =
          phoneUtil.parseAndKeepRawInput('0734567 8901', 'US');
      expect(phoneUtil.formatInOriginalFormat(number7, 'US'), '0734567 8901');

      // This number is valid, but we don't have a formatting pattern for it.
      // Fall back to the raw input.
      PhoneNumber number8 =
          phoneUtil.parseAndKeepRawInput('02-4567-8900', 'KR');
      expect(phoneUtil.formatInOriginalFormat(number8, 'KR'), '02-4567-8900');

      PhoneNumber number9 =
          phoneUtil.parseAndKeepRawInput('01180012345678', 'US');
      expect(
          phoneUtil.formatInOriginalFormat(number9, 'US'), '011 800 1234 5678');

      PhoneNumber number10 =
          phoneUtil.parseAndKeepRawInput('+80012345678', 'KR');
      expect(
          phoneUtil.formatInOriginalFormat(number10, 'KR'), '+800 1234 5678');

      // US local numbers are formatted correctly, as we have formatting patterns
      // for them.
      PhoneNumber localNumberUS =
          phoneUtil.parseAndKeepRawInput('2530000', 'US');
      expect(phoneUtil.formatInOriginalFormat(localNumberUS, 'US'), '253 0000');

      PhoneNumber numberWithNationalPrefixUS =
          phoneUtil.parseAndKeepRawInput('18003456789', 'US');
      expect(phoneUtil.formatInOriginalFormat(numberWithNationalPrefixUS, 'US'),
          '1 800 345 6789');

      PhoneNumber numberWithoutNationalPrefixGB =
          phoneUtil.parseAndKeepRawInput('2087654321', 'GB');
      expect(
          phoneUtil.formatInOriginalFormat(numberWithoutNationalPrefixGB, 'GB'),
          '20 8765 4321');
      // Make sure no metadata is modified as a result of the previous function
      // call.
      expect(
          phoneUtil.formatInOriginalFormat(number5, 'GB'), '(020) 8765 4321');

      PhoneNumber numberWithNationalPrefixMX =
          phoneUtil.parseAndKeepRawInput('013312345678', 'MX');
      expect(phoneUtil.formatInOriginalFormat(numberWithNationalPrefixMX, 'MX'),
          '01 33 1234 5678');

      PhoneNumber numberWithoutNationalPrefixMX =
          phoneUtil.parseAndKeepRawInput('3312345678', 'MX');
      expect(
          phoneUtil.formatInOriginalFormat(numberWithoutNationalPrefixMX, 'MX'),
          '33 1234 5678');

      PhoneNumber italianFixedLineNumber =
          phoneUtil.parseAndKeepRawInput('0212345678', 'IT');
      expect(phoneUtil.formatInOriginalFormat(italianFixedLineNumber, 'IT'),
          '02 1234 5678');

      PhoneNumber numberWithNationalPrefixJP =
          phoneUtil.parseAndKeepRawInput('00777012', 'JP');
      expect(phoneUtil.formatInOriginalFormat(numberWithNationalPrefixJP, 'JP'),
          '0077-7012');

      PhoneNumber numberWithoutNationalPrefixJP =
          phoneUtil.parseAndKeepRawInput('0777012', 'JP');
      expect(
          phoneUtil.formatInOriginalFormat(numberWithoutNationalPrefixJP, 'JP'),
          '0777012');

      PhoneNumber numberWithCarrierCodeBR =
          phoneUtil.parseAndKeepRawInput('012 3121286979', 'BR');
      expect(phoneUtil.formatInOriginalFormat(numberWithCarrierCodeBR, 'BR'),
          '012 3121286979');

      // The default national prefix used in this case is 045. When a number with
      // national prefix 044 is entered, we return the raw input as we don't want to
      // change the number entered.
      PhoneNumber numberWithNationalPrefixMX1 =
          phoneUtil.parseAndKeepRawInput('044(33)1234-5678', 'MX');
      expect(
          phoneUtil.formatInOriginalFormat(numberWithNationalPrefixMX1, 'MX'),
          '044(33)1234-5678');

      PhoneNumber numberWithNationalPrefixMX2 =
          phoneUtil.parseAndKeepRawInput('045(33)1234-5678', 'MX');
      expect(
          phoneUtil.formatInOriginalFormat(numberWithNationalPrefixMX2, 'MX'),
          '045 33 1234 5678');

      // The default international prefix used in this case is 0011. When a number
      // with international prefix 0012 is entered, we return the raw input as we
      // don't want to change the number entered.
      PhoneNumber outOfCountryNumberFromAU1 =
          phoneUtil.parseAndKeepRawInput('0012 16502530000', 'AU');
      expect(phoneUtil.formatInOriginalFormat(outOfCountryNumberFromAU1, 'AU'),
          '0012 16502530000');

      PhoneNumber outOfCountryNumberFromAU2 =
          phoneUtil.parseAndKeepRawInput('0011 16502530000', 'AU');
      expect(phoneUtil.formatInOriginalFormat(outOfCountryNumberFromAU2, 'AU'),
          '0011 1 650 253 0000');

      // Test the star sign is not removed from or added to the original input by
      // this method.
      PhoneNumber starNumber = phoneUtil.parseAndKeepRawInput('*1234', 'JP');
      expect(phoneUtil.formatInOriginalFormat(starNumber, 'JP'), '*1234');

      PhoneNumber numberWithoutStar =
          phoneUtil.parseAndKeepRawInput('1234', 'JP');
      expect(phoneUtil.formatInOriginalFormat(numberWithoutStar, 'JP'), '1234');

      // Test an invalid national number without raw input is just formatted as the
      // national number.
      expect(phoneUtil.formatInOriginalFormat(_usShortByOneNumber, 'US'),
          '650253000');
    });

    test('testIsPremiumRate', () {
      expect(PhoneNumberType.premiumRate, phoneUtil.getNumberType(_usPremium));

      var premiumRateNumber = PhoneNumber()
        ..countryCode = 39
        ..nationalNumber = Int64(892123);
      expect(phoneUtil.getNumberType(premiumRateNumber),
          PhoneNumberType.premiumRate);

      premiumRateNumber = PhoneNumber()
        ..countryCode = 44
        ..nationalNumber = Int64(9187654321);
      expect(phoneUtil.getNumberType(premiumRateNumber),
          PhoneNumberType.premiumRate);

      premiumRateNumber = PhoneNumber()
        ..countryCode = 49
        ..nationalNumber = Int64(9001654321);
      expect(phoneUtil.getNumberType(premiumRateNumber),
          PhoneNumberType.premiumRate);

      premiumRateNumber = PhoneNumber()
        ..countryCode = 49
        ..nationalNumber = Int64(90091234567);
      expect(phoneUtil.getNumberType(premiumRateNumber),
          PhoneNumberType.premiumRate);
      expect(phoneUtil.getNumberType(_universalPremiumRate),
          PhoneNumberType.premiumRate);
    });

    test('testIsTollFree', () {
      var tollFreeNumber = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(8881234567);
      expect(phoneUtil.getNumberType(tollFreeNumber), PhoneNumberType.tollFree);

      tollFreeNumber = PhoneNumber()
        ..countryCode = 39
        ..nationalNumber = Int64(803123);
      expect(phoneUtil.getNumberType(tollFreeNumber), PhoneNumberType.tollFree);

      tollFreeNumber = PhoneNumber()
        ..countryCode = 44
        ..nationalNumber = Int64(8012345678);
      expect(phoneUtil.getNumberType(tollFreeNumber), PhoneNumberType.tollFree);

      tollFreeNumber = PhoneNumber()
        ..countryCode = 49
        ..nationalNumber = Int64(8001234567);
      expect(phoneUtil.getNumberType(tollFreeNumber), PhoneNumberType.tollFree);
      expect(phoneUtil.getNumberType(_internationalTollFree),
          PhoneNumberType.tollFree);
    });

    test('testIsMobile', () {
      expect(phoneUtil.getNumberType(_bsMobile), PhoneNumberType.mobile);
      expect(phoneUtil.getNumberType(_gbMobile), PhoneNumberType.mobile);
      expect(phoneUtil.getNumberType(_itMobile), PhoneNumberType.mobile);
      expect(phoneUtil.getNumberType(_arMobile), PhoneNumberType.mobile);

      final mobileNumber = PhoneNumber()
        ..countryCode = 49
        ..nationalNumber = Int64(15123456789);
      expect(phoneUtil.getNumberType(mobileNumber), PhoneNumberType.mobile);
    });

    test('testIsFixedLine', () {
      expect(phoneUtil.getNumberType(_bsNumber), PhoneNumberType.fixedLine);
      expect(phoneUtil.getNumberType(_itNumber), PhoneNumberType.fixedLine);
      expect(phoneUtil.getNumberType(_gbNumber), PhoneNumberType.fixedLine);
      expect(phoneUtil.getNumberType(_deNumber), PhoneNumberType.fixedLine);
    });

    test('testIsFixedLineAndMobile', () {
      expect(phoneUtil.getNumberType(_usNumber),
          PhoneNumberType.fixedLineOrMobile);

      final fixedLineAndMobileNumber = PhoneNumber()
        ..countryCode = 54
        ..nationalNumber = Int64(1987654321);
      expect(phoneUtil.getNumberType(fixedLineAndMobileNumber),
          PhoneNumberType.fixedLineOrMobile);
    });

    test('testIsSharedCost', () {
      final gbNumber = PhoneNumber()
        ..countryCode = 44
        ..nationalNumber = Int64(8431231234);
      expect(phoneUtil.getNumberType(gbNumber), PhoneNumberType.sharedCost);
    });

    test('testIsVoip', () {
      final gbNumber = PhoneNumber()
        ..countryCode = 44
        ..nationalNumber = Int64(5631231234);
      expect(phoneUtil.getNumberType(gbNumber), PhoneNumberType.voip);
    });

    test('testIsPersonalNumber', () {
      final gbNumber = PhoneNumber()
        ..countryCode = 44
        ..nationalNumber = Int64(7031231234);
      expect(phoneUtil.getNumberType(gbNumber), PhoneNumberType.personalNumber);
    });

    test('testIsUnknown', () {
      // Invalid numbers should be of type UNKNOWN.
      expect(phoneUtil.getNumberType(_usLocalNumber), PhoneNumberType.unknown);
    });

    test('testIsValidNumber', () {
      expect(phoneUtil.isValidNumber(_usNumber), true);
      expect(phoneUtil.isValidNumber(_itNumber), true);
      expect(phoneUtil.isValidNumber(_gbMobile), true);
      expect(phoneUtil.isValidNumber(_internationalTollFree), true);
      expect(phoneUtil.isValidNumber(_universalPremiumRate), true);

      final nzNumber = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(21387835);
      expect(phoneUtil.isValidNumber(nzNumber), true);
    });

    test('testIsValidForRegion', () {
      // This number is valid for the Bahamas, but is not a valid US number.
      expect(phoneUtil.isValidNumber(_bsNumber), true);
      expect(phoneUtil.isValidNumberForRegion(_bsNumber, 'BS'), true);
      expect(phoneUtil.isValidNumberForRegion(_bsNumber, 'US'), false);

      final bsInvalidNumber = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(2421232345);
      // This number is no longer valid.
      expect(phoneUtil.isValidNumber(bsInvalidNumber), false);

      // La Mayotte and Reunion use 'leadingDigits' to differentiate them.
      final reNumber = PhoneNumber()
        ..countryCode = 262
        ..nationalNumber = Int64(262123456);
      expect(phoneUtil.isValidNumber(reNumber), true);
      expect(phoneUtil.isValidNumberForRegion(reNumber, 'RE'), true);
      expect(phoneUtil.isValidNumberForRegion(reNumber, 'YT'), false);
      // Now change the number to be a number for La Mayotte.
      reNumber.nationalNumber = Int64(269601234);
      expect(phoneUtil.isValidNumberForRegion(reNumber, 'YT'), true);
      expect(phoneUtil.isValidNumberForRegion(reNumber, 'RE'), false);
      // This number is no longer valid for La Reunion.
      reNumber.nationalNumber = Int64(269123456);
      expect(phoneUtil.isValidNumberForRegion(reNumber, 'YT'), false);
      expect(phoneUtil.isValidNumberForRegion(reNumber, 'RE'), false);
      expect(phoneUtil.isValidNumber(reNumber), false);
      // However, it should be recognised as from La Mayotte, since it is valid for
      // this region.
      expect(phoneUtil.getRegionCodeForNumber(reNumber), 'YT');
      // This number is valid in both places.
      reNumber.nationalNumber = Int64(800123456);
      expect(phoneUtil.isValidNumberForRegion(reNumber, 'YT'), true);
      expect(phoneUtil.isValidNumberForRegion(reNumber, 'RE'), true);
      expect(phoneUtil.isValidNumberForRegion(_internationalTollFree, '001'),
          true);
      expect(phoneUtil.isValidNumberForRegion(_internationalTollFree, 'US'),
          false);
      expect(phoneUtil.isValidNumberForRegion(_internationalTollFree, 'ZZ'),
          false);

      final invalidNumber = PhoneNumber();
      // Invalid country calling codes.
      invalidNumber.countryCode = 3923;
      invalidNumber.nationalNumber = Int64(2366);
      expect(phoneUtil.isValidNumberForRegion(invalidNumber, 'ZZ'), false);
      expect(phoneUtil.isValidNumberForRegion(invalidNumber, '001'), false);
      invalidNumber.countryCode = 0;
      expect(phoneUtil.isValidNumberForRegion(invalidNumber, '001'), false);
      expect(phoneUtil.isValidNumberForRegion(invalidNumber, 'ZZ'), false);
    });

    test('testIsNotValidNumber', () {
      expect(phoneUtil.isValidNumber(_usLocalNumber), false);

      var invalidNumber = PhoneNumber()
        ..countryCode = 39
        ..nationalNumber = Int64(23661830000)
        ..italianLeadingZero;
      expect(phoneUtil.isValidNumber(invalidNumber), false);

      invalidNumber = PhoneNumber()
        ..countryCode = 44
        ..nationalNumber = Int64(791234567);
      expect(phoneUtil.isValidNumber(invalidNumber), false);

      invalidNumber = PhoneNumber()
        ..countryCode = 49
        ..nationalNumber = Int64(1234);
      expect(phoneUtil.isValidNumber(invalidNumber), false);

      invalidNumber = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(3316005);
      expect(phoneUtil.isValidNumber(invalidNumber), false);

      // Invalid country calling codes.
      invalidNumber = PhoneNumber()
        ..countryCode = 3923
        ..nationalNumber = Int64(2366);

      expect(phoneUtil.isValidNumber(invalidNumber), false);
      invalidNumber.countryCode = 0;
      expect(phoneUtil.isValidNumber(invalidNumber), false);

      expect(phoneUtil.isValidNumber(_internationalTollFreeTooLong), false);
    });

    test('testGetRegionCodeForCountryCode', () {
      expect(phoneUtil.getRegionCodeForCountryCode(1), 'US');
      expect(phoneUtil.getRegionCodeForCountryCode(44), 'GB');
      expect(phoneUtil.getRegionCodeForCountryCode(49), 'DE');
      expect(phoneUtil.getRegionCodeForCountryCode(800), '001');
      expect(phoneUtil.getRegionCodeForCountryCode(979), '001');
    });

    test('testGetRegionCodeForNumber', () {
      expect(phoneUtil.getRegionCodeForNumber(_bsNumber), 'BS');
      expect(phoneUtil.getRegionCodeForNumber(_usNumber), 'US');
      expect(phoneUtil.getRegionCodeForNumber(_gbMobile), 'GB');
      expect(phoneUtil.getRegionCodeForNumber(_internationalTollFree), '001');
      expect(phoneUtil.getRegionCodeForNumber(_universalPremiumRate), '001');
    });

    test('testGetRegionCodesForCountryCode', () {
      List<String> regionCodesForNANPA =
          phoneUtil.getRegionCodesForCountryCode(1);
      expect(regionCodesForNANPA.contains('US'), true);
      expect(regionCodesForNANPA.contains('BS'), true);
      expect(phoneUtil.getRegionCodesForCountryCode(44).contains('GB'), true);
      expect(phoneUtil.getRegionCodesForCountryCode(49).contains('DE'), true);
      expect(phoneUtil.getRegionCodesForCountryCode(800).contains('001'), true);
      // Test with invalid country calling code.
      expect((phoneUtil.getRegionCodesForCountryCode(-1).isEmpty), true);
    });

    test('testGetCountryCodeForRegion', () {
      expect(phoneUtil.getCountryCodeForRegion('US'), 1);
      expect(phoneUtil.getCountryCodeForRegion('NZ'), 64);
      expect(phoneUtil.getCountryCodeForRegion(null), 0);
      expect(phoneUtil.getCountryCodeForRegion('ZZ'), 0);
      expect(phoneUtil.getCountryCodeForRegion('001'), 0);
      // CS is already deprecated so the library doesn't support it.
      expect(phoneUtil.getCountryCodeForRegion('CS'), 0);
    });

    test('testGetNationalDiallingPrefixForRegion', () {
      expect(phoneUtil.getNddPrefixForRegion('US', false), '1');
      // Test non-main country to see it gets the national dialling prefix for the
      // main country with that country calling code.
      expect(phoneUtil.getNddPrefixForRegion('BS', false), '1');
      expect(phoneUtil.getNddPrefixForRegion('NZ', false), '0');
      // Test case with non digit in the national prefix.
      expect(phoneUtil.getNddPrefixForRegion('AO', false), '0~0');
      expect(phoneUtil.getNddPrefixForRegion('AO', true), '00');
      // Test cases with invalid regions.
      expect(phoneUtil.getNddPrefixForRegion(null, false), isNull);
      expect(phoneUtil.getNddPrefixForRegion('ZZ', false), isNull);
      expect(phoneUtil.getNddPrefixForRegion('001', false), isNull);
      // CS is already deprecated so the library doesn't support it.
      expect(phoneUtil.getNddPrefixForRegion('CS', false), isNull);
    });

    test('testIsNANPACountry', () {
      expect(phoneUtil.isNANPACountry('US'), true);
      expect(phoneUtil.isNANPACountry('BS'), true);
      expect(phoneUtil.isNANPACountry('DE'), false);
      expect(phoneUtil.isNANPACountry('ZZ'), false);
      expect(phoneUtil.isNANPACountry('001'), false);
      expect(phoneUtil.isNANPACountry(null), false);
    });

    test('testIsPossibleNumber', () {
      expect(phoneUtil.isPossibleNumber(_usNumber), true);
      expect(phoneUtil.isPossibleNumber(_usLocalNumber), true);
      expect(phoneUtil.isPossibleNumber(_gbNumber), true);
      expect(phoneUtil.isPossibleNumber(_internationalTollFree), true);

      expect(phoneUtil.isPossibleNumberString('+1 650 253 0000', 'US'), true);
      expect(phoneUtil.isPossibleNumberString('+1 650 GOO OGLE', 'US'), true);
      expect(phoneUtil.isPossibleNumberString('(650) 253-0000', 'US'), true);
      expect(phoneUtil.isPossibleNumberString('253-0000', 'US'), true);
      expect(phoneUtil.isPossibleNumberString('+1 650 253 0000', 'GB'), true);
      expect(phoneUtil.isPossibleNumberString('+44 20 7031 3000', 'GB'), true);
      expect(phoneUtil.isPossibleNumberString('(020) 7031 3000', 'GB'), true);
      expect(phoneUtil.isPossibleNumberString('7031 3000', 'GB'), true);
      expect(phoneUtil.isPossibleNumberString('3331 6005', 'NZ'), true);
      expect(phoneUtil.isPossibleNumberString('+800 1234 5678', '001'), true);
    });

    test('testIsPossibleNumberForType_DifferentTypeLengths', () {
      // We use Argentinian numbers since they have different possible lengths for
      // different types.
      final number = PhoneNumber()
        ..countryCode = 54
        ..nationalNumber = Int64(12345);
      // Too short for any Argentinian number, including fixed-line.
      expect(
          phoneUtil.isPossibleNumberForType(number, PhoneNumberType.fixedLine),
          false);
      expect(phoneUtil.isPossibleNumberForType(number, PhoneNumberType.unknown),
          false);

      // 6-digit numbers are okay for fixed-line.
      number.nationalNumber = Int64(123456);
      expect(phoneUtil.isPossibleNumberForType(number, PhoneNumberType.unknown),
          true);
      expect(
          phoneUtil.isPossibleNumberForType(number, PhoneNumberType.fixedLine),
          true);
      // But too short for mobile.
      expect(phoneUtil.isPossibleNumberForType(number, PhoneNumberType.mobile),
          false);
      // And too short for toll-free.
      expect(
          phoneUtil.isPossibleNumberForType(number, PhoneNumberType.tollFree),
          false);

      // The same applies to 9-digit numbers.
      number.nationalNumber = Int64(123456789);
      expect(phoneUtil.isPossibleNumberForType(number, PhoneNumberType.unknown),
          true);
      expect(
          phoneUtil.isPossibleNumberForType(number, PhoneNumberType.fixedLine),
          true);
      expect(phoneUtil.isPossibleNumberForType(number, PhoneNumberType.mobile),
          false);
      expect(
          phoneUtil.isPossibleNumberForType(number, PhoneNumberType.tollFree),
          false);

      // 10-digit numbers are universally possible.
      number.nationalNumber = Int64(1234567890);
      expect(phoneUtil.isPossibleNumberForType(number, PhoneNumberType.unknown),
          true);
      expect(
          phoneUtil.isPossibleNumberForType(number, PhoneNumberType.fixedLine),
          true);
      expect(phoneUtil.isPossibleNumberForType(number, PhoneNumberType.mobile),
          true);
      expect(
          phoneUtil.isPossibleNumberForType(number, PhoneNumberType.tollFree),
          true);

      // 11-digit numbers are only possible for mobile numbers. Note we don't
      // require the leading 9, which all mobile numbers start with, and would be
      // required for a valid mobile number.
      number.nationalNumber = Int64(12345678901);
      expect(phoneUtil.isPossibleNumberForType(number, PhoneNumberType.unknown),
          true);
      expect(
          phoneUtil.isPossibleNumberForType(number, PhoneNumberType.fixedLine),
          false);
      expect(phoneUtil.isPossibleNumberForType(number, PhoneNumberType.mobile),
          true);
      expect(
          phoneUtil.isPossibleNumberForType(number, PhoneNumberType.tollFree),
          false);
    });

    test('testIsPossibleNumberForType_LocalOnly', () {
      final number = PhoneNumber()
        ..countryCode = 49
        ..nationalNumber = Int64(12);
      // Here we test a number length which matches a local-only length.
      expect(phoneUtil.isPossibleNumberForType(number, PhoneNumberType.unknown),
          true);
      expect(
          phoneUtil.isPossibleNumberForType(number, PhoneNumberType.fixedLine),
          true);
      // Mobile numbers must be 10 or 11 digits, and there are no local-only lengths.
      expect(phoneUtil.isPossibleNumberForType(number, PhoneNumberType.mobile),
          false);
    });

    test('testIsPossibleNumberForType_DataMissingForSizeReasons', () {
      final number = PhoneNumber()
        ..countryCode = 55
        ..nationalNumber = Int64(12345678);
      // Here we test something where the possible lengths match the possible
      // lengths of the country as a whole, and hence aren't present in the .js file
      // for size reasons - this should still work.
      // Local-only number.
      expect(phoneUtil.isPossibleNumberForType(number, PhoneNumberType.unknown),
          true);
      expect(
          phoneUtil.isPossibleNumberForType(number, PhoneNumberType.fixedLine),
          true);
      number.nationalNumber = Int64(1234567890);
      expect(phoneUtil.isPossibleNumberForType(number, PhoneNumberType.unknown),
          true);
      expect(
          phoneUtil.isPossibleNumberForType(number, PhoneNumberType.fixedLine),
          true);
    });

    test('testIsPossibleNumberForType_NumberTypeNotSupportedForRegion', () {
      final number = PhoneNumber()
        ..countryCode = 55
        ..nationalNumber = Int64(12345678);
      // There are *no* mobile numbers for this region at all, so we return false.
      expect(phoneUtil.isPossibleNumberForType(number, PhoneNumberType.mobile),
          false);
      // This matches a fixed-line length though.
      expect(
          phoneUtil.isPossibleNumberForType(number, PhoneNumberType.fixedLine),
          true);
      expect(
          phoneUtil.isPossibleNumberForType(
              number, PhoneNumberType.fixedLineOrMobile),
          true);

      // There are *no* fixed-line OR mobile numbers for this country calling code
      // at all, so we return false for these.
      number
        ..countryCode = 979
        ..nationalNumber = Int64(123456789);
      expect(phoneUtil.isPossibleNumberForType(number, PhoneNumberType.mobile),
          false);
      expect(
          phoneUtil.isPossibleNumberForType(number, PhoneNumberType.fixedLine),
          false);
      expect(
          phoneUtil.isPossibleNumberForType(
              number, PhoneNumberType.fixedLineOrMobile),
          false);
      expect(
          phoneUtil.isPossibleNumberForType(
              number, PhoneNumberType.premiumRate),
          true);
    });

    test('testIsPossibleNumberWithReason', () {
      // National numbers for country calling code +1 that are within 7 to 10 digits
      // are possible.
      expect(phoneUtil.isPossibleNumberWithReason(_usNumber),
          ValidationResult.isPossible);
      expect(phoneUtil.isPossibleNumberWithReason(_usLocalNumber),
          ValidationResult.isPossibleLocalOnly);
      expect(phoneUtil.isPossibleNumberWithReason(_usLongNumber),
          ValidationResult.tooLong);

      var number = PhoneNumber()
        ..countryCode = 0
        ..nationalNumber = Int64(2530000);
      expect(phoneUtil.isPossibleNumberWithReason(number),
          ValidationResult.invalidCountryCode);

      number = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(253000);
      expect(ValidationResult.tooShort,
          phoneUtil.isPossibleNumberWithReason(number));

      number = PhoneNumber()
        ..countryCode = 65
        ..nationalNumber = Int64(1234567890);
      expect(phoneUtil.isPossibleNumberWithReason(number),
          ValidationResult.isPossible);
      expect(
          phoneUtil.isPossibleNumberWithReason(_internationalTollFreeTooLong),
          ValidationResult.tooLong);
    });

    test('testIsPossibleNumberForTypeWithReason_DifferentTypeLengths', () {
      final number = PhoneNumber()
        ..countryCode = 54
        ..nationalNumber = Int64(12345);
      // We use Argentinian numbers since they have different possible lengths for
      // different types.
      // Too short for any Argentinian number.
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.unknown),
          ValidationResult.tooShort);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLine),
          ValidationResult.tooShort);

      // 6-digit numbers are okay for fixed-line.
      number.nationalNumber = Int64(123456);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.unknown),
          ValidationResult.isPossible);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLine),
          ValidationResult.isPossible);
      // But too short for mobile.
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.mobile),
          ValidationResult.tooShort);
      // And too short for toll-free.
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.tollFree),
          ValidationResult.tooShort);

      // The same applies to 9-digit numbers.
      number.nationalNumber = Int64(123456789);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.unknown),
          ValidationResult.isPossible);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLine),
          ValidationResult.isPossible);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.mobile),
          ValidationResult.tooShort);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.tollFree),
          ValidationResult.tooShort);

      // 10-digit numbers are universally possible.
      number.nationalNumber = Int64(1234567890);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.unknown),
          ValidationResult.isPossible);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLine),
          ValidationResult.isPossible);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.mobile),
          ValidationResult.isPossible);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.tollFree),
          ValidationResult.isPossible);

      // 11-digit numbers are only possible for mobile numbers. Note we don't
      // require the leading 9, which all mobile numbers start with, and would be
      // required for a valid mobile number.
      number.nationalNumber = Int64(12345678901);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.unknown),
          ValidationResult.isPossible);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLine),
          ValidationResult.tooLong);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.mobile),
          ValidationResult.isPossible);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.tollFree),
          ValidationResult.tooLong);
    });

    test('testIsPossibleNumberForTypeWithReason_LocalOnly', () {
      final number = PhoneNumber()
        ..countryCode = 49
        ..nationalNumber = Int64(12);
      // Here we test a number length which matches a local-only length.
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.unknown),
          ValidationResult.isPossibleLocalOnly);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLine),
          ValidationResult.isPossibleLocalOnly);
      // Mobile numbers must be 10 or 11 digits, and there are no local-only
      // lengths.
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.mobile),
          ValidationResult.tooShort);
    });

    test('testIsPossibleNumberForTypeWithReason_DataMissingForSizeReasons', () {
      final number = PhoneNumber()
        ..countryCode = 55
        ..nationalNumber = Int64(12345678);
      // Here we test something where the possible lengths match the possible
      // lengths of the country as a whole, and hence aren't present in the binary
      // for size reasons - this should still work.
      // Local-only number.
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.unknown),
          ValidationResult.isPossibleLocalOnly);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLine),
          ValidationResult.isPossibleLocalOnly);

      // Normal-length number.
      number.nationalNumber = Int64(1234567890);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.unknown),
          ValidationResult.isPossible);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLine),
          ValidationResult.isPossible);
    });

    test(
        'testIsPossibleNumberForTypeWithReason_NumberTypeNotSupportedForRegion',
        () {
      final number = PhoneNumber()
        ..countryCode = 55
        ..nationalNumber = Int64(12345678);
      // There are *no* mobile numbers for this region at all, so we return
      // INVALID_LENGTH.
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.mobile),
          ValidationResult.invalidLength);
      // This matches a fixed-line length though.
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLineOrMobile),
          ValidationResult.isPossibleLocalOnly);
      // This is too short for fixed-line, and no mobile numbers exist.
      number.countryCode = 55;
      number.nationalNumber = Int64(1234567);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.mobile),
          ValidationResult.invalidLength);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLineOrMobile),
          ValidationResult.tooShort);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLine),
          ValidationResult.tooShort);

      // This is too short for mobile, and no fixed-line numbers exist.
      number.countryCode = 882;
      number.nationalNumber = Int64(1234567);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.mobile),
          ValidationResult.tooShort);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLineOrMobile),
          ValidationResult.tooShort);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLine),
          ValidationResult.invalidLength);

      // There are *no* fixed-line OR mobile numbers for this country calling code
      // at all, so we return INVALID_LENGTH.
      number.countryCode = 979;
      number.nationalNumber = Int64(123456789);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.mobile),
          ValidationResult.invalidLength);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLine),
          ValidationResult.invalidLength);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLineOrMobile),
          ValidationResult.invalidLength);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.premiumRate),
          ValidationResult.isPossible);
    });

    test('testIsPossibleNumberForTypeWithReason_FixedLineOrMobile', () {
      final number = PhoneNumber()
        ..countryCode = 290
        ..nationalNumber = Int64(1234);
      // For FIXED_LINE_OR_MOBILE, a number should be considered valid if it matches
      // the possible lengths for mobile *or* fixed-line numbers.
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLine),
          ValidationResult.tooShort);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.mobile),
          ValidationResult.isPossible);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLineOrMobile),
          ValidationResult.isPossible);

      number.nationalNumber = Int64(12345);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLine),
          ValidationResult.tooShort);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.mobile),
          ValidationResult.tooLong);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLineOrMobile),
          ValidationResult.invalidLength);

      number.nationalNumber = Int64(123456);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLine),
          ValidationResult.isPossible);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.mobile),
          ValidationResult.tooLong);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLineOrMobile),
          ValidationResult.isPossible);

      number.nationalNumber = Int64(1234567);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLine),
          ValidationResult.tooLong);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.mobile),
          ValidationResult.tooLong);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLineOrMobile),
          ValidationResult.tooLong);

      // 8-digit numbers are possible for toll-free and premium-rate numbers only.
      number.nationalNumber = Int64(12345678);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.tollFree),
          ValidationResult.isPossible);
      expect(
          phoneUtil.isPossibleNumberForTypeWithReason(
              number, PhoneNumberType.fixedLineOrMobile),
          ValidationResult.tooLong);
    });

    test('testIsNotPossibleNumber', () {
      expect(phoneUtil.isPossibleNumber(_usLongNumber), false);
      expect(phoneUtil.isPossibleNumber(_internationalTollFreeTooLong), false);

      var number = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(253000);
      expect(phoneUtil.isPossibleNumber(number), false);

      number = PhoneNumber()
        ..countryCode = 44
        ..nationalNumber = Int64(300);
      expect(phoneUtil.isPossibleNumber(number), false);
      expect(phoneUtil.isPossibleNumberString('+1 650 253 00000', 'US'), false);
      expect(phoneUtil.isPossibleNumberString('(650) 253-00000', 'US'), false);
      expect(phoneUtil.isPossibleNumberString('I want a Pizza', 'US'), false);
      expect(phoneUtil.isPossibleNumberString('253-000', 'US'), false);
      expect(phoneUtil.isPossibleNumberString('1 3000', 'GB'), false);
      expect(phoneUtil.isPossibleNumberString('+44 300', 'GB'), false);
      expect(
          phoneUtil.isPossibleNumberString('+800 1234 5678 9', '001'), false);
    });

    test('testTruncateTooLongNumber', () {
      // GB number 080 1234 5678, but entered with 4 extra digits at the end.
      var tooLongNumber = PhoneNumber()
        ..countryCode = 44
        ..nationalNumber = Int64(80123456780123);

      var validNumber = PhoneNumber()
        ..countryCode = 44
        ..nationalNumber = Int64(8012345678);
      expect(phoneUtil.truncateTooLongNumber(tooLongNumber), true);
      expect(tooLongNumber, validNumber);

      // IT number 022 3456 7890, but entered with 3 extra digits at the end.
      tooLongNumber = PhoneNumber()
        ..countryCode = 39
        ..nationalNumber = Int64(2234567890123)
        ..italianLeadingZero = true;

      validNumber = PhoneNumber()
        ..countryCode = 39
        ..nationalNumber = Int64(2234567890)
        ..italianLeadingZero = true;
      expect(phoneUtil.truncateTooLongNumber(tooLongNumber), true);
      expect(tooLongNumber, validNumber);

      // US number 650-253-0000, but entered with one additional digit at the end.
      tooLongNumber = _usLongNumber.deepCopy();
      expect(phoneUtil.truncateTooLongNumber(tooLongNumber), true);
      expect(tooLongNumber, _usNumber);

      tooLongNumber = _internationalTollFreeTooLong.deepCopy();
      expect(phoneUtil.truncateTooLongNumber(tooLongNumber), true);
      expect(tooLongNumber, _internationalTollFree);

      // Tests what happens when a valid number is passed in.
      final validNumberCopy = validNumber.deepCopy();
      expect(phoneUtil.truncateTooLongNumber(validNumber), true);
      // Tests the number is not modified.
      expect(validNumberCopy, validNumber);

      // Tests what happens when a number with invalid prefix is passed in.
      final numberWithInvalidPrefix = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(2401234567);
      // The test metadata says US numbers cannot have prefix 240.
      final invalidNumberCopy = numberWithInvalidPrefix.deepCopy();
      expect(phoneUtil.truncateTooLongNumber(numberWithInvalidPrefix), false);
      // Tests the number is not modified.
      expect(invalidNumberCopy, numberWithInvalidPrefix);

      // Tests what happens when a too short number is passed in.
      final tooShortNumber = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(1234);

      final tooShortNumberCopy = tooShortNumber.deepCopy();
      expect(phoneUtil.truncateTooLongNumber(tooShortNumber), false);
      // Tests the number is not modified.
      expect(tooShortNumberCopy, tooShortNumber);
    });

    test('testIsViablePhoneNumber', () {
      expect(phoneUtil.isViablePhoneNumber('1'), false);
      // Only one or two digits before strange non-possible punctuation.
      expect(phoneUtil.isViablePhoneNumber('1+1+1'), false);
      expect(phoneUtil.isViablePhoneNumber('80+0'), false);
      // Two digits is viable.
      expect(phoneUtil.isViablePhoneNumber('00'), true);
      expect(phoneUtil.isViablePhoneNumber('111'), true);
      // Alpha numbers.
      expect(phoneUtil.isViablePhoneNumber('0800-4-pizza'), true);
      expect(phoneUtil.isViablePhoneNumber('0800-4-PIZZA'), true);
      // We need at least three digits before any alpha characters.
      expect(phoneUtil.isViablePhoneNumber('08-PIZZA'), false);
      expect(phoneUtil.isViablePhoneNumber('8-PIZZA'), false);
      expect(phoneUtil.isViablePhoneNumber('12. March'), false);
    });

    test('testIsViablePhoneNumberNonAscii', () {
      // Only one or two digits before possible punctuation followed by more digits.
      expect(phoneUtil.isViablePhoneNumber('1\u300034'), true);
      expect(phoneUtil.isViablePhoneNumber('1\u30003+4'), false);
      // Unicode variants of possible starting character and other allowed
      // punctuation/digits.
      expect(phoneUtil.isViablePhoneNumber('\uFF081\uFF09\u30003456789'), true);
      // Testing a leading + is okay.
      expect(phoneUtil.isViablePhoneNumber('+1\uFF09\u30003456789'), true);
    });

    test('testExtractPossibleNumber', () {
      // Removes preceding funky punctuation and letters but leaves the rest
      // untouched.
      expect(PhoneNumberUtil.extractPossibleNumber('Tel:0800-345-600'),
          '0800-345-600');
      expect(PhoneNumberUtil.extractPossibleNumber('Tel:0800 FOR PIZZA'),
          '0800 FOR PIZZA');
      // Should not remove plus sign
      expect(PhoneNumberUtil.extractPossibleNumber('Tel:+800-345-600'),
          '+800-345-600');
      // Should recognise wide digits as possible start values.
      expect(PhoneNumberUtil.extractPossibleNumber('\uFF10\uFF12\uFF13'),
          '\uFF10\uFF12\uFF13');
      // Dashes are not possible start values and should be removed.
      expect(PhoneNumberUtil.extractPossibleNumber('Num-\uFF11\uFF12\uFF13'),
          '\uFF11\uFF12\uFF13');
      // If not possible number present, return empty string.
      expect(PhoneNumberUtil.extractPossibleNumber('Num-....'), '');
      // Leading brackets are stripped - these are not used when parsing.
      expect(PhoneNumberUtil.extractPossibleNumber('(650) 253-0000'),
          '650) 253-0000');

      // Trailing non-alpha-numeric characters should be removed.
      expect(PhoneNumberUtil.extractPossibleNumber('(650) 253-0000..- ..'),
          '650) 253-0000');
      expect(PhoneNumberUtil.extractPossibleNumber('(650) 253-0000.'),
          '650) 253-0000');
      // This case has a trailing RTL char.
      expect(PhoneNumberUtil.extractPossibleNumber('(650) 253-0000\u200F'),
          '650) 253-0000');
    });

    test('testMaybeStripNationalPrefix', () {
      final metadata = PhoneMetadata()..nationalPrefixForParsing = '34';
      final generalDesc = PhoneNumberDesc()..nationalNumberPattern = '\\d{4,8}';
      metadata.generalDesc = generalDesc;
      var numberToStrip = StringBuffer('34356778');

      String strippedNumber = '356778';
      expect(
          phoneUtil.maybeStripNationalPrefixAndCarrierCode(
              numberToStrip, metadata, null),
          true);
      expect(
        numberToStrip.toString(),
        strippedNumber,
        reason: 'Should have had national prefix stripped.',
      );

      // Retry stripping - now the number should not start with the national prefix,
      // so no more stripping should occur.
      expect(
          phoneUtil.maybeStripNationalPrefixAndCarrierCode(
              numberToStrip, metadata, null),
          false);
      expect(numberToStrip.toString(), strippedNumber,
          reason: 'Should have had no change - no national prefix present.');

      // Some countries have no national prefix. Repeat test with none specified.
      metadata.nationalPrefixForParsing = '';
      expect(
          phoneUtil.maybeStripNationalPrefixAndCarrierCode(
              numberToStrip, metadata, null),
          false);
      expect(
        numberToStrip.toString(),
        strippedNumber,
        reason: 'Should not strip anything with empty national prefix.',
      );

      // If the resultant number doesn't match the national rule, it shouldn't be
      // stripped.
      metadata.nationalPrefixForParsing = '3';
      numberToStrip = StringBuffer('3123');
      strippedNumber = '3123';
      expect(
          phoneUtil.maybeStripNationalPrefixAndCarrierCode(
              numberToStrip, metadata, null),
          false);
      expect(
        numberToStrip.toString(),
        strippedNumber,
        reason:
            'Should have had no change - after stripping, it would not have matched the national rule.',
      );

      // Test extracting carrier selection code.
      metadata.nationalPrefixForParsing = '0(81)?';
      numberToStrip = StringBuffer('08122123456');
      strippedNumber = '22123456';

      final carrierCode = StringBuffer();
      expect(
          phoneUtil.maybeStripNationalPrefixAndCarrierCode(
              numberToStrip, metadata, carrierCode),
          true);
      expect(carrierCode.toString(), '81');
      expect(
        numberToStrip.toString(),
        strippedNumber,
        reason: 'Should have had national prefix and carrier code stripped.',
      );

      // If there was a transform rule, check it was applied.
      metadata.nationalPrefixTransformRule = r'5$15';

      // Note that a capturing group is present here.
      metadata.nationalPrefixForParsing = '0(\\d{2})';
      numberToStrip = StringBuffer('031123');
      final transformedNumber = '5315123';
      expect(
          phoneUtil.maybeStripNationalPrefixAndCarrierCode(
              numberToStrip, metadata, null),
          true);
      expect(numberToStrip.toString(), transformedNumber,
          reason: 'Should transform the 031 to a 5315.');
    });

    test('testMaybeStripInternationalPrefix', () {
      final internationalPrefix = '00[39]';
      var numberToStrip = StringBuffer('0034567700-3898003');
      // Note the dash is removed as part of the normalization.
      var strippedNumber = StringBuffer('45677003898003');
      expect(
        phoneUtil.maybeStripInternationalPrefixAndNormalize(
            numberToStrip, internationalPrefix),
        PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_IDD,
      );
      expect(
        numberToStrip.toString(),
        strippedNumber.toString(),
        reason:
            'The number supplied was not stripped of its international prefix.',
      );
      // Now the number no longer starts with an IDD prefix, so it should now report
      // FROM_DEFAULT_COUNTRY.
      expect(
        phoneUtil.maybeStripInternationalPrefixAndNormalize(
            numberToStrip, internationalPrefix),
        PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY,
      );

      numberToStrip = StringBuffer('00945677003898003');
      expect(
        phoneUtil.maybeStripInternationalPrefixAndNormalize(
            numberToStrip, internationalPrefix),
        PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_IDD,
      );
      expect(
        numberToStrip.toString(),
        strippedNumber.toString(),
        reason:
            'The number supplied was not stripped of its international prefix.',
      );
      // Test it works when the international prefix is broken up by spaces.
      numberToStrip = StringBuffer('00 9 45677003898003');
      expect(
        phoneUtil.maybeStripInternationalPrefixAndNormalize(
            numberToStrip, internationalPrefix),
        PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_IDD,
      );
      expect(
        numberToStrip.toString(),
        strippedNumber.toString(),
        reason:
            'The number supplied was not stripped of its international prefix.',
      );
      // Now the number no longer starts with an IDD prefix, so it should now report
      // FROM_DEFAULT_COUNTRY.
      expect(
        phoneUtil.maybeStripInternationalPrefixAndNormalize(
            numberToStrip, internationalPrefix),
        PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY,
      );

      // Test the + symbol is also recognised and stripped.
      numberToStrip = StringBuffer('+45677003898003');
      strippedNumber = StringBuffer('45677003898003');
      expect(
        phoneUtil.maybeStripInternationalPrefixAndNormalize(
            numberToStrip, internationalPrefix),
        PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN,
      );
      expect(
        numberToStrip.toString(),
        strippedNumber.toString(),
        reason: 'The number supplied was not stripped of the plus symbol.',
      );

      // If the number afterwards is a zero, we should not strip this - no country
      // calling code begins with 0.
      numberToStrip = StringBuffer('0090112-3123');
      strippedNumber = StringBuffer('00901123123');
      expect(
        phoneUtil.maybeStripInternationalPrefixAndNormalize(
            numberToStrip, internationalPrefix),
        PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY,
      );
      expect(
        numberToStrip.toString(),
        strippedNumber.toString(),
        reason:
            'The number supplied had a 0 after the match so should not be stripped.',
      );
      // Here the 0 is separated by a space from the IDD.
      numberToStrip = StringBuffer('009 0-112-3123');
      expect(
        phoneUtil.maybeStripInternationalPrefixAndNormalize(
            numberToStrip, internationalPrefix),
        PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY,
      );
    });

    test('testMaybeExtractCountryCode', () {
      var number = PhoneNumber();
      var phoneNumber = '011112-3456789';
      int countryCallingCode = 1;
      var numberToFill = StringBuffer();
      PhoneMetadata? metadata =
          phoneUtil.getMetadataForRegion(regionCode: 'US');

      // Note that for the US, the IDD is 011.
      try {
        final strippedNumber = '123456789';
        expect(
          phoneUtil.maybeExtractCountryCode(
              phoneNumber, metadata, numberToFill, true, number),
          countryCallingCode,
          reason:
              'Did not extract country calling code $countryCallingCode correctly.',
        );
        expect(
          number.countryCodeSource,
          PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_IDD,
          reason: 'Did not figure out CountryCodeSource correctly',
        );
        // Should strip and normalize national significant number.
        expect(
          numberToFill.toString(),
          strippedNumber,
          reason: 'Did not strip off the country calling code correctly.',
        );
      } catch (e) {
        fail('Should not have thrown an exception: $e');
      }

      number = PhoneNumber();
      try {
        phoneNumber = '+6423456789';
        countryCallingCode = 64;
        numberToFill = StringBuffer();
        expect(
          phoneUtil.maybeExtractCountryCode(
              phoneNumber, metadata, numberToFill, true, number),
          countryCallingCode,
          reason:
              'Did not extract country calling code $countryCallingCode correctly.',
        );
        expect(
          number.countryCodeSource,
          PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN,
          reason: 'Did not figure out CountryCodeSource correctly',
        );
      } catch (e) {
        fail('Should not have thrown an exception: $e');
      }

      number = PhoneNumber();
      try {
        phoneNumber = '+80012345678';
        countryCallingCode = 800;
        numberToFill = StringBuffer();
        expect(
          phoneUtil.maybeExtractCountryCode(
              phoneNumber, metadata, numberToFill, true, number),
          countryCallingCode,
          reason:
              'Did not extract country calling code $countryCallingCode correctly.',
        );
        expect(
          number.countryCodeSource,
          PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN,
          reason: 'Did not figure out CountryCodeSource correctly',
        );
      } catch (e) {
        fail('Should not have thrown an exception: $e');
      }

      number = PhoneNumber();
      try {
        phoneNumber = '2345-6789';
        numberToFill = StringBuffer();
        expect(
          phoneUtil.maybeExtractCountryCode(
              phoneNumber, metadata, numberToFill, true, number),
          0,
          reason:
              'Should not have extracted a country calling code - no international prefix present.',
        );
        expect(
          number.countryCodeSource,
          PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY,
          reason: 'Did not figure out CountryCodeSource correctly',
        );
      } catch (e) {
        fail('Should not have thrown an exception: $e');
      }

      number = PhoneNumber();
      try {
        phoneNumber = '0119991123456789';
        numberToFill = StringBuffer();
        phoneUtil.maybeExtractCountryCode(
            phoneNumber, metadata, numberToFill, true, number);
        fail(
            'Should have thrown an exception, no valid country calling code present.');
      } on NumberParseException catch (e) {
        // Expected.
        expect(e.errorType, ErrorType.invalidCountryCode,
            reason: 'Wrong error type stored in exception.');
      }

      number = PhoneNumber();
      try {
        phoneNumber = '(1 610) 619 4466';
        countryCallingCode = 1;
        numberToFill = StringBuffer();
        expect(
          phoneUtil.maybeExtractCountryCode(
              phoneNumber, metadata, numberToFill, true, number),
          countryCallingCode,
          reason:
              'Should have extracted the country calling code of the region passed in',
        );
        expect(
          number.countryCodeSource,
          PhoneNumber_CountryCodeSource.FROM_NUMBER_WITHOUT_PLUS_SIGN,
          reason: 'Did not figure out CountryCodeSource correctly',
        );
      } catch (e) {
        fail('Should not have thrown an exception: $e');
      }

      number = PhoneNumber();
      try {
        phoneNumber = '(1 610) 619 4466';
        countryCallingCode = 1;
        numberToFill = StringBuffer();
        expect(
          phoneUtil.maybeExtractCountryCode(
              phoneNumber, metadata, numberToFill, false, number),
          countryCallingCode,
          reason:
              'Should have extracted the country calling code of the region passed in',
        );
        expect(
          number.hasCountryCodeSource(),
          false,
          reason: 'Should not contain CountryCodeSource.',
        );
      } catch (e) {
        fail('Should not have thrown an exception: $e');
      }

      number = PhoneNumber();
      try {
        phoneNumber = '(1 610) 619 446';
        numberToFill = StringBuffer();
        expect(
          phoneUtil.maybeExtractCountryCode(
              phoneNumber, metadata, numberToFill, false, number),
          0,
          reason: 'Should not have extracted a country calling code - invalid '
              'number after extraction of uncertain country calling code.',
        );
        expect(
          number.hasCountryCodeSource(),
          false,
          reason: 'Should not contain CountryCodeSource.',
        );
      } catch (e) {
        fail('Should not have thrown an exception: $e');
      }

      number = PhoneNumber();
      try {
        phoneNumber = '(1 610) 619';
        numberToFill = StringBuffer();
        expect(
          phoneUtil.maybeExtractCountryCode(
              phoneNumber, metadata, numberToFill, true, number),
          0,
          reason:
              'Should not have extracted a country calling code - too short number both '
              'before and after extraction of uncertain country calling code.',
        );
        expect(
          number.countryCodeSource,
          PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY,
          reason: 'Did not figure out CountryCodeSource correctly',
        );
      } catch (e) {
        fail('Should not have thrown an exception: $e');
      }
    });

    test('testParseNationalNumber', () {
      // National prefix attached.
      expect(phoneUtil.parse('033316005', 'NZ'), _nzNumber);
      // Some fields are not filled in by parse, but only by parseAndKeepRawInput.
      expect(_nzNumber.hasCountryCodeSource(), false);
      expect(_nzNumber.countryCodeSource,
          PhoneNumber_CountryCodeSource.UNSPECIFIED);

      expect(phoneUtil.parse('33316005', 'NZ'), _nzNumber);
      // National prefix attached and some formatting present.
      expect(phoneUtil.parse('03-331 6005', 'NZ'), _nzNumber);
      expect(phoneUtil.parse('03 331 6005', 'NZ'), _nzNumber);
      // Test parsing RFC3966 format with a phone context.
      expect(phoneUtil.parse('tel:03-331-6005;phone-context=+64', 'NZ'),
          _nzNumber);
      expect(
          phoneUtil.parse('tel:331-6005;phone-context=+64-3', 'NZ'), _nzNumber);
      expect(
          phoneUtil.parse('tel:331-6005;phone-context=+64-3', 'US'), _nzNumber);
      expect(
          phoneUtil.parse(
              'My number is tel:03-331-6005;phone-context=+64', 'NZ'),
          _nzNumber);
      // Test parsing RFC3966 format with optional user-defined parameters. The
      // parameters will appear after the context if present.
      expect(phoneUtil.parse('tel:03-331-6005;phone-context=+64;a=%A1', 'NZ'),
          _nzNumber);
      // Test parsing RFC3966 with an ISDN subaddress.
      expect(
          phoneUtil.parse('tel:03-331-6005;isub=12345;phone-context=+64', 'NZ'),
          _nzNumber);
      expect(phoneUtil.parse('tel:+64-3-331-6005;isub=12345', 'NZ'), _nzNumber);
      // Test parsing RFC3966 with "tel:" missing.
      expect(phoneUtil.parse('03-331-6005;phone-context=+64', 'NZ'), _nzNumber);
      // Testing international prefixes.
      // Should strip country calling code.
      expect(phoneUtil.parse('0064 3 331 6005', 'NZ'), _nzNumber);
      // Try again, but this time we have an international number with Region Code
      // US. It should recognise the country calling code and parse accordingly.
      expect(phoneUtil.parse('01164 3 331 6005', 'US'), _nzNumber);
      expect(phoneUtil.parse('+64 3 331 6005', 'US'), _nzNumber);
      // We should ignore the leading plus here, since it is not followed by a valid
      // country code but instead is followed by the IDD for the US.
      expect(phoneUtil.parse('+01164 3 331 6005', 'US'), _nzNumber);
      expect(phoneUtil.parse('+0064 3 331 6005', 'NZ'), _nzNumber);
      expect(phoneUtil.parse('+ 00 64 3 331 6005', 'NZ'), _nzNumber);

      expect(phoneUtil.parse('tel:253-0000;phone-context=www.google.com', 'US'),
          _usLocalNumber);
      expect(
          phoneUtil.parse(
              'tel:253-0000;isub=12345;phone-context=www.google.com', 'US'),
          _usLocalNumber);
      expect(
          phoneUtil.parse(
              'tel:2530000;isub=12345;phone-context=1234.com', 'US'),
          _usLocalNumber);

      final nzNumber = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(64123456);
      expect(phoneUtil.parse('64(0)64123456', 'NZ'), nzNumber);
      // Check that using a '/' is fine in a phone number.
      expect(phoneUtil.parse('301/23456', 'DE'), _deNumber);

      // Check it doesn't use the '1' as a country calling code when parsing if the
      // phone number was already possible.
      final usNumber = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(1234567890);
      expect(phoneUtil.parse('123-456-7890', 'US'), usNumber);

      // Test star numbers. Although this is not strictly valid, we would like to
      // make sure we can parse the output we produce when formatting the number.
      expect(phoneUtil.parse('+81 *2345', 'JP'), _jpStarNumber);

      final shortNumber = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(12);
      expect(phoneUtil.parse('12', 'NZ'), shortNumber);

      // Test for short-code with leading zero for a country which has 0 as
      // national prefix. Ensure it's not interpreted as national prefix if the
      // remaining number length is local-only in terms of length. Example: In GB,
      // length 6-7 are only possible local-only.
      shortNumber
        ..countryCode = 44
        ..nationalNumber = Int64(123456)
        ..italianLeadingZero = true;
      expect(phoneUtil.parse('0123456', 'GB'), shortNumber);
    });

    test('testParseNumberWithAlphaCharacters', () {
      // Test case with alpha characters.
      final tollfreeNumber = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(800332005);
      expect(phoneUtil.parse('0800 DDA 005', 'NZ'), tollfreeNumber);

      final premiumNumber = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(9003326005);
      expect(phoneUtil.parse('0900 DDA 6005', 'NZ'), premiumNumber);
      // Not enough alpha characters for them to be considered intentional, so they
      // are stripped.
      expect(phoneUtil.parse('0900 332 6005a', 'NZ'), premiumNumber);
      expect(phoneUtil.parse('0900 332 600a5', 'NZ'), premiumNumber);
      expect(phoneUtil.parse('0900 332 600A5', 'NZ'), premiumNumber);
      expect(phoneUtil.parse('0900 a332 600A5', 'NZ'), premiumNumber);
    });

    test('testParseMaliciousInput', () {
      // Lots of leading + signs before the possible number.
      final maliciousNumber = StringBuffer();
      for (int i = 0; i < 6000; i++) {
        maliciousNumber.write('+');
      }
      maliciousNumber.write('12222-33-244 extensioB 343+');
      try {
        phoneUtil.parse(maliciousNumber.toString(), 'US');
        fail(
            'This should not parse without throwing an exception $maliciousNumber');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.tooLong,
            reason: 'Wrong error type stored in exception.');
      }

      final maliciousNumberWithAlmostExt = StringBuffer();
      for (int i = 0; i < 350; i++) {
        maliciousNumberWithAlmostExt.write('200');
      }
      maliciousNumberWithAlmostExt.write(' extensiOB 345');
      try {
        phoneUtil.parse(maliciousNumberWithAlmostExt.toString(), 'US');
        fail(
            'This should not parse without throwing an exception $maliciousNumberWithAlmostExt');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.tooLong,
            reason: 'Wrong error type stored in exception.');
      }
    });

    test('testParseWithInternationalPrefixes', () {
      expect(phoneUtil.parse('+1 (650) 253-0000', 'NZ'), _usNumber);
      expect(
          phoneUtil.parse('011 800 1234 5678', 'US'), _internationalTollFree);
      expect(phoneUtil.parse('1-650-253-0000', 'US'), _usNumber);
      // Calling the US number from Singapore by using different service providers
      // 1st test: calling using SingTel IDD service (IDD is 001)
      expect(phoneUtil.parse('0011-650-253-0000', 'SG'), _usNumber);
      // 2nd test: calling using StarHub IDD service (IDD is 008)
      expect(phoneUtil.parse('0081-650-253-0000', 'SG'), _usNumber);
      // 3rd test: calling using SingTel V019 service (IDD is 019)
      expect(phoneUtil.parse('0191-650-253-0000', 'SG'), _usNumber);
      // Calling the US number from Poland
      expect(phoneUtil.parse('0~01-650-253-0000', 'PL'), _usNumber);
      // Using '++' at the start.
      expect(phoneUtil.parse('++1 (650) 253-0000', 'PL'), _usNumber);
    });

    test('testParseNonAscii', () {
      // Using a full-width plus sign.
      expect(phoneUtil.parse('\uFF0B1 (650) 253-0000', 'SG'), _usNumber);

      // Using a soft hyphen U+00AD.
      expect(phoneUtil.parse('1 (650) 253\u00AD-0000', 'US'), _usNumber);

      // The whole number, including punctuation, is here represented in full-width
      // form.
      String usPhoneNumber =
          '\uFF0B\uFF11\u3000\uFF08\uFF16\uFF15\uFF10\uFF09\u3000\uFF12\uFF15\uFF13\uFF0D\uFF10\uFF10\uFF10\uFF10';
      expect(phoneUtil.parse(usPhoneNumber, 'SG'), _usNumber);

      // Using U+30FC dash instead.
      usPhoneNumber =
          '\uFF0B\uFF11\u3000\uFF08\uFF16\uFF15\uFF10\uFF09\u3000\uFF12\uFF15\uFF13\u30FC\uFF10\uFF10\uFF10\uFF10';
      expect(phoneUtil.parse(usPhoneNumber, 'SG'), _usNumber);

      // Using a very strange decimal digit range (Mongolian digits).
      usPhoneNumber =
          '\u1811 \u1816\u1815\u1810 \u1812\u1815\u1813 \u1810\u1810\u1810\u1810';
      expect(phoneUtil.parse(usPhoneNumber, 'US'), _usNumber);
    });

    test('testParseWithLeadingZero', () {
      expect(phoneUtil.parse('+39 02-36618 300', 'NZ'), _itNumber);
      expect(phoneUtil.parse('02-36618 300', 'IT'), _itNumber);
      expect(phoneUtil.parse('345 678 901', 'IT'), _itMobile);
    });

    test('testParseNationalNumberArgentina', () {
      // Test parsing mobile numbers of Argentina.
      var arNumber = PhoneNumber()
        ..countryCode = 54
        ..nationalNumber = Int64(93435551212);
      expect(phoneUtil.parse('+54 9 343 555 1212', 'AR'), arNumber);
      expect(phoneUtil.parse('0343 15 555 1212', 'AR'), arNumber);

      arNumber = PhoneNumber()
        ..countryCode = 54
        ..nationalNumber = Int64(93715654320);

      expect(phoneUtil.parse('+54 9 3715 65 4320', 'AR'), arNumber);
      expect(phoneUtil.parse('03715 15 65 4320', 'AR'), arNumber);
      expect(phoneUtil.parse('911 876 54321', 'AR'), _arMobile);

      // Test parsing fixed-line numbers of Argentina.
      expect(phoneUtil.parse('+54 11 8765 4321', 'AR'), _arNumber);
      expect(phoneUtil.parse('011 8765 4321', 'AR'), _arNumber);

      arNumber = PhoneNumber()
        ..countryCode = 54
        ..nationalNumber = Int64(3715654321);
      expect(phoneUtil.parse('+54 3715 65 4321', 'AR'), arNumber);
      expect(phoneUtil.parse('03715 65 4321', 'AR'), arNumber);

      arNumber = PhoneNumber()
        ..countryCode = 54
        ..nationalNumber = Int64(2312340000);
      expect(phoneUtil.parse('+54 23 1234 0000', 'AR'), arNumber);
      expect(phoneUtil.parse('023 1234 0000', 'AR'), arNumber);
    });

    test('testParseWithXInNumber', () {
      // Test that having an 'x' in the phone number at the start is ok and that it
      // just gets removed.
      expect(phoneUtil.parse('01187654321', 'AR'), _arNumber);
      expect(phoneUtil.parse('(0) 1187654321', 'AR'), _arNumber);
      expect(phoneUtil.parse('0 1187654321', 'AR'), _arNumber);
      expect(phoneUtil.parse('(0xx) 1187654321', 'AR'), _arNumber);

      final arFromUs = PhoneNumber()
        ..countryCode = 54
        ..nationalNumber = Int64(81429712);
      // This test is intentionally constructed such that the number of digit after
      // xx is larger than 7, so that the number won't be mistakenly treated as an
      // extension, as we allow extensions up to 7 digits. This assumption is okay
      // for now as all the countries where a carrier selection code is written in
      // the form of xx have a national significant number of length larger than 7.
      expect(phoneUtil.parse('011xx5481429712', 'US'), arFromUs);
    });

    test('testParseNumbersMexico', () {
      // Test parsing fixed-line numbers of Mexico.
      var mxNumber = PhoneNumber()
        ..countryCode = 52
        ..nationalNumber = Int64(4499780001);
      expect(phoneUtil.parse('+52 (449)978-0001', 'MX'), mxNumber);
      expect(phoneUtil.parse('01 (449)978-0001', 'MX'), mxNumber);
      expect(phoneUtil.parse('(449)978-0001', 'MX'), mxNumber);

      // Test parsing mobile numbers of Mexico.
      mxNumber = PhoneNumber()
        ..countryCode = 52
        ..nationalNumber = Int64(13312345678);
      expect(phoneUtil.parse('+52 1 33 1234-5678', 'MX'), mxNumber);
      expect(phoneUtil.parse('044 (33) 1234-5678', 'MX'), mxNumber);
      expect(phoneUtil.parse('045 33 1234-5678', 'MX'), mxNumber);
    });

    test('testFailedParseOnInvalidNumbers', () {
      String sentencePhoneNumber = 'This is not a phone number';

      try {
        phoneUtil.parse(sentencePhoneNumber, 'NZ');
        fail(
            'This should not parse without throwing an exception $sentencePhoneNumber');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.notANumber,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        sentencePhoneNumber = '1 Still not a number';
        phoneUtil.parse(sentencePhoneNumber, 'NZ');
        fail(
            'This should not parse without throwing an exception $sentencePhoneNumber');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.notANumber,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        sentencePhoneNumber = '1 MICROSOFT';
        phoneUtil.parse(sentencePhoneNumber, 'NZ');
        fail(
            'This should not parse without throwing an exception $sentencePhoneNumber');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.notANumber,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        sentencePhoneNumber = '12 MICROSOFT';
        phoneUtil.parse(sentencePhoneNumber, 'NZ');
        fail(
            'This should not parse without throwing an exception $sentencePhoneNumber');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.notANumber,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        final tooLongPhoneNumber = '01495 72553301873 810104';
        phoneUtil.parse(tooLongPhoneNumber, 'GB');
        fail(
            'This should not parse without throwing an exception $tooLongPhoneNumber');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.tooLong,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        final plusMinusPhoneNumber = '+---';
        phoneUtil.parse(plusMinusPhoneNumber, 'DE');
        fail(
            'This should not parse without throwing an exception $plusMinusPhoneNumber');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.notANumber,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        final plusStar = '+***';
        phoneUtil.parse(plusStar, 'DE');
        fail('This should not parse without throwing an exception $plusStar');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.notANumber,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        final plusStarPhoneNumber = '+*******91';
        phoneUtil.parse(plusStarPhoneNumber, 'DE');
        fail(
            'This should not parse without throwing an exception $plusStarPhoneNumber');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.notANumber,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        final tooShortPhoneNumber = '+49 0';
        phoneUtil.parse(tooShortPhoneNumber, 'DE');
        fail(
            'This should not parse without throwing an exception $tooShortPhoneNumber');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.tooShortNsn,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        final invalidCountryCode = '+210 3456 56789';
        phoneUtil.parse(invalidCountryCode, 'NZ');
        fail(
            'This is not a recognised region code: should fail: $invalidCountryCode');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.invalidCountryCode,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        final plusAndIddAndInvalidCountryCode = '+ 00 210 3 331 6005';
        phoneUtil.parse(plusAndIddAndInvalidCountryCode, 'NZ');
        fail('This should not parse without throwing an exception.');
      } on NumberParseException catch (e) {
        // Expected this exception. 00 is a correct IDD, but 210 is not a valid
        // country code.
        expect(e.errorType, ErrorType.invalidCountryCode,
            reason: 'Wrong error type stored in exception.');
      }

      String someNumber = '123 456 7890';

      try {
        phoneUtil.parse(someNumber, 'ZZ');
        fail('Unknown region code not allowed: should fail.');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.invalidCountryCode,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        someNumber = '123 456 7890';
        phoneUtil.parse(someNumber, 'CS');
        fail('Deprecated region code not allowed: should fail.');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.invalidCountryCode,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        someNumber = '123 456 7890';
        phoneUtil.parse(someNumber, null);
        fail('Null region code not allowed: should fail.');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.invalidCountryCode,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        someNumber = '0044------';
        phoneUtil.parse(someNumber, 'GB');
        fail('No number provided, only region code: should fail');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.tooShortAfterIdd,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        someNumber = '0044';
        phoneUtil.parse(someNumber, 'GB');
        fail('No number provided, only region code: should fail');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.tooShortAfterIdd,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        someNumber = '011';
        phoneUtil.parse(someNumber, 'US');
        fail('Only IDD provided - should fail.');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.tooShortAfterIdd,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        someNumber = '0119';
        phoneUtil.parse(someNumber, 'US');
        fail('Only IDD provided and then 9 - should fail.');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.tooShortAfterIdd,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        final emptyNumber = '';
        // Invalid region.
        phoneUtil.parse(emptyNumber, 'ZZ');
        fail('Empty string - should fail.');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.notANumber,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        // Invalid region.
        phoneUtil.parse(null, 'ZZ');
        fail('Null string - should fail.');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.notANumber,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        phoneUtil.parse(null, 'US');
        fail('Null string - should fail.');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.notANumber,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        final domainRfcPhoneContext =
            'tel:555-1234;phone-context=www.google.com';
        phoneUtil.parse(domainRfcPhoneContext, 'ZZ');
        fail('"Unknown" region code not allowed: should fail.');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.invalidCountryCode,
            reason: 'Wrong error type stored in exception.');
      }

      String invalidRfcPhoneContext = 'tel:555-1234;phone-context=1-331';

      try {
        // This is invalid because no '+' sign is present as part of phone-context.
        // This should not succeed in being parsed.
        phoneUtil.parse(invalidRfcPhoneContext, 'ZZ');
        fail('phone-context is missing "+" sign: should fail.');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.notANumber,
            reason: 'Wrong error type stored in exception.');
      }

      try {
        // Only the phone-context symbol is present, but no data.
        invalidRfcPhoneContext = ';phone-context=';
        phoneUtil.parse(invalidRfcPhoneContext, 'ZZ');
        fail('phone-context can\'t be empty: should fail.');
      } on NumberParseException catch (e) {
        // Expected.
        expect(e.errorType, ErrorType.notANumber,
            reason: 'Wrong error type stored in exception.');
      }
    });

    test('testParseNumbersWithPlusWithNoRegion', () {
      // ZZ is allowed only if the number starts with a '+' - then the
      // country calling code can be calculated.
      expect(phoneUtil.parse('+64 3 331 6005', 'ZZ'), _nzNumber);
      // Test with full-width plus.
      expect(phoneUtil.parse('\uFF0B64 3 331 6005', 'ZZ'), _nzNumber);
      // Test with normal plus but leading characters that need to be stripped.
      expect(phoneUtil.parse('Tel: +64 3 331 6005', 'ZZ'), _nzNumber);
      expect(phoneUtil.parse('+64 3 331 6005', null), _nzNumber);
      expect(phoneUtil.parse('+800 1234 5678', null), _internationalTollFree);
      expect(phoneUtil.parse('+979 123 456 789', null), _universalPremiumRate);

      // Test parsing RFC3966 format with a phone context.
      expect(phoneUtil.parse('tel:03-331-6005;phone-context=+64', 'ZZ'),
          _nzNumber);
      expect(phoneUtil.parse('  tel:03-331-6005;phone-context=+64', 'ZZ'),
          _nzNumber);
      expect(
          phoneUtil.parse('tel:03-331-6005;isub=12345;phone-context=+64', 'ZZ'),
          _nzNumber);

      PhoneNumber nzNumberWithRawInput = _nzNumber.deepCopy()
        ..rawInput = '+64 3 331 6005'
        ..countryCodeSource =
            PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN;
      expect(phoneUtil.parseAndKeepRawInput('+64 3 331 6005', 'ZZ'),
          nzNumberWithRawInput);
      // Null is also allowed for the region code in these cases.
      expect(phoneUtil.parseAndKeepRawInput('+64 3 331 6005', null),
          nzNumberWithRawInput);
    });

    test('testParseNumberTooShortIfNationalPrefixStripped', () {
      // Test that a number whose first digits happen to coincide with the national
      // prefix does not get them stripped if doing so would result in a number too
      // short to be a possible (regular length) phone number for that region.
      final byNumber = PhoneNumber()
        ..countryCode = 375
        ..nationalNumber = Int64(8123);
      expect(phoneUtil.parse('8123', 'BY'), byNumber);
      byNumber.nationalNumber = Int64(81234);
      expect(phoneUtil.parse('81234', 'BY'), byNumber);

      // The prefix doesn't get stripped, since the input is a viable 6-digit
      // number, whereas the result of stripping is only 5 digits.
      byNumber.nationalNumber = Int64(812345);
      expect(phoneUtil.parse('812345', 'BY'), byNumber);

      // The prefix gets stripped, since only 6-digit numbers are possible.
      byNumber.nationalNumber = Int64(123456);
      expect(phoneUtil.parse('8123456', 'BY'), byNumber);
    });

    test('testParseExtensions', () {
      final nzNumber = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(33316005)
        ..extension_3 = '3456';
      expect(phoneUtil.parse('03 331 6005 ext 3456', 'NZ'), nzNumber);
      expect(phoneUtil.parse('03-3316005x3456', 'NZ'), nzNumber);
      expect(phoneUtil.parse('03-3316005 int.3456', 'NZ'), nzNumber);
      expect(phoneUtil.parse('03 3316005 #3456', 'NZ'), nzNumber);

      // Test the following do not extract extensions:
      expect(phoneUtil.parse('1800 six-flags', 'US'), _alphaNumericNumber);
      expect(phoneUtil.parse('1800 SIX FLAGS', 'US'), _alphaNumericNumber);
      expect(phoneUtil.parse('0~0 1800 7493 5247', 'PL'), _alphaNumericNumber);
      expect(phoneUtil.parse('(1800) 7493.5247', 'US'), _alphaNumericNumber);

      // Check that the last instance of an extension token is matched.
      PhoneNumber extnNumber = _alphaNumericNumber.deepCopy();
      extnNumber.extension_3 = '1234';
      expect(phoneUtil.parse('0~0 1800 7493 5247 ~1234', 'PL'), extnNumber);

      // Verifying bug-fix where the last digit of a number was previously omitted
      // if it was a 0 when extracting the extension. Also verifying a few different
      // cases of extensions.
      PhoneNumber ukNumber = PhoneNumber()
        ..countryCode = 44
        ..nationalNumber = Int64(2034567890)
        ..extension_3 = '456';
      expect(phoneUtil.parse('+44 2034567890x456', 'NZ'), ukNumber);
      expect(phoneUtil.parse('+44 2034567890x456', 'GB'), ukNumber);
      expect(phoneUtil.parse('+44 2034567890 x456', 'GB'), ukNumber);
      expect(phoneUtil.parse('+44 2034567890 X456', 'GB'), ukNumber);
      expect(phoneUtil.parse('+44 2034567890 X 456', 'GB'), ukNumber);
      expect(phoneUtil.parse('+44 2034567890 X  456', 'GB'), ukNumber);
      expect(phoneUtil.parse('+44 2034567890 x 456  ', 'GB'), ukNumber);
      expect(phoneUtil.parse('+44 2034567890  X 456', 'GB'), ukNumber);
      expect(phoneUtil.parse('+44-2034567890;ext=456', 'GB'), ukNumber);
      expect(phoneUtil.parse('tel:2034567890;ext=456;phone-context=+44', 'ZZ'),
          ukNumber);

      // Full-width extension, 'extn' only.
      expect(phoneUtil.parse('+442034567890\uFF45\uFF58\uFF54\uFF4E456', 'GB'),
          ukNumber);

      // 'xtn' only.
      expect(phoneUtil.parse('+442034567890\uFF58\uFF54\uFF4E456', 'GB'),
          ukNumber);

      // 'xt' only.
      expect(phoneUtil.parse('+442034567890\uFF58\uFF54456', 'GB'), ukNumber);

      var usWithExtension = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(8009013355)
        ..extension_3 = '7246433';
      expect(
          phoneUtil.parse('(800) 901-3355 x 7246433', 'US'), usWithExtension);
      expect(phoneUtil.parse('(800) 901-3355 , ext 7246433', 'US'),
          usWithExtension);

      expect(
          phoneUtil.parse('(800) 901-3355 ; 7246433', 'US'), usWithExtension);

      // To test an extension character without surrounding spaces.
      expect(phoneUtil.parse('(800) 901-3355;7246433', 'US'), usWithExtension);
      expect(phoneUtil.parse('(800) 901-3355 ,extension 7246433', 'US'),
          usWithExtension);
      expect(phoneUtil.parse('(800) 901-3355 ,extensi\u00F3n 7246433', 'US'),
          usWithExtension);

      // Repeat with the small letter o with acute accent created by combining
      // characters.
      expect(phoneUtil.parse('(800) 901-3355 ,extensio\u0301n 7246433', 'US'),
          usWithExtension);
      expect(
          phoneUtil.parse('(800) 901-3355 , 7246433', 'US'), usWithExtension);
      expect(phoneUtil.parse('(800) 901-3355 ext: 7246433', 'US'),
          usWithExtension);

      // Testing Russian extension "доб" with variants found online.
      final ruWithExtension = PhoneNumber()
        ..countryCode = 7
        ..nationalNumber = Int64(4232022511)
        ..extension_3 = '100';
      expect(phoneUtil.parse('8 (423) 202-25-11, доб. 100', 'RU'),
          ruWithExtension);
      expect(
          phoneUtil.parse('8 (423) 202-25-11 доб. 100', 'RU'), ruWithExtension);
      expect(
          phoneUtil.parse('8 (423) 202-25-11, доб 100', 'RU'), ruWithExtension);
      expect(
          phoneUtil.parse('8 (423) 202-25-11 доб 100', 'RU'), ruWithExtension);
      expect(phoneUtil.parse('8 (423) 202-25-11доб100', 'RU'), ruWithExtension);

      // Testing in unicode format
      expect(
          phoneUtil.parse('8 (423) 202-25-11, \u0434\u043E\u0431. 100', 'RU'),
          ruWithExtension);

      // In upper case
      expect(phoneUtil.parse('8 (423) 202-25-11ДОБ100', 'RU'), ruWithExtension);
      expect(phoneUtil.parse('8 (423) 202-25-11\u0414\u041E\u0411100', 'RU'),
          ruWithExtension);

      // Test that if a number has two extensions specified, we ignore the second.
      final usWithTwoExtensionsNumber = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(2121231234)
        ..extension_3 = '508';
      expect(phoneUtil.parse('(212)123-1234 x508/x1234', 'US'),
          usWithTwoExtensionsNumber);
      expect(phoneUtil.parse('(212)123-1234 x508/ x1234', 'US'),
          usWithTwoExtensionsNumber);
      expect(phoneUtil.parse('(212)123-1234 x508\\x1234', 'US'),
          usWithTwoExtensionsNumber);

      // Test parsing numbers in the form (645) 123-1234-910# works, where the last
      // 3 digits before the # are an extension.
      usWithExtension = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(6451231234)
        ..extension_3 = '910';
      expect(phoneUtil.parse('+1 (645) 123 1234-910#', 'US'), usWithExtension);

      // Retry with the same number in a slightly different format.
      expect(phoneUtil.parse('+1 (645) 123 1234 ext. 910#', 'US'),
          usWithExtension);
    });

    test('testParseHandlesLongExtensionsWithExplicitLabels', () {
      // Test lower and upper limits of extension lengths for each type of label.
      final nzNumber = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(33316005);

      // Firstly, when in RFC format: PhoneNumberUtil.extLimitAfterExplicitLabel
      nzNumber.extension_3 = '0';
      expect(phoneUtil.parse('tel:+6433316005;ext=0', 'NZ'), nzNumber);
      nzNumber.extension_3 = '01234567890123456789';
      expect(phoneUtil.parse('tel:+6433316005;ext=01234567890123456789', 'NZ'),
          nzNumber);

      // Extension too long.
      try {
        phoneUtil.parse('tel:+6433316005;ext=012345678901234567890', 'NZ');
        fail(
            'This should not parse as length of extension is higher than allowed: '
            'tel:+6433316005;ext=012345678901234567890');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.notANumber,
            reason: 'Wrong error type stored in exception.');
      }

      // Explicit extension label: PhoneNumberUtil.extLimitAfterExplicitLabel
      nzNumber.extension_3 = '1';
      expect(phoneUtil.parse('03 3316005ext:1', 'NZ'), nzNumber);
      nzNumber.extension_3 = '12345678901234567890';
      expect(phoneUtil.parse('03 3316005 xtn:12345678901234567890', 'NZ'),
          nzNumber);
      expect(
          phoneUtil.parse('03 3316005 extension\t12345678901234567890', 'NZ'),
          nzNumber);
      expect(phoneUtil.parse('03 3316005 xtensio:12345678901234567890', 'NZ'),
          nzNumber);
      expect(
          phoneUtil.parse('03 3316005 xtensión, 12345678901234567890#', 'NZ'),
          nzNumber);
      expect(phoneUtil.parse('03 3316005extension.12345678901234567890', 'NZ'),
          nzNumber);
      expect(phoneUtil.parse('03 3316005 доб:12345678901234567890', 'NZ'),
          nzNumber);

      // Extension too long.
      try {
        phoneUtil.parse('03 3316005 extension 123456789012345678901', 'NZ');
        fail(
            'This should not parse as length of extension is higher than allowed: '
            '03 3316005 extension 123456789012345678901');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.tooLong,
            reason: 'Wrong error type stored in exception.');
      }
    });

    test('testParseHandlesLongExtensionsWithAutoDiallingLabels', () {
      // Lastly, cases of auto-dialling and other standard extension labels,
      // PhoneNumberUtil.extLimitAfterLikelyLabel
      final usNumberUserInput = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(2679000000)
        ..extension_3 = '123456789012345';
      expect(phoneUtil.parse('+12679000000,,123456789012345#', 'US'),
          usNumberUserInput);
      expect(phoneUtil.parse('+12679000000;123456789012345#', 'US'),
          usNumberUserInput);

      final ukNumberUserInput = PhoneNumber()
        ..countryCode = 44
        ..nationalNumber = Int64(2034000000)
        ..extension_3 = '123456789';
      expect(phoneUtil.parse('+442034000000,,123456789#', 'GB'),
          ukNumberUserInput);

      // Extension too long.
      try {
        phoneUtil.parse('+12679000000,,1234567890123456#', 'US');
        fail(
            'This should not parse as length of extension is higher than allowed: '
            '+12679000000,,1234567890123456#');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.notANumber,
            reason: 'Wrong error type stored in exception.');
      }
    });

    test('testParseHandlesShortExtensionsWithAmbiguousChar', () {
      final nzNumber = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(33316005);

      // Secondly, for single and non-standard cases:
      // PhoneNumberUtil.extLimitAfterAmbiguousChar
      nzNumber.extension_3 = '123456789';
      expect(phoneUtil.parse('03 3316005 x 123456789', 'NZ'), nzNumber);
      expect(phoneUtil.parse('03 3316005 x. 123456789', 'NZ'), nzNumber);
      expect(phoneUtil.parse('03 3316005 #123456789#', 'NZ'), nzNumber);
      expect(phoneUtil.parse('03 3316005 ~ 123456789', 'NZ'), nzNumber);

      // Extension too long.
      try {
        phoneUtil.parse('03 3316005 ~ 1234567890', 'NZ');
        fail(
            'This should not parse as length of extension is higher than allowed: 03 3316005 ~ 1234567890');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.tooLong,
            reason: 'Wrong error type stored in exception.');
      }
    });

    test('testParseHandlesShortExtensionsWhenNotSureOfLabel', () {
      // Thirdly, when no explicit extension label present, but denoted by tailing #:
      // PhoneNumberUtil.extLimitWhenNotSure
      final usNumber = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(1234567890)
        ..extension_3 = '666666';
      expect(phoneUtil.parse('+1123-456-7890 666666#', 'US'), usNumber);

      usNumber.extension_3 = '6';
      expect(phoneUtil.parse('+11234567890-6#', 'US'), usNumber);

      // Extension too long.
      try {
        phoneUtil.parse('+1123-456-7890 7777777#', 'US');
        fail(
            'This should not parse as length of extension is higher than allowed: +1123-456-7890 7777777#');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.notANumber,
            reason: 'Wrong error type stored in exception.');
      }
    });

    test('testParseAndKeepRaw', () {
      PhoneNumber alphaNumericNumber = _alphaNumericNumber.deepCopy()
        ..rawInput = '800 six-flags'
        ..countryCodeSource =
            PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY;
      expect(phoneUtil.parseAndKeepRawInput('800 six-flags', 'US'),
          alphaNumericNumber);

      final shorterAlphaNumber = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(8007493524)
        ..rawInput = '1800 six-flag'
        ..countryCodeSource =
            PhoneNumber_CountryCodeSource.FROM_NUMBER_WITHOUT_PLUS_SIGN;
      expect(phoneUtil.parseAndKeepRawInput('1800 six-flag', 'US'),
          shorterAlphaNumber);

      shorterAlphaNumber
        ..rawInput = '+1800 six-flag'
        ..countryCodeSource =
            PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN;
      expect(phoneUtil.parseAndKeepRawInput('+1800 six-flag', 'NZ'),
          shorterAlphaNumber);

      alphaNumericNumber
        ..countryCode = 1
        ..nationalNumber = Int64(8007493524)
        ..rawInput = '001800 six-flag'
        ..countryCodeSource =
            PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_IDD;
      expect(phoneUtil.parseAndKeepRawInput('001800 six-flag', 'NZ'),
          alphaNumericNumber);

      // Invalid region code supplied.
      try {
        phoneUtil.parseAndKeepRawInput('123 456 7890', 'CS');
        fail('Deprecated region code not allowed: should fail.');
      } on NumberParseException catch (e) {
        // Expected this exception.
        expect(e.errorType, ErrorType.invalidCountryCode,
            reason: 'Wrong error type stored in exception.');
      }

      final koreanNumber = PhoneNumber()
        ..countryCode = 82
        ..nationalNumber = Int64(22123456)
        ..rawInput = '08122123456'
        ..countryCodeSource = PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY
        ..preferredDomesticCarrierCode = '81';
      expect(phoneUtil.parseAndKeepRawInput('08122123456', 'KR'), koreanNumber);
    });

    test('testParseItalianLeadingZeros', () {
      // Test the number "011".
      final oneZero = PhoneNumber()
        ..countryCode = 61
        ..nationalNumber = Int64(11)
        ..italianLeadingZero = true;
      expect(phoneUtil.parse('011', 'AU'), oneZero);

      // Test the number "001".
      final twoZeros = PhoneNumber()
        ..countryCode = 61
        ..nationalNumber = Int64(1)
        ..italianLeadingZero = true
        ..numberOfLeadingZeros = 2;
      expect(phoneUtil.parse('001', 'AU'), twoZeros);

      // Test the number "000". This number has 2 leading zeros.
      final stillTwoZeros = PhoneNumber()
        ..countryCode = 61
        ..nationalNumber = Int64(0)
        ..italianLeadingZero = true
        ..numberOfLeadingZeros = 2;
      expect(phoneUtil.parse('000', 'AU'), stillTwoZeros);

      // Test the number "0000". This number has 3 leading zeros.
      final threeZeros = PhoneNumber()
        ..countryCode = 61
        ..nationalNumber = Int64(0)
        ..italianLeadingZero = true
        ..numberOfLeadingZeros = 3;
      expect(phoneUtil.parse('0000', 'AU'), threeZeros);
    });

    test('testParseWithPhoneContext', () {
      // context    = ";phone-context=" descriptor
      // descriptor = domainname / global-number-digits

      // Valid global-phone-digits
      expect(
          phoneUtil.parse("tel:033316005;phone-context=+64", 'ZZ'), _nzNumber);
      expect(
          phoneUtil.parse(
              "tel:033316005;phone-context=+64;{this isn't part of phone-context anymore!}",
              'ZZ'),
          _nzNumber);

      final nzFromPhoneContext = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(3033316005);
      expect(phoneUtil.parse("tel:033316005;phone-context=+64-3", 'ZZ'),
          nzFromPhoneContext);

      final brFromPhoneContext = PhoneNumber()
        ..countryCode = 55
        ..nationalNumber = Int64(5033316005);
      expect(phoneUtil.parse("tel:033316005;phone-context=+(555)", 'ZZ'),
          brFromPhoneContext);

      final usFromPhoneContext = PhoneNumber()
        ..countryCode = 1
        ..nationalNumber = Int64(23033316005);
      expect(phoneUtil.parse("tel:033316005;phone-context=+-1-2.3()", 'ZZ'),
          usFromPhoneContext);

      // Valid domainname
      expect(phoneUtil.parse("tel:033316005;phone-context=abc.nz", 'NZ'),
          _nzNumber);
      expect(
          phoneUtil.parse(
              "tel:033316005;phone-context=www.PHONE-numb3r.com", 'NZ'),
          _nzNumber);
      expect(phoneUtil.parse("tel:033316005;phone-context=a", 'NZ'), _nzNumber);
      expect(phoneUtil.parse("tel:033316005;phone-context=3phone.J.", 'NZ'),
          _nzNumber);
      expect(
          phoneUtil.parse("tel:033316005;phone-context=a--z", 'NZ'), _nzNumber);

      // Invalid descriptor
      _assertThrowsForInvalidPhoneContext("tel:033316005;phone-context=");
      _assertThrowsForInvalidPhoneContext("tel:033316005;phone-context=+");
      _assertThrowsForInvalidPhoneContext("tel:033316005;phone-context=64");
      _assertThrowsForInvalidPhoneContext("tel:033316005;phone-context=++64");
      _assertThrowsForInvalidPhoneContext("tel:033316005;phone-context=+abc");
      _assertThrowsForInvalidPhoneContext("tel:033316005;phone-context=.");
      _assertThrowsForInvalidPhoneContext("tel:033316005;phone-context=3phone");
      _assertThrowsForInvalidPhoneContext("tel:033316005;phone-context=a-.nz");
      _assertThrowsForInvalidPhoneContext("tel:033316005;phone-context=a{b}c");
    });

    test('testCountryWithNoNumberDesc', () {
      // Andorra is a country where we don't have PhoneNumberDesc info in the
      // metadata.
      final adNumber = PhoneNumber()
        ..countryCode = 376
        ..nationalNumber = Int64(12345);
      expect('+376 12345',
          phoneUtil.format(adNumber, PhoneNumberFormat.international));
      expect('+37612345', phoneUtil.format(adNumber, PhoneNumberFormat.e164));
      expect('12345', phoneUtil.format(adNumber, PhoneNumberFormat.national));
      expect(PhoneNumberType.unknown, phoneUtil.getNumberType(adNumber));
      expect(phoneUtil.isValidNumber(adNumber), false);

      // Test dialing a US number from within Andorra.
      expect('00 1 650 253 0000',
          phoneUtil.formatOutOfCountryCallingNumber(_usNumber, 'AD'));
    });

    test('testUnknownCountryCallingCode', () {
      expect(phoneUtil.isValidNumber(_unknownCountryCodeNoRawInput), false);
      // It's not very well defined as to what the E164 representation for a number
      // with an invalid country calling code is, but just prefixing the country
      // code and national number is about the best we can do.
      expect(
          phoneUtil.format(
              _unknownCountryCodeNoRawInput, PhoneNumberFormat.e164),
          '+212345');
    });

    test('testIsNumberMatchMatches', () {
      // Test simple matches where formatting is different, or leading zeros, or
      // country calling code has been specified.
      PhoneNumber num1 = phoneUtil.parse('+64 3 331 6005', 'NZ');
      PhoneNumber num2 = phoneUtil.parse('+64 03 331 6005', 'NZ');
      expect(MatchType.exactMatch, phoneUtil.isNumberMatch(num1, num2));
      expect(MatchType.exactMatch,
          phoneUtil.isNumberMatch('+64 3 331 6005', '+64 03 331 6005'));
      expect(MatchType.exactMatch,
          phoneUtil.isNumberMatch('+800 1234 5678', '+80012345678'));
      expect(MatchType.exactMatch,
          phoneUtil.isNumberMatch('+64 03 331-6005', '+64 03331 6005'));
      expect(MatchType.exactMatch,
          phoneUtil.isNumberMatch('+643 331-6005', '+64033316005'));
      expect(MatchType.exactMatch,
          phoneUtil.isNumberMatch('+643 331-6005', '+6433316005'));
      expect(MatchType.exactMatch,
          phoneUtil.isNumberMatch('+64 3 331-6005', '+6433316005'));
      expect(
          MatchType.exactMatch,
          phoneUtil.isNumberMatch(
              '+64 3 331-6005', 'tel:+64-3-331-6005;isub=123'));
      // Test alpha numbers.
      expect(MatchType.exactMatch,
          phoneUtil.isNumberMatch('+1800 siX-Flags', '+1 800 7493 5247'));
      // Test numbers with extensions.
      expect(
          MatchType.exactMatch,
          phoneUtil.isNumberMatch(
              '+64 3 331-6005 extn 1234', '+6433316005#1234'));
      expect(
          MatchType.exactMatch,
          phoneUtil.isNumberMatch(
              '+64 3 331-6005 ext. 1234', '+6433316005;1234'));
      expect(
          MatchType.exactMatch,
          phoneUtil.isNumberMatch(
              '+7 423 202-25-11 ext 100', '+7 4232022511 доб. 100'));
      // Test proto buffers.
      expect(MatchType.exactMatch,
          phoneUtil.isNumberMatch(_nzNumber, '+6403 331 6005'));

      PhoneNumber nzNumber = _nzNumber.deepCopy();
      nzNumber.extension_3 = '3456';
      expect(MatchType.exactMatch,
          phoneUtil.isNumberMatch(nzNumber, '+643 331 6005 ext 3456'));
      // Check empty extensions are ignored.
      nzNumber.extension_3 = '';
      expect(MatchType.exactMatch,
          phoneUtil.isNumberMatch(nzNumber, '+6403 331 6005'));
      // Check variant with two proto buffers.
      expect(phoneUtil.isNumberMatch(nzNumber, _nzNumber), MatchType.exactMatch,
          reason: 'Numbers did not match');
    });

    test('testIsNumberMatchShortMatchIfDiffNumLeadingZeros', () {
      final nzNumberOne = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(33316005)
        ..italianLeadingZero = true;

      final nzNumberTwo = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(33316005)
        ..italianLeadingZero = true
        ..numberOfLeadingZeros = 2;

      expect(MatchType.shortNsnMatch,
          phoneUtil.isNumberMatch(nzNumberOne, nzNumberTwo));

      nzNumberOne
        ..italianLeadingZero = false
        ..numberOfLeadingZeros = 1;

      nzNumberTwo
        ..italianLeadingZero = true
        ..numberOfLeadingZeros = 1;
      // Since one doesn't have the "italian_leading_zero" set to true, we ignore
      // the number of leading zeros present (1 is in any case the default value).
      expect(MatchType.shortNsnMatch,
          phoneUtil.isNumberMatch(nzNumberOne, nzNumberTwo));
    });

    test('testIsNumberMatchAcceptsProtoDefaultsAsMatch', () {
      final nzNumberOne = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(33316005)
        ..italianLeadingZero = true;

      // The default for number_of_leading_zeros is 1, so it shouldn't normally be
      // set, however if it is it should be considered equivalent.
      final nzNumberTwo = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(33316005)
        ..italianLeadingZero = true
        ..numberOfLeadingZeros = 1;

      expect(phoneUtil.isNumberMatch(nzNumberOne, nzNumberTwo),
          MatchType.exactMatch);
    });

    test('testIsNumberMatchMatchesDiffLeadingZerosIfItalianLeadingZeroFalse',
        () {
      final nzNumberOne = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(33316005);

      // The default for number_of_leading_zeros is 1, so it shouldn't normally be
      // set, however if it is it should be considered equivalent.
      final nzNumberTwo = PhoneNumber()
        ..countryCode = 64
        ..nationalNumber = Int64(33316005)
        ..numberOfLeadingZeros = 1;

      expect(phoneUtil.isNumberMatch(nzNumberOne, nzNumberTwo),
          MatchType.exactMatch);

      // Even if it is set to ten, it is still equivalent because in both cases
      // italian_leading_zero is not true.
      expect(phoneUtil.isNumberMatch(nzNumberOne, nzNumberTwo),
          MatchType.exactMatch);
    });

    test('testIsNumberMatchIgnoresSomeFields', () {
      // Check raw_input, country_code_source and preferred_domestic_carrier_code
      // are ignored.
      final brNumberOne = PhoneNumber()
        ..countryCode = 55
        ..nationalNumber = Int64(3121286979)
        ..countryCodeSource =
            PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN
        ..preferredDomesticCarrierCode = '12'
        ..rawInput = '012 3121286979';

      final brNumberTwo = PhoneNumber()
        ..countryCode = 55
        ..nationalNumber = Int64(3121286979)
        ..countryCodeSource = PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY
        ..preferredDomesticCarrierCode = '14'
        ..rawInput = '143121286979';
      expect(phoneUtil.isNumberMatch(brNumberOne, brNumberTwo),
          MatchType.exactMatch);
    });

    test('testIsNumberMatchNonMatches', () {
      // Non-matches.
      expect(phoneUtil.isNumberMatch('03 331 6005', '03 331 6006'),
          MatchType.noMatch);
      expect(phoneUtil.isNumberMatch('+800 1234 5678', '+1 800 1234 5678'),
          MatchType.noMatch);
      // Different country calling code, partial number match.
      expect(phoneUtil.isNumberMatch('+64 3 331-6005', '+16433316005'),
          MatchType.noMatch);
      // Different country calling code, same number.
      expect(phoneUtil.isNumberMatch('+64 3 331-6005', '+6133316005'),
          MatchType.noMatch);
      // Extension different, all else the same.
      expect(
          phoneUtil.isNumberMatch(
              '+64 3 331-6005 extn 1234', '0116433316005#1235'),
          MatchType.noMatch);
      expect(
          phoneUtil.isNumberMatch(
              '+64 3 331-6005 extn 1234', 'tel:+64-3-331-6005;ext=1235'),
          MatchType.noMatch);
      // NSN matches, but extension is different - not the same number.
      expect(
          phoneUtil.isNumberMatch('+64 3 331-6005 ext.1235', '3 331 6005#1234'),
          MatchType.noMatch);

      // Invalid numbers that can't be parsed.
      expect(phoneUtil.isNumberMatch('4', '3 331 6043'), MatchType.notANumber);
      expect(phoneUtil.isNumberMatch('+43', '+64 3 331 6005'),
          MatchType.notANumber);
      expect(phoneUtil.isNumberMatch('+43', '64 3 331 6005'),
          MatchType.notANumber);
      expect(phoneUtil.isNumberMatch('Dog', '64 3 331 6005'),
          MatchType.notANumber);
    });

    test('testIsNumberMatchNsnMatches', () {
      // NSN matches.
      expect(phoneUtil.isNumberMatch('+64 3 331-6005', '03 331 6005'),
          MatchType.nsnMatch);
      expect(
          phoneUtil.isNumberMatch('+64 3 331-6005',
              'tel:03-331-6005;isub=1234;phone-context=abc.nz'),
          MatchType.nsnMatch);
      expect(phoneUtil.isNumberMatch(_nzNumber, '03 331 6005'),
          MatchType.nsnMatch);
      // Here the second number possibly starts with the country calling code for
      // New Zealand, although we are unsure.
      PhoneNumber unchangedNzNumber = _nzNumber.deepCopy();
      expect(phoneUtil.isNumberMatch(unchangedNzNumber, '(64-3) 331 6005'),
          MatchType.nsnMatch);
      // Check the phone number proto was not edited during the method call.
      expect(unchangedNzNumber, _nzNumber);

      // Here, the 1 might be a national prefix, if we compare it to the US number,
      // so the resultant match is an NSN match.
      expect(phoneUtil.isNumberMatch(_usNumber, '1-650-253-0000'),
          MatchType.nsnMatch);
      expect(
          phoneUtil.isNumberMatch(_usNumber, '6502530000'), MatchType.nsnMatch);
      expect(phoneUtil.isNumberMatch('+1 650-253 0000', '1 650 253 0000'),
          MatchType.nsnMatch);
      expect(phoneUtil.isNumberMatch('1 650-253 0000', '1 650 253 0000'),
          MatchType.nsnMatch);
      expect(phoneUtil.isNumberMatch('1 650-253 0000', '+1 650 253 0000'),
          MatchType.nsnMatch);
      // For this case, the match will be a short NSN match, because we cannot
      // assume that the 1 might be a national prefix, so don't remove it when
      // parsing.
      final randomNumber = PhoneNumber()
        ..countryCode = 41
        ..nationalNumber = Int64(6502530000);
      expect(phoneUtil.isNumberMatch(randomNumber, '1-650-253-0000'),
          MatchType.shortNsnMatch);
    });

    test('testIsNumberMatchShortNsnMatches', () {
      // Short NSN matches with the country not specified for either one or both
      // numbers.
      expect(phoneUtil.isNumberMatch('+64 3 331-6005', '331 6005'),
          MatchType.shortNsnMatch);
      expect(
          phoneUtil.isNumberMatch(
              '+64 3 331-6005', 'tel:331-6005;phone-context=abc.nz'),
          MatchType.shortNsnMatch);
      expect(
          phoneUtil.isNumberMatch(
              '+64 3 331-6005', 'tel:331-6005;isub=1234;phone-context=abc.nz'),
          MatchType.shortNsnMatch);
      expect(
          phoneUtil.isNumberMatch('+64 3 331-6005',
              'tel:331-6005;isub=1234;phone-context=abc.nz;a=%A1'),
          MatchType.shortNsnMatch);
      // We did not know that the '0' was a national prefix since neither number has
      // a country code, so this is considered a SHORT_NSN_MATCH.
      expect(phoneUtil.isNumberMatch('3 331-6005', '03 331 6005'),
          MatchType.shortNsnMatch);
      expect(phoneUtil.isNumberMatch('3 331-6005', '331 6005'),
          MatchType.shortNsnMatch);
      expect(
          phoneUtil.isNumberMatch(
              '3 331-6005', 'tel:331-6005;phone-context=abc.nz'),
          MatchType.shortNsnMatch);
      expect(phoneUtil.isNumberMatch('3 331-6005', '+64 331 6005'),
          MatchType.shortNsnMatch);
      // Short NSN match with the country specified.
      expect(phoneUtil.isNumberMatch('03 331-6005', '331 6005'),
          MatchType.shortNsnMatch);
      expect(phoneUtil.isNumberMatch('1 234 345 6789', '345 6789'),
          MatchType.shortNsnMatch);
      expect(phoneUtil.isNumberMatch('+1 (234) 345 6789', '345 6789'),
          MatchType.shortNsnMatch);
      // NSN matches, country calling code omitted for one number, extension missing
      // for one.
      expect(phoneUtil.isNumberMatch('+64 3 331-6005', '3 331 6005#1234'),
          MatchType.shortNsnMatch);
      // One has Italian leading zero, one does not.
      final italianNumberOne = PhoneNumber()
        ..countryCode = 39
        ..nationalNumber = Int64(1234)
        ..italianLeadingZero = true;

      final italianNumberTwo = PhoneNumber()
        ..countryCode = 39
        ..nationalNumber = Int64(1234);
      expect(phoneUtil.isNumberMatch(italianNumberOne, italianNumberTwo),
          MatchType.shortNsnMatch);

      // One has an extension, the other has an extension of ''.
      italianNumberOne.extension_3 = '1234';
      italianNumberOne.clearItalianLeadingZero();
      italianNumberTwo.extension_3 = '';
      expect(phoneUtil.isNumberMatch(italianNumberOne, italianNumberTwo),
          MatchType.shortNsnMatch);
    });

    test('testCanBeInternationallyDialled', () {
      // We have no-international-dialling rules for the US in our test metadata
      // that say that toll-free numbers cannot be dialled internationally.
      expect(phoneUtil.canBeInternationallyDialled(_usTollfree), false);

      // Normal US numbers can be internationally dialled.
      expect(phoneUtil.canBeInternationallyDialled(_usNumber), true);

      // Invalid number.
      expect(phoneUtil.canBeInternationallyDialled(_usLocalNumber), true);

      // We have no data for NZ - should return true.
      expect(phoneUtil.canBeInternationallyDialled(_nzNumber), true);
      expect(
          phoneUtil.canBeInternationallyDialled(_internationalTollFree), true);
    });

    test('testIsAlphaNumber', () {
      expect(phoneUtil.isAlphaNumber('1800 six-flags'), true);
      expect(phoneUtil.isAlphaNumber('1800 six-flags ext. 1234'), true);
      expect(phoneUtil.isAlphaNumber('+800 six-flags'), true);
      expect(phoneUtil.isAlphaNumber('180 six-flags'), true);
      expect(phoneUtil.isAlphaNumber('1800 123-1234'), false);
      expect(phoneUtil.isAlphaNumber('1 six-flags'), false);
      expect(phoneUtil.isAlphaNumber('18 six-flags'), false);
      expect(phoneUtil.isAlphaNumber('1800 123-1234 extension: 1234'), false);
      expect(phoneUtil.isAlphaNumber('+800 1234-1234'), false);
    });

    test('testIsMobileNumberPortableRegion', () {
      expect(phoneUtil.isMobileNumberPortableRegion('US'), true);
      expect(phoneUtil.isMobileNumberPortableRegion('GB'), true);
      expect(phoneUtil.isMobileNumberPortableRegion('AE'), false);
      expect(phoneUtil.isMobileNumberPortableRegion('BS'), false);
    });

    test('testGetMetadataForRegionForNonGeoEntity_shouldBeNull', () {
      expect(phoneUtil.getMetadataForRegion(regionCode: 'UN001'), isNull);
    });

    test('testGetMetadataForRegionForUnknownRegion_shouldBeNull', () {
      expect(phoneUtil.getMetadataForRegion(regionCode: 'ZZ'), isNull);
    });

    test('testGetMetadataForNonGeographicalRegionForGeoRegion_shouldBeNull',
        () {
      expect(
          phoneUtil.getMetadataForNonGeographicalRegion(
              /* countryCallingCode = */ 1),
          isNull);
    });
  });
}

void _assertThrowsForInvalidPhoneContext(String numberToParse) {
  try {
    phoneUtil.parse(numberToParse, 'ZZ');
  } on NumberParseException catch (e) {
    expect(e.errorType, ErrorType.notANumber);
  }
}
