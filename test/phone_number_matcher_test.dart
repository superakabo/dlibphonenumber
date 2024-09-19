/// Based on the original Java code: .../phonenumbers/PhoneNumberMatcherTest.java
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
library;

import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:test/test.dart';
import 'generated/metadata/phone_number_metadata_map.dart';

final phoneUtil = PhoneNumberUtil(const PhoneNumberMetadataMap());

void main() {
  group('PhoneNumberMatcherTest', () {
    test('testContainsMoreThanOneSlashInNationalNumber', () {
      PhoneNumber number = PhoneNumber();

      // A date should return true.
      number
        ..countryCode = 1
        ..countryCodeSource =
            PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY;
      String candidate = "1/05/2013";
      expect(
          PhoneNumberMatcherImpl.containsMoreThanOneSlashInNationalNumber(
              number, candidate),
          true);

      // Here, the country code source thinks it started with a country calling code, but this is not
      // the same as the part before the slash, so it's still true.
      number
        ..clear()
        ..countryCode = 274
        ..countryCodeSource =
            PhoneNumber_CountryCodeSource.FROM_NUMBER_WITHOUT_PLUS_SIGN;
      candidate = "27/4/2013";
      expect(
          PhoneNumberMatcherImpl.containsMoreThanOneSlashInNationalNumber(
              number, candidate),
          true);

      // Now it should be false, because the first slash is after the country calling code.
      number
        ..clear()
        ..countryCode = 49
        ..countryCodeSource =
            PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN;
      candidate = "49/69/2013";
      expect(
          PhoneNumberMatcherImpl.containsMoreThanOneSlashInNationalNumber(
              number, candidate),
          false);

      number
        ..clear()
        ..countryCode = 49
        ..countryCodeSource =
            PhoneNumber_CountryCodeSource.FROM_NUMBER_WITHOUT_PLUS_SIGN;
      candidate = "+49/69/2013";
      expect(
          PhoneNumberMatcherImpl.containsMoreThanOneSlashInNationalNumber(
              number, candidate),
          false);

      candidate = "+ 49/69/2013";
      expect(
          PhoneNumberMatcherImpl.containsMoreThanOneSlashInNationalNumber(
              number, candidate),
          false);

      candidate = "+ 49/69/20/13";
      expect(
          PhoneNumberMatcherImpl.containsMoreThanOneSlashInNationalNumber(
              number, candidate),
          true);

      // Here, the first group is not assumed to be the country calling code, even though it is the
      // same as it, so this should return true.
      number
        ..clear()
        ..countryCode = 49
        ..countryCodeSource =
            PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY;
      candidate = "49/69/2013";
      expect(
          PhoneNumberMatcherImpl.containsMoreThanOneSlashInNationalNumber(
              number, candidate),
          true);
    });

    /// See [PhoneNumberUtilTest.testParseNationalNumber()].
    test('testFindNationalNumber', () {
      // same cases as in testParseNationalNumber
      _doTestFindInContext("033316005", 'NZ');
      // ("33316005", NZ) is omitted since the national prefix is
      // obligatory for these types of numbers in New Zealand.
      // National prefix attached and some formatting present.
      _doTestFindInContext("03-331 6005", 'NZ');
      _doTestFindInContext("03 331 6005", 'NZ');
      // Testing international prefixes.
      // Should strip country code.
      _doTestFindInContext("0064 3 331 6005", 'NZ');
      // Try again, but this time we have an international number with Region Code US.
      // It should
      // recognize the country code and parse accordingly.
      _doTestFindInContext("01164 3 331 6005", 'US');
      _doTestFindInContext("+64 3 331 6005", 'US');

      _doTestFindInContext("64(0)64123456", 'NZ');
      // Check that using a "/" is fine in a phone number.
      // Note that real Polish numbers do *not* start with a 0.
      _doTestFindInContext("0123/456789", 'PL');
      _doTestFindInContext("123-456-7890", 'US');
    });

    /// See [PhoneNumberUtilTest.testParseWithInternationalPrefixes()].
    test('testFindWithInternationalPrefixes', () {
      _doTestFindInContext("+1 (650) 333-6000", 'NZ');
      _doTestFindInContext("1-650-333-6000", 'US');
      // Calling the US number from Singapore by using different service providers
      // 1st test: calling using SingTel IDD service (IDD is 001)
      _doTestFindInContext("0011-650-333-6000", 'SG');
      // 2nd test: calling using StarHub IDD service (IDD is 008)
      _doTestFindInContext("0081-650-333-6000", 'SG');
      // 3rd test: calling using SingTel V019 service (IDD is 019)
      _doTestFindInContext("0191-650-333-6000", 'SG');
      // Calling the US number from Poland
      _doTestFindInContext("0~01-650-333-6000", 'PL');
      // Using "++" at the start.
      _doTestFindInContext("++1 (650) 333-6000", 'PL');
      // Using a full-width plus sign.
      _doTestFindInContext("\uFF0B1 (650) 333-6000", 'SG');
      // The whole number, including punctuation, is here represented in full-width
      // form.
      _doTestFindInContext(
          "\uFF0B\uFF11\u3000\uFF08"
              "\uFF16\uFF15\uFF10"
              "\uFF09\u3000\uFF13\uFF13"
              "\uFF13\uFF0D\uFF16\uFF10\uFF10\uFF10",
          'SG');
    });

    /// See [PhoneNumberUtilTest.testParseWithLeadingZero()].
    test('testFindWithLeadingZero', () {
      _doTestFindInContext("+39 02-36618 300", 'NZ');
      _doTestFindInContext("02-36618 300", 'IT');
      _doTestFindInContext("312 345 678", 'IT');
    });

    /// See [PhoneNumberUtilTest.testParseNationalNumberArgentina()]}.
    test('testFindNationalNumberArgentina', () {
      // Test parsing mobile numbers of Argentina.
      _doTestFindInContext("+54 9 343 555 1212", 'AR');
      _doTestFindInContext("0343 15 555 1212", 'AR');

      _doTestFindInContext("+54 9 3715 65 4320", 'AR');
      _doTestFindInContext("03715 15 65 4320", 'AR');

      // Test parsing fixed-line numbers of Argentina.
      _doTestFindInContext("+54 11 3797 0000", 'AR');
      _doTestFindInContext("011 3797 0000", 'AR');

      _doTestFindInContext("+54 3715 65 4321", 'AR');
      _doTestFindInContext("03715 65 4321", 'AR');

      _doTestFindInContext("+54 23 1234 0000", 'AR');
      _doTestFindInContext("023 1234 0000", 'AR');
    });

    /// See [PhoneNumberUtilTest.testParseWithXInNumber()]}.
    test('testFindWithXInNumber', () {
      _doTestFindInContext("(0xx) 123456789", 'AR');
      // A case where x denotes both carrier codes and extension symbol.
      _doTestFindInContext("(0xx) 123456789 x 1234", 'AR');

      // This test is intentionally constructed such that the number of digit after xx
      // is larger than
      // 7, so that the number won't be mistakenly treated as an extension, as we
      // allow extensions up
      // to 7 digits. This assumption is okay for now as all the countries where a
      // carrier selection
      // code is written in the form of xx have a national significant number of
      // length larger than 7.
      _doTestFindInContext("011xx5481429712", 'US');
    });

    /// [PhoneNumberUtilTest.testParseNumbersMexico()].
    test('testFindNumbersMexico', () {
      // Test parsing fixed-line numbers of Mexico.
      _doTestFindInContext("+52 (449)978-0001", 'MX');
      _doTestFindInContext("01 (449)978-0001", 'MX');
      _doTestFindInContext("(449)978-0001", 'MX');

      // Test parsing mobile numbers of Mexico.
      _doTestFindInContext("+52 1 33 1234-5678", 'MX');
      _doTestFindInContext("044 (33) 1234-5678", 'MX');
      _doTestFindInContext("045 33 1234-5678", 'MX');
    });

    /// See [PhoneNumberUtilTest#testParseNumbersWithPlusWithNoRegion()].
    test('testFindNumbersWithPlusWithNoRegion', () {
      // ZZ is allowed only if the number starts with a '+' - then the
      // country code can be
      // calculated.
      _doTestFindInContext("+64 3 331 6005", 'ZZ');
    });

    /// See {@link PhoneNumberUtilTest#testParseExtensions()}.
    test('testFindExtensions', () {
      _doTestFindInContext("03 331 6005 ext 3456", 'NZ');
      _doTestFindInContext("03-3316005x3456", 'NZ');
      _doTestFindInContext("03-3316005 int.3456", 'NZ');
      _doTestFindInContext("03 3316005 #3456", 'NZ');
      _doTestFindInContext("0~0 1800 7493 524", 'PL');
      _doTestFindInContext("(1800) 7493.524", 'US');
      // Check that the last instance of an extension token is matched.
      _doTestFindInContext("0~0 1800 7493 524 ~1234", 'PL');
      // Verifying bug-fix where the last digit of a number was previously omitted if
      // it was a 0 when
      // extracting the extension. Also verifying a few different cases of extensions.
      _doTestFindInContext("+44 2034567890x456", 'NZ');
      _doTestFindInContext("+44 2034567890x456", 'GB');
      _doTestFindInContext("+44 2034567890 x456", 'GB');
      _doTestFindInContext("+44 2034567890 X456", 'GB');
      _doTestFindInContext("+44 2034567890 X 456", 'GB');
      _doTestFindInContext("+44 2034567890 X  456", 'GB');
      _doTestFindInContext("+44 2034567890  X 456", 'GB');

      _doTestFindInContext("(800) 901-3355 x 7246433", 'US');
      _doTestFindInContext("(800) 901-3355 , ext 7246433", 'US');
      _doTestFindInContext("(800) 901-3355 ,extension 7246433", 'US');
      // The next test differs from PhoneNumberUtil -> when matching we don't consider
      // a lone comma to
      // indicate an extension, although we accept it when parsing.
      _doTestFindInContext("(800) 901-3355 ,x 7246433", 'US');
      _doTestFindInContext("(800) 901-3355 ext: 7246433", 'US');
    });

    test('testFindInterspersedWithSpace', () {
      _doTestFindInContext("0 3   3 3 1   6 0 0 5", 'NZ');
    });

    /// Test matching behavior when starting in the middle of a phone number.
    test('testIntermediateParsePositions', () {
      String text = "Call 033316005  or 032316005!";
      // | | | | | |
      // 0 5 10 15 20 25

      // Iterate over all possible indices.
      for (int i = 0; i <= 5; i++) {
        _assertEqualRange(text, i, 5, 14);
      }
      // 7 and 8 digits in a row are still parsed as number.
      _assertEqualRange(text, 6, 6, 14);
      _assertEqualRange(text, 7, 7, 14);
      // Anything smaller is skipped to the second instance.
      for (int i = 8; i <= 19; i++) {
        _assertEqualRange(text, i, 19, 28);
      }
    });

    test('testFourMatchesInARow', () {
      String number1 = "415-666-7777";
      String number2 = "800-443-1223";
      String number3 = "212-443-1223";
      String number4 = "650-443-1223";
      String text = "$number1 - $number2 - $number3 - $number4";

      Iterator<PhoneNumberMatch> iterator =
          phoneUtil.findNumbers(text, 'US').iterator;

      PhoneNumberMatch? match = iterator.moveNext() ? iterator.current : null;
      _assertMatchProperties(match, text, number1, 'US');

      match = iterator.moveNext() ? iterator.current : null;
      _assertMatchProperties(match, text, number2, 'US');

      match = iterator.moveNext() ? iterator.current : null;
      _assertMatchProperties(match, text, number3, 'US');

      match = iterator.moveNext() ? iterator.current : null;
      _assertMatchProperties(match, text, number4, 'US');
    });

    test('testMatchesFoundWithMultipleSpaces', () {
      String number1 = "(415) 666-7777";
      String number2 = "(800) 443-1223";
      String text = "$number1 $number2";

      Iterator<PhoneNumberMatch> iterator =
          phoneUtil.findNumbers(text, 'US').iterator;
      PhoneNumberMatch? match = iterator.moveNext() ? iterator.current : null;
      _assertMatchProperties(match, text, number1, 'US');

      match = iterator.moveNext() ? iterator.current : null;
      _assertMatchProperties(match, text, number2, 'US');
    });

    test('testMatchWithSurroundingZipcodes', () {
      String number = "415-666-7777";
      String zipPreceding = "My address is CA 34215 - $number is my number.";

      Iterator<PhoneNumberMatch> iterator =
          phoneUtil.findNumbers(zipPreceding, 'US').iterator;
      PhoneNumberMatch? match = iterator.moveNext() ? iterator.current : null;
      _assertMatchProperties(match, zipPreceding, number, 'US');

      // Now repeat, but this time the phone number has spaces in it.
      // It should still be found.
      number = "(415) 666 7777";

      String zipFollowing = "My number is $number. 34215 is my zip-code.";
      iterator = phoneUtil.findNumbers(zipFollowing, 'US').iterator;
      PhoneNumberMatch? matchWithSpaces =
          iterator.moveNext() ? iterator.current : null;
      _assertMatchProperties(matchWithSpaces, zipFollowing, number, 'US');
    });

    test('testIsLatinLetter', () {
      expect(PhoneNumberMatcherImpl.isLatinLetter('c'), true);
      expect(PhoneNumberMatcherImpl.isLatinLetter('C'), true);
      expect(PhoneNumberMatcherImpl.isLatinLetter('\u00C9'), true);
      expect(PhoneNumberMatcherImpl.isLatinLetter('\u0301'),
          true); // Combining acute accent
      // Punctuation, digits and white-space are not considered "latin letters".
      expect(PhoneNumberMatcherImpl.isLatinLetter(':'), false);
      expect(PhoneNumberMatcherImpl.isLatinLetter('5'), false);
      expect(PhoneNumberMatcherImpl.isLatinLetter('-'), false);
      expect(PhoneNumberMatcherImpl.isLatinLetter('.'), false);
      expect(PhoneNumberMatcherImpl.isLatinLetter(' '), false);
      expect(PhoneNumberMatcherImpl.isLatinLetter('\u6211'),
          false); // Chinese character
      expect(PhoneNumberMatcherImpl.isLatinLetter('\u306E'),
          false); // Hiragana letter no
    });

    test('testMatchesWithSurroundingLatinChars', () {
      List<_NumberContext> possibleOnlyContexts = <_NumberContext>[];
      possibleOnlyContexts.add(_NumberContext("abc", "def"));
      possibleOnlyContexts.add(_NumberContext("abc", ""));
      possibleOnlyContexts.add(_NumberContext("", "def"));
      // Latin capital letter e with an acute accent.
      possibleOnlyContexts.add(_NumberContext("\u00C9", ""));
      // e with an acute accent decomposed (with combining mark).
      possibleOnlyContexts.add(_NumberContext("e\u0301", ""));

      // Numbers should not be considered valid, if they are surrounded by Latin
      // characters, but should be considered possible.
      _findMatchesInContexts(possibleOnlyContexts, false, true);
    });

    test('testMoneyNotSeenAsPhoneNumber', () {
      List<_NumberContext> possibleOnlyContexts = <_NumberContext>[];
      possibleOnlyContexts.add(_NumberContext("\$", ""));
      possibleOnlyContexts.add(_NumberContext("", "\$"));
      possibleOnlyContexts.add(_NumberContext("\u00A3", "")); // Pound sign
      possibleOnlyContexts.add(_NumberContext("\u00A5", "")); // Yen sign
      _findMatchesInContexts(possibleOnlyContexts, false, true);
    });

    test('testPercentageNotSeenAsPhoneNumber', () {
      List<_NumberContext> possibleOnlyContexts = <_NumberContext>[];
      possibleOnlyContexts.add(_NumberContext("", "%"));
      // Numbers followed by % should be dropped.
      _findMatchesInContexts(possibleOnlyContexts, false, true);
    });

    test('testPhoneNumberWithLeadingOrTrailingMoneyMatches', () {
      // Because of the space after the 20 (or before the 100)
      // these dollar amounts should not stop the actual number from being found.
      List<_NumberContext> contexts = <_NumberContext>[];
      contexts.add(_NumberContext("\$20 ", ""));
      contexts.add(_NumberContext("", " 100\$"));
      _findMatchesInContexts(contexts, true, true);
    });

    test('testMatchesWithSurroundingLatinCharsAndLeadingPunctuation', () {
      // Contexts with trailing characters. Leading characters are okay here since the
      // numbers we will
      // insert start with punctuation, but trailing characters are still not allowed.
      List<_NumberContext> possibleOnlyContexts = <_NumberContext>[];
      possibleOnlyContexts.add(_NumberContext("abc", "def"));
      possibleOnlyContexts.add(_NumberContext("", "def"));
      possibleOnlyContexts.add(_NumberContext("", "\u00C9"));

      // Numbers should not be considered valid, if they have trailing Latin
      // characters, but should be considered possible.
      String numberWithPlus = "+14156667777";
      String numberWithBrackets = "(415)6667777";
      _findMatchesInContexts(
          possibleOnlyContexts, false, true, 'US', numberWithPlus);
      _findMatchesInContexts(
          possibleOnlyContexts, false, true, 'US', numberWithBrackets);

      List<_NumberContext> validContexts = <_NumberContext>[];
      validContexts.add(_NumberContext("abc", ""));
      validContexts.add(_NumberContext("\u00C9", ""));
      validContexts.add(_NumberContext("\u00C9", ".")); // Trailing punctuation.
      validContexts
          .add(_NumberContext("\u00C9", " def")); // Trailing white-space.

      // Numbers should be considered valid, since they start with punctuation.
      _findMatchesInContexts(validContexts, true, true, 'US', numberWithPlus);
      _findMatchesInContexts(
          validContexts, true, true, 'US', numberWithBrackets);
    });

    test('testMatchesWithSurroundingChineseChars', () {
      List<_NumberContext> validContexts = <_NumberContext>[];
      validContexts.add(
          _NumberContext("\u6211\u7684\u7535\u8BDD\u53F7\u7801\u662F", ""));
      validContexts.add(
          _NumberContext("", "\u662F\u6211\u7684\u7535\u8BDD\u53F7\u7801"));
      validContexts.add(
          _NumberContext("\u8BF7\u62E8\u6253", "\u6211\u5728\u660E\u5929"));

      // Numbers should be considered valid, since they are surrounded by Chinese.
      _findMatchesInContexts(validContexts, true, true);
    });

    test('testMatchesWithSurroundingPunctuation', () {
      List<_NumberContext> validContexts = <_NumberContext>[];
      validContexts.add(_NumberContext("My number-", "")); // At end of text.
      validContexts.add(_NumberContext("", ".Nice day.")); // At start of text.
      validContexts
          .add(_NumberContext("Tel:", ".")); // Punctuation surrounds number.
      validContexts.add(_NumberContext(
          "Tel: ", " on Saturdays.")); // White-space is also fine.

      // Numbers should be considered valid, since they are surrounded by punctuation.
      _findMatchesInContexts(validContexts, true, true);
    });

    test('testMatchesMultiplePhoneNumbersSeparatedByPhoneNumberPunctuation',
        () {
      String text = "Call 650-253-4561 -- 455-234-3451";
      String region = 'US';

      PhoneNumber number1 = PhoneNumber();
      number1
        ..countryCode = phoneUtil.getCountryCodeForRegion(region)
        ..nationalNumber = Int64(6502534561);
      PhoneNumberMatch match1 = PhoneNumberMatch(5, "650-253-4561", number1);

      PhoneNumber number2 = PhoneNumber();
      number2
        ..countryCode = phoneUtil.getCountryCodeForRegion(region)
        ..nationalNumber = Int64(4552343451);
      PhoneNumberMatch match2 = PhoneNumberMatch(21, "455-234-3451", number2);

      Iterator<PhoneNumberMatch> matches =
          phoneUtil.findNumbers(text, region).iterator;

      expect(matches.current, match1);
      expect(matches.current, match2);
    });

    test('testDoesNotMatchMultiplePhoneNumbersSeparatedWithNoWhiteSpace', () {
      // No white-space found between numbers - neither is found.
      String text = "Call 650-253-4561--455-234-3451";
      String region = 'US';

      expect(__hasNoMatches(phoneUtil.findNumbers(text, region)), true);
    });

    test('testMatchesWithPossibleLeniency', () {
      List<_NumberTest> testCases = <_NumberTest>[];
      testCases.addAll(_strictGroupingCases);
      testCases.addAll(_exactGroupingCases);
      testCases.addAll(_validCases);
      testCases.addAll(_possibleOnlyCases);
      _doTestNumberMatchesForLeniency(testCases, Leniency.possible);
    });

    test('testNonMatchesWithPossibleLeniency', () {
      List<_NumberTest> testCases = <_NumberTest>[];
      testCases.addAll(_impossibleCases);
      _doTestNumberNonMatchesForLeniency(testCases, Leniency.possible);
    });

    test('testMatchesWithValidLeniency', () {
      List<_NumberTest> testCases = <_NumberTest>[];
      testCases.addAll(_strictGroupingCases);
      testCases.addAll(_exactGroupingCases);
      testCases.addAll(_validCases);
      _doTestNumberMatchesForLeniency(testCases, Leniency.valid);
    });

    test('testNonMatchesWithValidLeniency', () {
      List<_NumberTest> testCases = <_NumberTest>[];
      testCases.addAll(_impossibleCases);
      testCases.addAll(_possibleOnlyCases);
      _doTestNumberNonMatchesForLeniency(testCases, Leniency.valid);
    });

    test('testMatchesWithStrictGroupingLeniency', () {
      List<_NumberTest> testCases = <_NumberTest>[];
      testCases.addAll(_strictGroupingCases);
      testCases.addAll(_exactGroupingCases);
      _doTestNumberMatchesForLeniency(testCases, Leniency.strictGrouping);
    });

    test('testNonMatchesWithStrictGroupLeniency', () {
      List<_NumberTest> testCases = <_NumberTest>[];
      testCases.addAll(_impossibleCases);
      testCases.addAll(_possibleOnlyCases);
      testCases.addAll(_validCases);
      _doTestNumberNonMatchesForLeniency(testCases, Leniency.strictGrouping);
    });

    test('testMatchesWithExactGroupingLeniency', () {
      List<_NumberTest> testCases = <_NumberTest>[];
      testCases.addAll(_exactGroupingCases);
      _doTestNumberMatchesForLeniency(testCases, Leniency.exactGrouping);
    });

    test('testNonMatchesExactGroupLeniency', () {
      List<_NumberTest> testCases = <_NumberTest>[];
      testCases.addAll(_impossibleCases);
      testCases.addAll(_possibleOnlyCases);
      testCases.addAll(_validCases);
      testCases.addAll(_strictGroupingCases);
      _doTestNumberNonMatchesForLeniency(testCases, Leniency.exactGrouping);
    });

    test('testNonMatchingBracketsAreInvalid', () {
      // The digits up to the ", " form a valid US number, but it shouldn't be matched
      // as one since there was a non-matching bracket present.
      expect(
          _hasNoMatches(phoneUtil.findNumbers("80.585 [79.964, 81.191]", 'US')),
          true);

      // The trailing "]" is thrown away before parsing, so the resultant number,
      // while a valid US number, does not have matching brackets.
      expect(
          _hasNoMatches(phoneUtil.findNumbers("80.585 [79.964]", 'US')), true);

      expect(
          _hasNoMatches(phoneUtil.findNumbers("80.585 ((79.964)", 'US')), true);

      // This case has too many sets of brackets to be valid.
      expect(
          _hasNoMatches(phoneUtil.findNumbers("(80).(585) (79).(9)64", 'US')),
          true);
    });

    test('testNoMatchIfRegionIsEmpty', () {
      // Fail on non-international prefix if region code is empty.
      expect(
          _hasNoMatches(phoneUtil.findNumbers(
              "Random text body - number is 0331 6005, see you there", '')),
          true);
    });

    test('testNoMatchInEmptyString', () {
      expect(_hasNoMatches(phoneUtil.findNumbers("", 'US')), true);
      expect(_hasNoMatches(phoneUtil.findNumbers("  ", 'US')), true);
    });

    test('testNoMatchIfNoNumber', () {
      expect(
          _hasNoMatches(phoneUtil.findNumbers(
              "Random text body - number is foobar, see you there", 'US')),
          true);
    });

    test('testSequences', () {
      // Test multiple occurrences.
      String text = "Call 033316005  or 032316005!";
      String region = 'NZ';

      PhoneNumber number1 = PhoneNumber();
      number1
        ..countryCode = phoneUtil.getCountryCodeForRegion(region)
        ..nationalNumber = Int64(33316005);
      PhoneNumberMatch match1 = PhoneNumberMatch(5, "033316005", number1);

      PhoneNumber number2 = PhoneNumber();
      number2
        ..countryCode = phoneUtil.getCountryCodeForRegion(region)
        ..nationalNumber = Int64(32316005);
      PhoneNumberMatch match2 = PhoneNumberMatch(19, "032316005", number2);

      Iterator<PhoneNumberMatch> matches =
          phoneUtil.findNumbers(text, region, Leniency.possible).iterator;

      expect(matches.current, match1);
      expect(matches.current, match2);
    });

    test('testEmptyInput', () {
      expect(_hasNoMatches(phoneUtil.findNumbers('', 'US')), true);
      expect(_hasNoMatches(phoneUtil.findNumbers('', '')), true);
    });

    test('testMaxMatches', () {
      // Set up text with 100 valid phone numbers.
      StringBuffer numbers = StringBuffer();
      for (int i = 0; i < 100; i++) {
        numbers.write("My info: 415-666-7777,");
      }

      // Matches all 100. Max only applies to failed cases.
      List<PhoneNumber> expected = <PhoneNumber>[];
      PhoneNumber number = phoneUtil.parse("+14156667777", null);
      for (int i = 0; i < 100; i++) {
        expected.add(number);
      }

      Iterable<PhoneNumberMatch> iterable = phoneUtil.findNumbers(
          numbers.toString(), 'US', Leniency.valid, Int64(10));
      List<PhoneNumber> actual = <PhoneNumber>[];
      for (PhoneNumberMatch match in iterable) {
        actual.add(match.number);
      }
      expect(actual, expected);
    });

    test('testMaxMatchesInvalid', () {
      // Set up text with 10 invalid phone numbers followed by 100 valid.
      StringBuffer numbers = StringBuffer();
      for (int i = 0; i < 10; i++) {
        numbers.write("My address 949-8945-0");
      }
      for (int i = 0; i < 100; i++) {
        numbers.write("My info: 415-666-7777,");
      }

      Iterable<PhoneNumberMatch> iterable = phoneUtil.findNumbers(
          numbers.toString(), 'US', Leniency.valid, Int64(10));
      expect(iterable.iterator.moveNext(), false);
    });

    test('testMaxMatchesMixed', () {
      // Set up text with 100 valid numbers inside an invalid number.
      StringBuffer numbers = StringBuffer();
      for (int i = 0; i < 100; i++) {
        numbers.write("My info: 415-666-7777 123 fake street");
      }

      // Only matches the first 10 despite there being 100 numbers due to max matches.
      List<PhoneNumber> expected = <PhoneNumber>[];
      PhoneNumber number = phoneUtil.parse("+14156667777", null);
      for (int i = 0; i < 10; i++) {
        expected.add(number);
      }

      Iterable<PhoneNumberMatch> iterable = phoneUtil.findNumbers(
          numbers.toString(), 'US', Leniency.valid, Int64(10));
      List<PhoneNumber> actual = <PhoneNumber>[];
      for (PhoneNumberMatch match in iterable) {
        actual.add(match.number);
      }
      expect(actual, expected);
    });

    test('testNonPlusPrefixedNumbersNotFoundForInvalidRegion', () {
      // Does not start with a "+", we won't match it.
      Iterable<PhoneNumberMatch> iterable =
          phoneUtil.findNumbers("1 456 764 156", 'ZZ');
      Iterator<PhoneNumberMatch> iterator = iterable.iterator;

      expect(iterator.moveNext(), false);
      try {
        iterator.current;
        fail("Violation of the Iterator contract.");
      } catch (_) {
        /* Success */
      }
      expect(iterator.moveNext(), false);
    });

    test('testEmptyIteration', () {
      Iterable<PhoneNumberMatch> iterable = phoneUtil.findNumbers("", 'ZZ');
      Iterator<PhoneNumberMatch> iterator = iterable.iterator;

      expect(iterator.moveNext(), false);
      expect(iterator.moveNext(), false);
      try {
        iterator.current;
        fail("Violation of the Iterator contract.");
      } catch (_) {
        /* Success */
      }
      expect(iterator.moveNext(), false);
    });

    test('testSingleIteration', () {
      Iterable<PhoneNumberMatch> iterable =
          phoneUtil.findNumbers("+14156667777", 'ZZ');

      // With hasNext() -> next().
      Iterator<PhoneNumberMatch> iterator = iterable.iterator;
      // Double hasNext() to ensure it does not advance.
      expect(iterator.moveNext(), true);
      expect(iterator.moveNext(), true);
      expect(iterator.current, isNotNull);
      expect(iterator.moveNext(), false);
      try {
        iterator.current;
        fail("Violation of the Iterator contract.");
      } catch (_) {
        /* Success */
      }
      expect(iterator.moveNext(), false);

      // With next() only.
      iterator = iterable.iterator;
      expect(iterator.current, isNotNull);
      try {
        iterator.current;
        fail("Violation of the Iterator contract.");
      } catch (_) {
        /* Success */
      }
    });

    test('testDoubleIteration', () {
      Iterable<PhoneNumberMatch> iterable =
          phoneUtil.findNumbers("+14156667777 foobar +14156667777 ", 'ZZ');

      // With hasNext() -> next().
      Iterator<PhoneNumberMatch> iterator = iterable.iterator;
      // Double hasNext() to ensure it does not advance.
      expect(iterator.moveNext(), true);
      expect(iterator.moveNext(), true);
      expect(iterator.current, isNotNull);
      expect(iterator.moveNext(), true);
      expect(iterator.moveNext(), true);
      expect(iterator.current, isNotNull);
      expect(iterator.moveNext(), false);
      try {
        iterator.current;
        fail("Violation of the Iterator contract.");
      } catch (_) {
        /* Success */
      }
      expect(iterator.moveNext(), false);

      // With next() only.
      iterator = iterable.iterator;
      expect(iterator.current, isNotNull);
      expect(iterator.current, isNotNull);
      try {
        iterator.current;
        fail("Violation of the Iterator contract.");
      } catch (_) {
        /* Success */
      }
    });

//
  });
}

/// Small class that holds the context of the number we are testing against. The
/// test will
/// insert the phone number to be found between leadingText and trailingText.
class _NumberContext {
  final String leadingText;
  final String trailingText;

  const _NumberContext(this.leadingText, this.trailingText);
}

/// Small class that holds the number we want to test and the region for which it
/// should be valid.
class _NumberTest {
  final String rawString;
  final String region;

  _NumberTest(this.rawString, this.region);

  @override
  String toString() {
    return "$rawString ($region)";
  }
}

/// Tests numbers found by
/// [PhoneNumberUtil.findNumbers(String, String)] in various
/// textual contexts.
///
/// [number] the number to test and the corresponding region code to use
void _doTestFindInContext(String number, String defaultCountry) {
  _findPossibleInContext(number, defaultCountry);

  PhoneNumber parsed = phoneUtil.parse(number, defaultCountry);

  if (phoneUtil.isValidNumber(parsed)) {
    _findValidInContext(number, defaultCountry);
  }
}

/// Tests valid numbers in contexts that should pass for
/// [Leniency.possible].
void _findPossibleInContext(String number, String defaultCountry) {
  List<_NumberContext> contextPairs = <_NumberContext>[];

  contextPairs.add(_NumberContext("", "")); // no context
  contextPairs.add(_NumberContext("   ", "\t")); // whitespace only
  contextPairs.add(_NumberContext("Hello ", "")); // no context at end
  contextPairs.add(_NumberContext("", " to call me!")); // no context at start
  contextPairs.add(_NumberContext(
      "Hi there, call ", " to reach me!")); // no context at start
  contextPairs
      .add(_NumberContext("Hi there, call ", ", or don't")); // with commas
  // Three examples without whitespace around the number.
  contextPairs.add(_NumberContext("Hi call", ""));
  contextPairs.add(_NumberContext("", "forme"));
  contextPairs.add(_NumberContext("Hi call", "forme"));
  // With other small numbers.
  contextPairs.add(_NumberContext("It's cheap! Call ", " before 6:30"));
  // With a second number later.
  contextPairs.add(_NumberContext("Call ", " or +1800-123-4567!"));
  contextPairs
      .add(_NumberContext("Call me on June 2 at", "")); // with a Month-Day date
  // With publication pages.
  contextPairs.add(_NumberContext(
      "As quoted by Alfonso 12-15 (2009), you may call me at ", ""));
  contextPairs.add(_NumberContext(
      "As quoted by Alfonso et al. 12-15 (2009), you may call me at ", ""));
  // With dates, written in the American style.
  contextPairs
      .add(_NumberContext("As I said on 03/10/2011, you may call me at ", ""));
  // With trailing numbers after a comma. The 45 should not be considered an
  // extension.
  contextPairs.add(_NumberContext("", ", 45 days a year"));
  // When matching we don't consider semicolon along with legitimate extension
  // symbol to indicate
  // an extension. The 7246433 should not be considered an extension.
  contextPairs.add(_NumberContext("", ";x 7246433"));
  // With a postfix stripped off as it looks like the start of another number.
  contextPairs.add(_NumberContext("Call ", "/x12 more"));

  _doTestInContext(number, defaultCountry, contextPairs, Leniency.possible);
}

void _doTestInContext(String number, String defaultCountry,
    List<_NumberContext> contextPairs, Leniency leniency) {
  for (_NumberContext context in contextPairs) {
    String prefix = context.leadingText;
    String text = prefix + number + context.trailingText;

    int start = prefix.length;
    int end = start + number.length;

    Iterator<PhoneNumberMatch> iterator =
        phoneUtil.findNumbers(text, defaultCountry, leniency).iterator;

    PhoneNumberMatch? match = iterator.moveNext() ? iterator.current : null;

    expect(match, isNotNull,
        reason: "Did not find a number in '$text'; expected '$number'");

    String extracted = text.substring(match!.start, match.end);

    expect(
      (start == match.start) && (end == match.end),
      true,
      reason: "Unexpected phone region in '$text'; extracted '$extracted'",
    );

    expect(number == extracted, true);
    expect(match.rawString == extracted, true);

    _ensureTermination(text, defaultCountry, leniency);
  }
}

/// Exhaustively searches for phone numbers from each index within [text]
/// to test that finding matches always terminates.
void _ensureTermination(String text, String defaultCountry, Leniency leniency) {
  for (int index = 0; index <= text.length; index++) {
    final String sub = text.substring(index);
    final StringBuffer matches = StringBuffer();
    // Iterates over all matches.

    final Iterable<PhoneNumberMatch> phoneNumberMatches =
        phoneUtil.findNumbers(sub, defaultCountry, leniency);

    for (PhoneNumberMatch match in phoneNumberMatches) {
      matches
        ..write(", ")
        ..write(match.toString());
    }
  }
}

/// Tests valid numbers in contexts that fail for [Leniency.possible] but
/// are valid for [Leniency.valid].
void _findValidInContext(String number, String defaultCountry) {
  List<_NumberContext> contextPairs = <_NumberContext>[];
  // With other small numbers.
  contextPairs.add(_NumberContext("It's only 9.99! Call ", " to buy"));
  // With a number Day.Month.Year date.
  contextPairs.add(_NumberContext("Call me on 21.6.1984 at ", ""));
  // With a number Month/Day date.
  contextPairs.add(_NumberContext("Call me on 06/21 at ", ""));
  // With a number Day.Month date.
  contextPairs.add(_NumberContext("Call me on 21.6. at ", ""));
  // With a number Month/Day/Year date.
  contextPairs.add(_NumberContext("Call me on 06/21/84 at ", ""));

  _doTestInContext(number, defaultCountry, contextPairs, Leniency.valid);
}

/// Asserts that another number can be found in [text]
/// starting at [index], and that
/// its corresponding range is [start, end].
void _assertEqualRange(String text, int index, int start, int end) {
  String sub = text.substring(index, text.length);
  Iterator<PhoneNumberMatch> matches =
      phoneUtil.findNumbers(sub, 'NZ', Leniency.possible).iterator;
  expect(matches.moveNext(), true);
  PhoneNumberMatch match = matches.current;
  expect(start - index, match.start);
  expect(end - index, match.end);
  expect(sub.substring(match.start, match.end).toString(), match.rawString);
}

/// Asserts that the expected match is non-null, and that the raw string
/// and expected proto buffer are set appropriately.
void _assertMatchProperties(
    PhoneNumberMatch? match, String text, String number, String region) {
  PhoneNumber expectedResult = phoneUtil.parse(number, region);
  expect(match, isNotNull,
      reason: "Did not find a number in '$text'; expected $number");
  expect(match!.number.countryCode, expectedResult.countryCode);
  expect(match.number.nationalNumber, expectedResult.nationalNumber);
  expect(match.rawString, number);
}

/// Helper method which tests the contexts provided and ensures that:
/// -- if isValid is true, they all find a test number inserted in the middle
/// when leniency of
/// matching is set to VALID; else no test number should be extracted at that
/// leniency level
/// -- if isPossible is true, they all find a test number inserted in the middle
/// when leniency of
/// matching is set to POSSIBLE; else no test number should be extracted at that
/// leniency level
void _findMatchesInContexts(
  List<_NumberContext> contexts,
  bool isValid,
  bool isPossible, [
  String region = 'US',
  String number = "415-666-7777",
]) {
  if (isValid) {
    _doTestInContext(number, region, contexts, Leniency.valid);
  } else {
    for (_NumberContext context in contexts) {
      String text = context.leadingText + number + context.trailingText;
      expect(
        __hasNoMatches(phoneUtil.findNumbers(text, region)),
        true,
        reason: "Should not have found a number in $text",
      );
    }
  }
  if (isPossible) {
    _doTestInContext(number, region, contexts, Leniency.possible);
  } else {
    for (_NumberContext context in contexts) {
      String text = context.leadingText + number + context.trailingText;
      expect(
        __hasNoMatches(phoneUtil.findNumbers(text, region, Leniency.possible)),
        true,
        reason: "Should not have found a number in $text",
      );
    }
  }
}

bool __hasNoMatches(Iterable<PhoneNumberMatch> iterable) {
  return !iterable.iterator.moveNext();
}

void _doTestNumberMatchesForLeniency(
    List<_NumberTest> testCases, Leniency leniency) {
  int noMatchFoundCount = 0;
  int wrongMatchFoundCount = 0;
  for (_NumberTest test in testCases) {
    Iterator<PhoneNumberMatch> iterator =
        _findNumbersForLeniency(test.rawString, test.region, leniency);
    PhoneNumberMatch? match = iterator.moveNext() ? iterator.current : null;
    if (match == null) {
      noMatchFoundCount++;
      print("No match found in $test for leniency: $leniency");
    } else {
      if (test.rawString != match.rawString) {
        wrongMatchFoundCount++;
        print("Found wrong match in test $test. Found ${match.rawString}");
      }
    }
  }
  expect(noMatchFoundCount, 0);
  expect(wrongMatchFoundCount, 0);
}

Iterator<PhoneNumberMatch> _findNumbersForLeniency(
    String text, String defaultCountry, Leniency leniency) {
  return phoneUtil.findNumbers(text, defaultCountry, leniency).iterator;
}

void _doTestNumberNonMatchesForLeniency(
    List<_NumberTest> testCases, Leniency leniency) {
  int matchFoundCount = 0;
  for (_NumberTest test in testCases) {
    Iterator<PhoneNumberMatch> iterator =
        _findNumbersForLeniency(test.rawString, test.region, leniency);
    PhoneNumberMatch? match = iterator.moveNext() ? iterator.current : null;
    if (match != null) {
      matchFoundCount++;
      print("Match found in $test for leniency: $leniency");
    }
  }
  expect(matchFoundCount, 0);
}

/// Strings with number-like things that shouldn't be found under any level.
final List<_NumberTest> _impossibleCases = [
  _NumberTest("12345", 'US'),
  _NumberTest("23456789", 'US'),
  _NumberTest("234567890112", 'US'),
  _NumberTest("650+253+1234", 'US'),
  _NumberTest("3/10/1984", 'CA'),
  _NumberTest("03/27/2011", 'US'),
  _NumberTest("31/8/2011", 'US'),
  _NumberTest("1/12/2011", 'US'),
  _NumberTest("10/12/82", 'DE'),
  _NumberTest("650x2531234", 'US'),
  _NumberTest("2012-01-02 08:00", 'US'),
  _NumberTest("2012/01/02 08:00", 'US'),
  _NumberTest("20120102 08:00", 'US'),
  _NumberTest("2014-04-12 04:04 PM", 'US'),
  _NumberTest("2014-04-12 &nbsp;04:04 PM", 'US'),
  _NumberTest("2014-04-12 &nbsp;04:04 PM", 'US'),
  _NumberTest("2014-04-12  04:04 PM", 'US'),
];

/// Strings with number-like things that should only be found under "possible".
final List<_NumberTest> _possibleOnlyCases = [
  // US numbers cannot start with 7 in the test metadata to be valid.
  _NumberTest("7121115678", 'US'),
  // 'X' should not be found in numbers at leniencies stricter than POSSIBLE,
  // unless it represents
  // a carrier code or extension.
  _NumberTest("1650 x 253 - 1234", 'US'),
  _NumberTest("650 x 253 - 1234", 'US'),
  _NumberTest("6502531x234", 'US'),
  _NumberTest("(20) 3346 1234", 'GB'), // Non-optional NP omitted
];

/// Strings with number-like things that should only be found up to and including
/// the "valid" leniency level.
final List<_NumberTest> _validCases = [
  _NumberTest("65 02 53 00 00", 'US'),
  _NumberTest("6502 538365", 'US'),
  _NumberTest("650//253-1234", 'US'), // 2 slashes are illegal at higher levels
  _NumberTest("650/253/1234", 'US'),
  _NumberTest("9002309. 158", 'US'),
  _NumberTest("12 7/8 - 14 12/34 - 5", 'US'),
  _NumberTest("12.1 - 23.71 - 23.45", 'US'),
  _NumberTest("800 234 1 111x1111", 'US'),
  _NumberTest("1979-2011 100", 'US'),
  _NumberTest("+494949-4-94", 'DE'), // National number in wrong format
  _NumberTest(
      "\uFF14\uFF11\uFF15\uFF16\uFF16\uFF16\uFF16-\uFF17\uFF17\uFF17", 'US'),
  _NumberTest("2012-0102 08", 'US'), // Very strange formatting.
  _NumberTest("2012-01-02 08", 'US'),
  // Breakdown assistance number with unexpected formatting.
  _NumberTest("1800-1-0-10 22", 'AU'),
  _NumberTest("030-3-2 23 12 34", 'DE'),
  _NumberTest("03 0 -3 2 23 12 34", 'DE'),
  _NumberTest("(0)3 0 -3 2 23 12 34", 'DE'),
  _NumberTest("0 3 0 -3 2 23 12 34", 'DE'),
  // Fits an alternate pattern, but the leading digits don't match.
  _NumberTest("+52 332 123 23 23", 'MX'),
];

/// Strings with number-like things that should only be found up to and including
/// the "strict_grouping" leniency level.
final List<_NumberTest> _strictGroupingCases = [
  _NumberTest("(415) 6667777", 'US'),
  _NumberTest("415-6667777", 'US'),
  // Should be found by strict grouping but not exact grouping, as the last two
  // groups are
  // formatted together as a block.
  _NumberTest("0800-2491234", 'DE'),
  // Doesn't match any formatting in the test file, but almost matches an
  // alternate format (the
  // last two groups have been squashed together here).
  _NumberTest("0900-1 123123", 'DE'),
  _NumberTest("(0)900-1 123123", 'DE'),
  _NumberTest("0 900-1 123123", 'DE'),
  // NDC also found as part of the country calling code; this shouldn't ruin the
  // grouping
  // expectations.
  _NumberTest("+33 3 34 2312", 'FR'),
];

/// Strings with number-like things that should be found at all levels.
final List<_NumberTest> _exactGroupingCases = [
  _NumberTest(
      "\uFF14\uFF11\uFF15\uFF16\uFF16\uFF16\uFF17\uFF17\uFF17\uFF17", 'US'),
  _NumberTest(
      "\uFF14\uFF11\uFF15-\uFF16\uFF16\uFF16-\uFF17\uFF17\uFF17\uFF17", 'US'),
  _NumberTest("4156667777", 'US'),
  _NumberTest("4156667777 x 123", 'US'),
  _NumberTest("415-666-7777", 'US'),
  _NumberTest("415/666-7777", 'US'),
  _NumberTest("415-666-7777 ext. 503", 'US'),
  _NumberTest("1 415 666 7777 x 123", 'US'),
  _NumberTest("+1 415-666-7777", 'US'),
  _NumberTest("+494949 49", 'DE'),
  _NumberTest("+49-49-34", 'DE'),
  _NumberTest("+49-4931-49", 'DE'),
  _NumberTest("04931-49", 'DE'), // With National Prefix
  _NumberTest("+49-494949", 'DE'), // One group with country code
  _NumberTest("+49-494949 ext. 49", 'DE'),
  _NumberTest("+49494949 ext. 49", 'DE'),
  _NumberTest("0494949", 'DE'),
  _NumberTest("0494949 ext. 49", 'DE'),
  _NumberTest("01 (33) 3461 2234", 'MX'), // Optional NP present
  _NumberTest("(33) 3461 2234", 'MX'), // Optional NP omitted
  _NumberTest("1800-10-10 22", 'AU'), // Breakdown assistance number.
  // Doesn't match any formatting in the test file, but matches an alternate
  // format exactly.
  _NumberTest("0900-1 123 123", 'DE'),
  _NumberTest("(0)900-1 123 123", 'DE'),
  _NumberTest("0 900-1 123 123", 'DE'),
  _NumberTest("+33 3 34 23 12", 'FR'),
];

bool _hasNoMatches(Iterable<PhoneNumberMatch> iterable) {
  return !iterable.iterator.moveNext();
}
