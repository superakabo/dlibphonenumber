/// Based on the original Java code: .../phonenumbers/ShortNumberInfoTest.java
///
/// [license]
/// Copyright (C) 2013 The Libphonenumber Authors.
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
import 'package:dlibphonenumber/generated/metadata/short_number_metadata_map.dart';
import 'package:test/test.dart';

import 'generated/metadata/phone_number_metadata_map.dart';

void main() {
  final shortInfo = ShortNumberInfo(const ShortNumberMetadataMap());

  group('ShortNumberInfoTest', () {
    test('testIsPossibleShortNumber', () {
      PhoneNumber possibleNumber = PhoneNumber();
      possibleNumber
        ..countryCode = 33
        ..nationalNumber = Int64(123456);

      expect(shortInfo.isPossibleShortNumber(possibleNumber), true);
      expect(shortInfo.isPossibleShortNumberForRegion(_parse("123456", 'FR'), 'FR'), true);

      PhoneNumber impossibleNumber = PhoneNumber();
      impossibleNumber
        ..countryCode = 33
        ..nationalNumber = Int64(9);
      expect(shortInfo.isPossibleShortNumber(impossibleNumber), false);

      // Note that GB and GG share the country calling code 44, and that this number is possible but
      // not valid.
      PhoneNumber isPossibleNumber = PhoneNumber()
        ..countryCode = 44
        ..nationalNumber = Int64(11001);
      expect(shortInfo.isPossibleShortNumber(isPossibleNumber), true);
    });

    test('testIsValidShortNumber', () {
      final phoneNumber1 = PhoneNumber()
        ..countryCode = 33
        ..nationalNumber = Int64(1010);
      expect(shortInfo.isValidShortNumber(phoneNumber1), true);

      expect(shortInfo.isValidShortNumberForRegion(_parse("1010", 'FR'), 'FR'), true);

      final phoneNumber2 = PhoneNumber()
        ..countryCode = 33
        ..nationalNumber = Int64(123456);
      expect(shortInfo.isValidShortNumber(phoneNumber2), false);

      expect(shortInfo.isValidShortNumberForRegion(_parse("123456", 'FR'), 'FR'), false);

      // Note that GB and GG share the country calling code 44.
      final phoneNumber3 = PhoneNumber()
        ..countryCode = 44
        ..nationalNumber = Int64(18001);
      expect(shortInfo.isValidShortNumber(phoneNumber3), true);
    });

    test('testIsCarrierSpecific', () {
      PhoneNumber carrierSpecificNumber = PhoneNumber();
      carrierSpecificNumber
        ..countryCode = 1
        ..nationalNumber = Int64(33669);
      expect(shortInfo.isCarrierSpecific(carrierSpecificNumber), true);
      expect(shortInfo.isCarrierSpecificForRegion(_parse("33669", 'US'), 'US'), true);

      PhoneNumber notCarrierSpecificNumber = PhoneNumber();
      notCarrierSpecificNumber
        ..countryCode = 1
        ..nationalNumber = Int64(911);
      expect(shortInfo.isCarrierSpecific(notCarrierSpecificNumber), false);
      expect(shortInfo.isCarrierSpecificForRegion(_parse("911", 'US'), 'US'), false);

      PhoneNumber carrierSpecificNumberForSomeRegion = PhoneNumber();
      carrierSpecificNumberForSomeRegion
        ..countryCode = 1
        ..nationalNumber = Int64(211);
      expect(shortInfo.isCarrierSpecific(carrierSpecificNumberForSomeRegion), true);
      expect(shortInfo.isCarrierSpecificForRegion(carrierSpecificNumberForSomeRegion, 'US'), true);
      expect(shortInfo.isCarrierSpecificForRegion(carrierSpecificNumberForSomeRegion, 'BB'), false);
    });

    test('testIsSmsService', () {
      PhoneNumber smsServiceNumberForSomeRegion = PhoneNumber();
      smsServiceNumberForSomeRegion
        ..countryCode = 1
        ..nationalNumber = Int64(21234);
      expect(shortInfo.isSmsServiceForRegion(smsServiceNumberForSomeRegion, 'US'), true);
      expect(shortInfo.isSmsServiceForRegion(smsServiceNumberForSomeRegion, 'BB'), false);
    });

    test('testGetExpectedCost', () {
      String premiumRateExample = shortInfo.getExampleShortNumberForCost('FR', ShortNumberCost.premiumRate);
      expect(shortInfo.getExpectedCostForRegion(_parse(premiumRateExample, 'FR'), 'FR'), ShortNumberCost.premiumRate);

      PhoneNumber premiumRateNumber = PhoneNumber()
        ..countryCode = 33
        ..nationalNumber = Int64.parseInt(premiumRateExample);
      expect(shortInfo.getExpectedCost(premiumRateNumber), ShortNumberCost.premiumRate);

      String standardRateExample = shortInfo.getExampleShortNumberForCost('FR', ShortNumberCost.standardRate);
      expect(ShortNumberCost.standardRate, shortInfo.getExpectedCostForRegion(_parse(standardRateExample, 'FR'), 'FR'));

      PhoneNumber standardRateNumber = PhoneNumber()
        ..countryCode = 33
        ..nationalNumber = Int64.parseInt(standardRateExample);
      expect(shortInfo.getExpectedCost(standardRateNumber), ShortNumberCost.standardRate);

      String tollFreeExample = shortInfo.getExampleShortNumberForCost('FR', ShortNumberCost.tollFree);
      expect(shortInfo.getExpectedCostForRegion(_parse(tollFreeExample, 'FR'), 'FR'), ShortNumberCost.tollFree);

      PhoneNumber tollFreeNumber = PhoneNumber()
        ..countryCode = 33
        ..nationalNumber = (Int64.parseInt(tollFreeExample));
      expect(shortInfo.getExpectedCost(tollFreeNumber), ShortNumberCost.tollFree);

      expect(ShortNumberCost.unknownCost, shortInfo.getExpectedCostForRegion(_parse("12345", 'FR'), 'FR'));

      PhoneNumber unknownCostNumber = PhoneNumber()
        ..countryCode = 33
        ..nationalNumber = Int64(12345);
      expect(shortInfo.getExpectedCost(unknownCostNumber), ShortNumberCost.unknownCost);

      // Test that an invalid number may nevertheless have a cost other than
      // UNKNOWN_COST.
      expect(shortInfo.isValidShortNumberForRegion(_parse("116123", 'FR'), 'FR'), false);
      expect(shortInfo.getExpectedCostForRegion(_parse("116123", 'FR'), 'FR'), ShortNumberCost.tollFree);

      PhoneNumber invalidNumber = PhoneNumber()
        ..countryCode = 33
        ..nationalNumber = Int64(116123);
      expect(shortInfo.isValidShortNumber(invalidNumber), false);
      expect(shortInfo.getExpectedCost(invalidNumber), ShortNumberCost.tollFree);

      // Test a nonexistent country code.
      expect(shortInfo.getExpectedCostForRegion(_parse("911", 'US'), 'ZZ'), ShortNumberCost.unknownCost);
      unknownCostNumber
        ..clear()
        ..countryCode = 123
        ..nationalNumber = Int64(911);
      expect(shortInfo.getExpectedCost(unknownCostNumber), ShortNumberCost.unknownCost);
    });

    test('testGetExpectedCostForSharedCountryCallingCode', () {
      // Test some numbers which have different costs in countries sharing the same
      // country calling
      // code. In Australia, 1234 is premium-rate, 1194 is standard-rate, and 733 is
      // toll-free. These
      // are not known to be valid numbers in the Christmas Islands.
      String ambiguousPremiumRateString = "1234";
      PhoneNumber ambiguousPremiumRateNumber = PhoneNumber()
        ..countryCode = 61
        ..nationalNumber = Int64(1234);

      String ambiguousStandardRateString = "1194";
      PhoneNumber ambiguousStandardRateNumber = PhoneNumber()
        ..countryCode = 61
        ..nationalNumber = Int64(1194);

      String ambiguousTollFreeString = "733";
      PhoneNumber ambiguousTollFreeNumber = PhoneNumber()
        ..countryCode = 61
        ..nationalNumber = Int64(733);

      expect(shortInfo.isValidShortNumber(ambiguousPremiumRateNumber), true);
      expect(shortInfo.isValidShortNumber(ambiguousStandardRateNumber), true);
      expect(shortInfo.isValidShortNumber(ambiguousTollFreeNumber), true);

      expect(shortInfo.isValidShortNumberForRegion(_parse(ambiguousPremiumRateString, 'AU'), 'AU'), true);
      expect(
        shortInfo.getExpectedCostForRegion(_parse(ambiguousPremiumRateString, 'AU'), 'AU'),
        ShortNumberCost.premiumRate,
      );

      expect(shortInfo.isValidShortNumberForRegion(_parse(ambiguousPremiumRateString, 'CX'), 'CX'), false);
      expect(
        shortInfo.getExpectedCostForRegion(_parse(ambiguousPremiumRateString, 'CX'), 'CX'),
        ShortNumberCost.unknownCost,
      );

      // PREMIUM_RATE takes precedence over UNKNOWN_COST.
      expect(shortInfo.getExpectedCost(ambiguousPremiumRateNumber), ShortNumberCost.premiumRate);

      expect(shortInfo.isValidShortNumberForRegion(_parse(ambiguousStandardRateString, 'AU'), 'AU'), true);
      expect(
        shortInfo.getExpectedCostForRegion(_parse(ambiguousStandardRateString, 'AU'), 'AU'),
        ShortNumberCost.standardRate,
      );
      expect(shortInfo.isValidShortNumberForRegion(_parse(ambiguousStandardRateString, 'CX'), 'CX'), false);
      expect(
        shortInfo.getExpectedCostForRegion(_parse(ambiguousStandardRateString, 'CX'), 'CX'),
        ShortNumberCost.unknownCost,
      );
      expect(
        shortInfo.getExpectedCost(ambiguousStandardRateNumber),
        ShortNumberCost.unknownCost,
      );

      expect(shortInfo.isValidShortNumberForRegion(_parse(ambiguousTollFreeString, 'AU'), 'AU'), true);
      expect(
        shortInfo.getExpectedCostForRegion(_parse(ambiguousTollFreeString, 'AU'), 'AU'),
        ShortNumberCost.tollFree,
      );
      expect(shortInfo.isValidShortNumberForRegion(_parse(ambiguousTollFreeString, 'CX'), 'CX'), false);
      expect(
        shortInfo.getExpectedCostForRegion(_parse(ambiguousTollFreeString, 'CX'), 'CX'),
        ShortNumberCost.unknownCost,
      );
      expect(
        shortInfo.getExpectedCost(ambiguousTollFreeNumber),
        ShortNumberCost.unknownCost,
      );
    });

    test('testExampleShortNumberPresence', () {
      expect(shortInfo.getExampleShortNumber('AD').isEmpty, false);
      expect(shortInfo.getExampleShortNumber('FR').isEmpty, false);
      expect(shortInfo.getExampleShortNumber('UN001').isEmpty, true);
      expect(shortInfo.getExampleShortNumber(null).isEmpty, true);
    });

    test('testConnectsToEmergencyNumber_US', () {
      expect(shortInfo.connectsToEmergencyNumber("911", 'US'), true);
      expect(shortInfo.connectsToEmergencyNumber("112", 'US'), true);
      expect(shortInfo.connectsToEmergencyNumber("999", 'US'), false);
    });

    test('testConnectsToEmergencyNumberLongNumber_US', () {
      expect(shortInfo.connectsToEmergencyNumber("9116666666", 'US'), true);
      expect(shortInfo.connectsToEmergencyNumber("1126666666", 'US'), true);
      expect(shortInfo.connectsToEmergencyNumber("9996666666", 'US'), false);
    });

    test('testConnectsToEmergencyNumberWithFormatting_US', () {
      expect(shortInfo.connectsToEmergencyNumber("9-1-1", 'US'), true);
      expect(shortInfo.connectsToEmergencyNumber("1-1-2", 'US'), true);
      expect(shortInfo.connectsToEmergencyNumber("9-9-9", 'US'), false);
    });

    test('testConnectsToEmergencyNumberWithPlusSign_US', () {
      expect(shortInfo.connectsToEmergencyNumber("+911", 'US'), false);
      expect(shortInfo.connectsToEmergencyNumber("\uFF0B911", 'US'), false);
      expect(shortInfo.connectsToEmergencyNumber(" +911", 'US'), false);
      expect(shortInfo.connectsToEmergencyNumber("+112", 'US'), false);
      expect(shortInfo.connectsToEmergencyNumber("+999", 'US'), false);
    });

    test('testConnectsToEmergencyNumber_BR', () {
      expect(shortInfo.connectsToEmergencyNumber("911", 'BR'), true);
      expect(shortInfo.connectsToEmergencyNumber("190", 'BR'), true);
      expect(shortInfo.connectsToEmergencyNumber("999", 'BR'), false);
    });

    test('testConnectsToEmergencyNumberLongNumber_BR', () {
      // Brazilian emergency numbers don't work when additional digits are appended.
      expect(shortInfo.connectsToEmergencyNumber("9111", 'BR'), false);
      expect(shortInfo.connectsToEmergencyNumber("1900", 'BR'), false);
      expect(shortInfo.connectsToEmergencyNumber("9996", 'BR'), false);
    });

    test('testConnectsToEmergencyNumber_CL', () {
      expect(shortInfo.connectsToEmergencyNumber("131", 'CL'), true);
      expect(shortInfo.connectsToEmergencyNumber("133", 'CL'), true);
    });

    test('testConnectsToEmergencyNumberLongNumber_CL', () {
      // Chilean emergency numbers don't work when additional digits are appended.
      expect(shortInfo.connectsToEmergencyNumber("1313", 'CL'), false);
      expect(shortInfo.connectsToEmergencyNumber("1330", 'CL'), false);
    });

    test('testConnectsToEmergencyNumber_AO', () {
      // Angola doesn't have any metadata for emergency numbers in the test metadata.
      expect(shortInfo.connectsToEmergencyNumber("911", 'AO'), false);
      expect(shortInfo.connectsToEmergencyNumber("222123456", 'AO'), false);
      expect(shortInfo.connectsToEmergencyNumber("923123456", 'AO'), false);
    });

    test('testConnectsToEmergencyNumber_ZW', () {
      // Zimbabwe doesn't have any metadata in the test metadata.
      expect(shortInfo.connectsToEmergencyNumber("911", 'ZW'), false);
      expect(shortInfo.connectsToEmergencyNumber("01312345", 'ZW'), false);
      expect(shortInfo.connectsToEmergencyNumber("0711234567", 'ZW'), false);
    });

    test('testIsEmergencyNumber_US', () {
      expect(shortInfo.isEmergencyNumber("911", 'US'), true);
      expect(shortInfo.isEmergencyNumber("112", 'US'), true);
      expect(shortInfo.isEmergencyNumber("999", 'US'), false);
    });

    test('testIsEmergencyNumberLongNumber_US', () {
      expect(shortInfo.isEmergencyNumber("9116666666", 'US'), false);
      expect(shortInfo.isEmergencyNumber("1126666666", 'US'), false);
      expect(shortInfo.isEmergencyNumber("9996666666", 'US'), false);
    });

    test('testIsEmergencyNumberWithFormatting_US', () {
      expect(shortInfo.isEmergencyNumber("9-1-1", 'US'), true);
      expect(shortInfo.isEmergencyNumber("*911", 'US'), true);
      expect(shortInfo.isEmergencyNumber("1-1-2", 'US'), true);
      expect(shortInfo.isEmergencyNumber("*112", 'US'), true);
      expect(shortInfo.isEmergencyNumber("9-9-9", 'US'), false);
      expect(shortInfo.isEmergencyNumber("*999", 'US'), false);
    });

    test('testIsEmergencyNumberWithPlusSign_US', () {
      expect(shortInfo.isEmergencyNumber("+911", 'US'), false);
      expect(shortInfo.isEmergencyNumber("\uFF0B911", 'US'), false);
      expect(shortInfo.isEmergencyNumber(" +911", 'US'), false);
      expect(shortInfo.isEmergencyNumber("+112", 'US'), false);
      expect(shortInfo.isEmergencyNumber("+999", 'US'), false);
    });

    test('testIsEmergencyNumber_BR', () {
      expect(shortInfo.isEmergencyNumber("911", 'BR'), true);
      expect(shortInfo.isEmergencyNumber("190", 'BR'), true);
      expect(shortInfo.isEmergencyNumber("999", 'BR'), false);
    });

    test('testIsEmergencyNumberLongNumber_BR', () {
      expect(shortInfo.isEmergencyNumber("9111", 'BR'), false);
      expect(shortInfo.isEmergencyNumber("1900", 'BR'), false);
      expect(shortInfo.isEmergencyNumber("9996", 'BR'), false);
    });

    test('testIsEmergencyNumber_AO', () {
      // Angola doesn't have any metadata for emergency numbers in the test metadata.
      expect(shortInfo.isEmergencyNumber("911", 'AO'), false);
      expect(shortInfo.isEmergencyNumber("222123456", 'AO'), false);
      expect(shortInfo.isEmergencyNumber("923123456", 'AO'), false);
    });

    test('testIsEmergencyNumber_ZW', () {
      // Zimbabwe doesn't have any metadata in the test metadata.
      expect(shortInfo.isEmergencyNumber("911", 'ZW'), false);
      expect(shortInfo.isEmergencyNumber("01312345", 'ZW'), false);
      expect(shortInfo.isEmergencyNumber("0711234567", 'ZW'), false);
    });

    test('testEmergencyNumberForSharedCountryCallingCode', () {
      // Test the emergency number 112, which is valid in both Australia and the
      // Christmas Islands.
      expect(shortInfo.isEmergencyNumber("112", 'AU'), true);
      expect(shortInfo.isValidShortNumberForRegion(_parse("112", 'AU'), 'AU'), true);
      expect(shortInfo.getExpectedCostForRegion(_parse("112", 'AU'), 'AU'), ShortNumberCost.tollFree);
      expect(shortInfo.isEmergencyNumber("112", 'CX'), true);
      expect(shortInfo.isValidShortNumberForRegion(_parse("112", 'CX'), 'CX'), true);
      expect(shortInfo.getExpectedCostForRegion(_parse("112", 'CX'), 'CX'), ShortNumberCost.tollFree);
      PhoneNumber sharedEmergencyNumber = PhoneNumber()
        ..countryCode = 61
        ..nationalNumber = Int64(112);
      expect(shortInfo.isValidShortNumber(sharedEmergencyNumber), true);
      expect(ShortNumberCost.tollFree, shortInfo.getExpectedCost(sharedEmergencyNumber));
    });

    test('testOverlappingNANPANumber', () {
      // 211 is an emergency number in Barbados, while it is a toll-free information
      // line in Canada  and the USA.
      expect(shortInfo.isEmergencyNumber("211", 'BB'), true);
      expect(shortInfo.getExpectedCostForRegion(_parse("211", 'BB'), 'BB'), ShortNumberCost.tollFree);
      expect(shortInfo.isEmergencyNumber("211", 'US'), false);
      expect(ShortNumberCost.unknownCost, shortInfo.getExpectedCostForRegion(_parse("211", 'US'), 'US'));
      expect(shortInfo.isEmergencyNumber("211", 'CA'), false);
      expect(shortInfo.getExpectedCostForRegion(_parse("211", 'CA'), 'CA'), ShortNumberCost.tollFree);
    });

    test('testCountryCallingCodeIsNotIgnored', () {
      // +46 is the country calling code for Sweden (SE),
      //and 40404 is a valid short number in the US.
      expect(shortInfo.isPossibleShortNumberForRegion(_parse("+4640404", 'SE'), 'US'), false);
      expect(shortInfo.isValidShortNumberForRegion(_parse("+4640404", 'SE'), 'US'), false);
      expect(shortInfo.getExpectedCostForRegion(_parse("+4640404", 'SE'), 'US'), ShortNumberCost.unknownCost);
    });
  });
}

final phoneUtil = PhoneNumberUtil(const PhoneNumberMetadataMap());

PhoneNumber _parse(String number, String regionCode) {
  try {
    return phoneUtil.parse(number, regionCode);
  } on NumberParseException catch (e) {
    throw AssertionError("Test input data should always parse correctly: $number ($regionCode) $e");
  }
}
