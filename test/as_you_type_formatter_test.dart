/// Copyright (C) 2010 The Libphonenumber Authors.
///
/// Licensed under the Apache License, Version 2.0 (the 'License');
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
/// http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an 'AS IS' BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
library;

import 'package:dlibphonenumber/as_you_type_formatter.dart';
import 'package:test/test.dart';

/// Unit tests for the AsYouTypeFormatter.
///
/// Note that these tests use the metadata contained in metadatafortesting.js,
/// not the normal metadata files, so should not be used for regression test
/// purposes - these tests are illustrative only and test functionality.

void main() {
  group('AsYouTypeFormatterTest', () {
    test('testInvalidRegion', () {
      final formatter = AsYouTypeFormatter('ZZ', testMode: true);
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('4'), '+4');
      expect(formatter.inputDigit('8'), '+48 ');
      expect(formatter.inputDigit('8'), '+48 8');
      expect(formatter.inputDigit('8'), '+48 88');
      expect(formatter.inputDigit('1'), '+48 88 1');
      expect(formatter.inputDigit('2'), '+48 88 12');
      expect(formatter.inputDigit('3'), '+48 88 123');
      expect(formatter.inputDigit('1'), '+48 88 123 1');
      expect(formatter.inputDigit('2'), '+48 88 123 12');

      formatter.clear();
      expect(formatter.inputDigit('6'), '6');
      expect(formatter.inputDigit('5'), '65');
      expect(formatter.inputDigit('0'), '650');
      expect(formatter.inputDigit('2'), '6502');
      expect(formatter.inputDigit('5'), '65025');
      expect(formatter.inputDigit('3'), '650253');
    });

    test('testInvalidPlusSign', () {
      final formatter = AsYouTypeFormatter('ZZ', testMode: true);
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('4'), '+4');
      expect(formatter.inputDigit('8'), '+48 ');
      expect(formatter.inputDigit('8'), '+48 8');
      expect(formatter.inputDigit('8'), '+48 88');
      expect(formatter.inputDigit('1'), '+48 88 1');
      expect(formatter.inputDigit('2'), '+48 88 12');
      expect(formatter.inputDigit('3'), '+48 88 123');
      expect(formatter.inputDigit('1'), '+48 88 123 1');
      // A plus sign can only appear at the beginning of the number
      // otherwise, no formatting is applied.
      expect(formatter.inputDigit('+'), '+48881231+');
      expect(formatter.inputDigit('2'), '+48881231+2');
    });

    test('testTooLongNumberMatchingMultipleLeadingDigits', () {
      final formatter = AsYouTypeFormatter('ZZ', testMode: true);
      // See https://github.com/google/libphonenumber/issues/36
      // The bug occurred last time for countries which have two formatting rules with
      // exactly the
      // same leading digits pattern but differ in length.
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('8'), '+8');
      expect(formatter.inputDigit('1'), '+81 ');
      expect(formatter.inputDigit('9'), '+81 9');
      expect(formatter.inputDigit('0'), '+81 90');
      expect(formatter.inputDigit('1'), '+81 90 1');

      expect(formatter.inputDigit('2'), '+81 90 12');
      expect(formatter.inputDigit('3'), '+81 90 123');
      expect(formatter.inputDigit('4'), '+81 90 1234');
      expect(formatter.inputDigit('5'), '+81 90 1234 5');
      expect(formatter.inputDigit('6'), '+81 90 1234 56');
      expect(formatter.inputDigit('7'), '+81 90 1234 567');
      expect(formatter.inputDigit('8'), '+81 90 1234 5678');
      expect(formatter.inputDigit('9'), '+81 90 12 345 6789');
      expect(formatter.inputDigit('0'), '+81901234567890');
      expect(formatter.inputDigit('1'), '+819012345678901');
    });

    test('testCountryWithSpaceInNationalPrefixFormattingRule', () {
      final formatter = AsYouTypeFormatter('BY', testMode: true);
      expect(formatter.inputDigit('8'), '8');
      expect(formatter.inputDigit('8'), '88');
      expect(formatter.inputDigit('1'), '881');
      expect(formatter.inputDigit('9'), '8 819');
      expect(formatter.inputDigit('0'), '8 8190');
      // The formatting rule for 5 digit numbers states that no space should be
      // present after the
      // national prefix.
      expect(formatter.inputDigit('1'), '881 901');
      expect(formatter.inputDigit('2'), '8 819 012');
      // Too long, no formatting rule applies.
      expect(formatter.inputDigit('3'), '88190123');
    });

    test('testCountryWithSpaceInNationalPrefixFormattingRuleAndLongNdd', () {
      final formatter = AsYouTypeFormatter('BY', testMode: true);
      expect(formatter.inputDigit('9'), '9');
      expect(formatter.inputDigit('9'), '99');
      expect(formatter.inputDigit('9'), '999');
      expect(formatter.inputDigit('9'), '9999');
      expect(formatter.inputDigit('9'), '99999 ');
      expect(formatter.inputDigit('1'), '99999 1');
      expect(formatter.inputDigit('2'), '99999 12');
      expect(formatter.inputDigit('3'), '99999 123');
      expect(formatter.inputDigit('4'), '99999 1234');
      expect(formatter.inputDigit('5'), '99999 12 345');
    });

    test('testAYTFUS', () {
      final formatter = AsYouTypeFormatter('US', testMode: true);
      expect(formatter.inputDigit('6'), '6');
      expect(formatter.inputDigit('5'), '65');
      expect(formatter.inputDigit('0'), '650');
      expect(formatter.inputDigit('2'), '650 2');
      expect(formatter.inputDigit('5'), '650 25');
      expect(formatter.inputDigit('3'), '650 253');
      // Note this is how a US local number (without area code) should be formatted.
      expect(formatter.inputDigit('2'), '650 2532');
      expect(formatter.inputDigit('2'), '650 253 22');
      expect(formatter.inputDigit('2'), '650 253 222');
      expect(formatter.inputDigit('2'), '650 253 2222');

      formatter.clear();
      expect(formatter.inputDigit('1'), '1');
      expect(formatter.inputDigit('6'), '16');
      expect(formatter.inputDigit('5'), '1 65');
      expect(formatter.inputDigit('0'), '1 650');
      expect(formatter.inputDigit('2'), '1 650 2');
      expect(formatter.inputDigit('5'), '1 650 25');
      expect(formatter.inputDigit('3'), '1 650 253');
      expect(formatter.inputDigit('2'), '1 650 253 2');
      expect(formatter.inputDigit('2'), '1 650 253 22');
      expect(formatter.inputDigit('2'), '1 650 253 222');
      expect(formatter.inputDigit('2'), '1 650 253 2222');

      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('1'), '01');
      expect(formatter.inputDigit('1'), '011 ');
      expect(formatter.inputDigit('4'), '011 4');
      expect(formatter.inputDigit('4'), '011 44 ');
      expect(formatter.inputDigit('6'), '011 44 6');
      expect(formatter.inputDigit('1'), '011 44 61');
      expect(formatter.inputDigit('2'), '011 44 6 12');
      expect(formatter.inputDigit('3'), '011 44 6 123');
      expect(formatter.inputDigit('1'), '011 44 6 123 1');
      expect(formatter.inputDigit('2'), '011 44 6 123 12');
      expect(formatter.inputDigit('3'), '011 44 6 123 123');
      expect(formatter.inputDigit('1'), '011 44 6 123 123 1');
      expect(formatter.inputDigit('2'), '011 44 6 123 123 12');
      expect(formatter.inputDigit('3'), '011 44 6 123 123 123');

      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('1'), '01');
      expect(formatter.inputDigit('1'), '011 ');
      expect(formatter.inputDigit('5'), '011 5');
      expect(formatter.inputDigit('4'), '011 54 ');
      expect(formatter.inputDigit('9'), '011 54 9');
      expect(formatter.inputDigit('1'), '011 54 91');
      expect(formatter.inputDigit('1'), '011 54 9 11');
      expect(formatter.inputDigit('2'), '011 54 9 11 2');
      expect(formatter.inputDigit('3'), '011 54 9 11 23');
      expect(formatter.inputDigit('1'), '011 54 9 11 231');
      expect(formatter.inputDigit('2'), '011 54 9 11 2312');
      expect(formatter.inputDigit('1'), '011 54 9 11 2312 1');
      expect(formatter.inputDigit('2'), '011 54 9 11 2312 12');
      expect(formatter.inputDigit('3'), '011 54 9 11 2312 123');
      expect(formatter.inputDigit('4'), '011 54 9 11 2312 1234');

      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('1'), '01');
      expect(formatter.inputDigit('1'), '011 ');
      expect(formatter.inputDigit('2'), '011 2');
      expect(formatter.inputDigit('4'), '011 24');
      expect(formatter.inputDigit('4'), '011 244 ');
      expect(formatter.inputDigit('2'), '011 244 2');
      expect(formatter.inputDigit('8'), '011 244 28');
      expect(formatter.inputDigit('0'), '011 244 280');
      expect(formatter.inputDigit('0'), '011 244 280 0');
      expect(formatter.inputDigit('0'), '011 244 280 00');
      expect(formatter.inputDigit('0'), '011 244 280 000');
      expect(formatter.inputDigit('0'), '011 244 280 000 0');
      expect(formatter.inputDigit('0'), '011 244 280 000 00');
      expect(formatter.inputDigit('0'), '011 244 280 000 000');

      formatter.clear();
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('4'), '+4');
      expect(formatter.inputDigit('8'), '+48 ');
      expect(formatter.inputDigit('8'), '+48 8');
      expect(formatter.inputDigit('8'), '+48 88');
      expect(formatter.inputDigit('1'), '+48 88 1');
      expect(formatter.inputDigit('2'), '+48 88 12');
      expect(formatter.inputDigit('3'), '+48 88 123');
      expect(formatter.inputDigit('1'), '+48 88 123 1');
      expect(formatter.inputDigit('2'), '+48 88 123 12');
      expect(formatter.inputDigit('1'), '+48 88 123 12 1');
      expect(formatter.inputDigit('2'), '+48 88 123 12 12');
    });

    test('testAYTFUSFullWidthCharacters', () {
      final formatter = AsYouTypeFormatter('US', testMode: true);
      expect(formatter.inputDigit('\uFF16'), '\uFF16');
      expect(formatter.inputDigit('\uFF15'), '\uFF16\uFF15');
      expect(formatter.inputDigit('\uFF10'), '650');
      expect(formatter.inputDigit('\uFF12'), '650 2');
      expect(formatter.inputDigit('\uFF15'), '650 25');
      expect(formatter.inputDigit('\uFF13'), '650 253');
      expect(formatter.inputDigit('\uFF12'), '650 2532');
      expect(formatter.inputDigit('\uFF12'), '650 253 22');
      expect(formatter.inputDigit('\uFF12'), '650 253 222');
      expect(formatter.inputDigit('\uFF12'), '650 253 2222');
    });

    test('testAYTFUSMobileShortCode', () {
      final formatter = AsYouTypeFormatter('US', testMode: true);
      expect(formatter.inputDigit('*'), '*');
      expect(formatter.inputDigit('1'), '*1');
      expect(formatter.inputDigit('2'), '*12');
      expect(formatter.inputDigit('1'), '*121');
      expect(formatter.inputDigit('#'), '*121#');
    });

    test('testAYTFUSVanityNumber', () {
      final formatter = AsYouTypeFormatter('US', testMode: true);
      expect(formatter.inputDigit('8'), '8');
      expect(formatter.inputDigit('0'), '80');
      expect(formatter.inputDigit('0'), '800');
      expect(formatter.inputDigit(' '), '800 ');
      expect(formatter.inputDigit('M'), '800 M');
      expect(formatter.inputDigit('Y'), '800 MY');
      expect(formatter.inputDigit(' '), '800 MY ');
      expect(formatter.inputDigit('A'), '800 MY A');
      expect(formatter.inputDigit('P'), '800 MY AP');
      expect(formatter.inputDigit('P'), '800 MY APP');
      expect(formatter.inputDigit('L'), '800 MY APPL');
      expect(formatter.inputDigit('E'), '800 MY APPLE');
    });

    test('testAYTFAndRememberPositionUS', () {
      final formatter = AsYouTypeFormatter('US', testMode: true);
      expect(formatter.inputDigitAndRememberPosition('1'), '1');
      expect(formatter.getRememberedPosition(), 1);
      expect(formatter.inputDigit('6'), '16');
      expect(formatter.inputDigit('5'), '1 65');
      expect(formatter.getRememberedPosition(), 1);
      expect(formatter.inputDigitAndRememberPosition('0'), '1 650');
      expect(formatter.getRememberedPosition(), 5);
      expect(formatter.inputDigit('2'), '1 650 2');
      expect(formatter.inputDigit('5'), '1 650 25');
      // Note the remembered position for digit '0' changes from 4 to 5, because a
      // space is now inserted in the front.
      expect(formatter.getRememberedPosition(), 5);
      expect(formatter.inputDigit('3'), '1 650 253');
      expect(formatter.inputDigit('2'), '1 650 253 2');
      expect(formatter.inputDigit('2'), '1 650 253 22');
      expect(formatter.getRememberedPosition(), 5);
      expect(formatter.inputDigitAndRememberPosition('2'), '1 650 253 222');
      expect(formatter.getRememberedPosition(), 13);
      expect(formatter.inputDigit('2'), '1 650 253 2222');
      expect(formatter.getRememberedPosition(), 13);
      expect(formatter.inputDigit('2'), '165025322222');
      expect(formatter.getRememberedPosition(), 10);
      expect(formatter.inputDigit('2'), '1650253222222');
      expect(formatter.getRememberedPosition(), 10);

      formatter.clear();
      expect(formatter.inputDigit('1'), '1');
      expect(formatter.inputDigitAndRememberPosition('6'), '16');
      expect(formatter.getRememberedPosition(), 2);
      expect(formatter.inputDigit('5'), '1 65');
      expect(formatter.inputDigit('0'), '1 650');
      expect(formatter.getRememberedPosition(), 3);
      expect(formatter.inputDigit('2'), '1 650 2');
      expect(formatter.inputDigit('5'), '1 650 25');
      expect(formatter.getRememberedPosition(), 3);
      expect(formatter.inputDigit('3'), '1 650 253');
      expect(formatter.inputDigit('2'), '1 650 253 2');
      expect(formatter.inputDigit('2'), '1 650 253 22');
      expect(formatter.getRememberedPosition(), 3);
      expect(formatter.inputDigit('2'), '1 650 253 222');
      expect(formatter.inputDigit('2'), '1 650 253 2222');
      expect(formatter.inputDigit('2'), '165025322222');
      expect(formatter.getRememberedPosition(), 2);
      expect(formatter.inputDigit('2'), '1650253222222');
      expect(formatter.getRememberedPosition(), 2);

      formatter.clear();
      expect(formatter.inputDigit('6'), '6');
      expect(formatter.inputDigit('5'), '65');
      expect(formatter.inputDigit('0'), '650');
      expect(formatter.inputDigit('2'), '650 2');
      expect(formatter.inputDigit('5'), '650 25');
      expect(formatter.inputDigit('3'), '650 253');
      expect(formatter.inputDigitAndRememberPosition('2'), '650 2532');
      expect(formatter.getRememberedPosition(), 8);
      expect(formatter.inputDigit('2'), '650 253 22');
      expect(formatter.getRememberedPosition(), 9);
      expect(formatter.inputDigit('2'), '650 253 222');
      expect(formatter.inputDigit(';'), '650253222;');
      expect(formatter.getRememberedPosition(), 7);
      expect(formatter.inputDigit('2'), '650253222;2');

      formatter.clear();
      expect(formatter.inputDigit('6'), '6');
      expect(formatter.inputDigit('5'), '65');
      expect(formatter.inputDigit('0'), '650');
      expect(formatter.inputDigit('-'), '650-');
      expect(formatter.inputDigitAndRememberPosition('2'), '650-2');
      expect(formatter.getRememberedPosition(), 5);
      expect(formatter.inputDigit('5'), '650-25');
      expect(formatter.getRememberedPosition(), 5);
      expect(formatter.inputDigit('3'), '650-253');
      expect(formatter.getRememberedPosition(), 5);
      expect(formatter.inputDigit('-'), '650-253-');
      expect(formatter.inputDigit('2'), '650-253-2');
      expect(formatter.inputDigit('2'), '650-253-22');
      expect(formatter.inputDigit('2'), '650-253-222');
      expect(formatter.inputDigit('2'), '650-253-2222');

      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('1'), '01');
      expect(formatter.inputDigit('1'), '011 ');
      expect(formatter.inputDigitAndRememberPosition('4'), '011 4');
      expect(formatter.inputDigit('8'), '011 48 ');
      expect(formatter.getRememberedPosition(), 5);
      expect(formatter.inputDigit('8'), '011 48 8');
      expect(formatter.getRememberedPosition(), 5);
      expect(formatter.inputDigit('8'), '011 48 88');
      expect(formatter.inputDigit('1'), '011 48 88 1');
      expect(formatter.inputDigit('2'), '011 48 88 12');
      expect(formatter.getRememberedPosition(), 5);
      expect(formatter.inputDigit('3'), '011 48 88 123');
      expect(formatter.inputDigit('1'), '011 48 88 123 1');
      expect(formatter.inputDigit('2'), '011 48 88 123 12');
      expect(formatter.inputDigit('1'), '011 48 88 123 12 1');
      expect(formatter.inputDigit('2'), '011 48 88 123 12 12');

      formatter.clear();
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('1'), '+1');
      expect(formatter.inputDigitAndRememberPosition('6'), '+1 6');
      expect(formatter.inputDigit('5'), '+1 65');
      expect(formatter.inputDigit('0'), '+1 650');
      expect(formatter.getRememberedPosition(), 4);
      expect(formatter.inputDigit('2'), '+1 650 2');
      expect(formatter.getRememberedPosition(), 4);
      expect(formatter.inputDigit('5'), '+1 650 25');
      expect(formatter.inputDigitAndRememberPosition('3'), '+1 650 253');
      expect(formatter.inputDigit('2'), '+1 650 253 2');
      expect(formatter.inputDigit('2'), '+1 650 253 22');
      expect(formatter.inputDigit('2'), '+1 650 253 222');
      expect(formatter.getRememberedPosition(), 10);

      formatter.clear();
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('1'), '+1');
      expect(formatter.inputDigitAndRememberPosition('6'), '+1 6');
      expect(formatter.inputDigit('5'), '+1 65');
      expect(formatter.inputDigit('0'), '+1 650');
      expect(formatter.getRememberedPosition(), 4);
      expect(formatter.inputDigit('2'), '+1 650 2');
      expect(formatter.getRememberedPosition(), 4);
      expect(formatter.inputDigit('5'), '+1 650 25');
      expect(formatter.inputDigit('3'), '+1 650 253');
      expect(formatter.inputDigit('2'), '+1 650 253 2');
      expect(formatter.inputDigit('2'), '+1 650 253 22');
      expect(formatter.inputDigit('2'), '+1 650 253 222');
      expect(formatter.inputDigit(';'), '+1650253222;');
      expect(formatter.getRememberedPosition(), 3);
    });

    test('testAYTFGBFixedLine', () {
      final formatter = AsYouTypeFormatter('GB', testMode: true);
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('2'), '02');
      expect(formatter.inputDigit('0'), '020');
      expect(formatter.inputDigitAndRememberPosition('7'), '020 7');
      expect(formatter.getRememberedPosition(), 5);
      expect(formatter.inputDigit('0'), '020 70');
      expect(formatter.inputDigit('3'), '020 703');
      expect(formatter.getRememberedPosition(), 5);
      expect(formatter.inputDigit('1'), '020 7031');
      expect(formatter.inputDigit('3'), '020 7031 3');
      expect(formatter.inputDigit('0'), '020 7031 30');
      expect(formatter.inputDigit('0'), '020 7031 300');
      expect(formatter.inputDigit('0'), '020 7031 3000');
    });

    test('testAYTFGBTollFree', () {
      final formatter = AsYouTypeFormatter('GB', testMode: true);
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('8'), '08');
      expect(formatter.inputDigit('0'), '080');
      expect(formatter.inputDigit('7'), '080 7');
      expect(formatter.inputDigit('0'), '080 70');
      expect(formatter.inputDigit('3'), '080 703');
      expect(formatter.inputDigit('1'), '080 7031');
      expect(formatter.inputDigit('3'), '080 7031 3');
      expect(formatter.inputDigit('0'), '080 7031 30');
      expect(formatter.inputDigit('0'), '080 7031 300');
      expect(formatter.inputDigit('0'), '080 7031 3000');
    });

    test('testAYTFGBPremiumRate', () {
      final formatter = AsYouTypeFormatter('GB', testMode: true);
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('9'), '09');
      expect(formatter.inputDigit('0'), '090');
      expect(formatter.inputDigit('7'), '090 7');
      expect(formatter.inputDigit('0'), '090 70');
      expect(formatter.inputDigit('3'), '090 703');
      expect(formatter.inputDigit('1'), '090 7031');
      expect(formatter.inputDigit('3'), '090 7031 3');
      expect(formatter.inputDigit('0'), '090 7031 30');
      expect(formatter.inputDigit('0'), '090 7031 300');
      expect(formatter.inputDigit('0'), '090 7031 3000');
    });

    test('testAYTFNZMobile', () {
      final formatter = AsYouTypeFormatter('NZ', testMode: true);
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('2'), '02');
      expect(formatter.inputDigit('1'), '021');
      expect(formatter.inputDigit('1'), '02-11');
      expect(formatter.inputDigit('2'), '02-112');
      // Note the unittest is using fake metadata
      // which might produce non-idealresults.
      expect(formatter.inputDigit('3'), '02-112 3');
      expect(formatter.inputDigit('4'), '02-112 34');
      expect(formatter.inputDigit('5'), '02-112 345');
      expect(formatter.inputDigit('6'), '02-112 3456');
    });

    test('testAYTFDE', () {
      final formatter = AsYouTypeFormatter('DE', testMode: true);
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('3'), '03');
      expect(formatter.inputDigit('0'), '030');
      expect(formatter.inputDigit('1'), '030/1');
      expect(formatter.inputDigit('2'), '030/12');
      expect(formatter.inputDigit('3'), '030/123');
      expect(formatter.inputDigit('4'), '030/1234');

      // 04134 1234
      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('4'), '04');
      expect(formatter.inputDigit('1'), '041');
      expect(formatter.inputDigit('3'), '041 3');
      expect(formatter.inputDigit('4'), '041 34');
      expect(formatter.inputDigit('1'), '04134 1');
      expect(formatter.inputDigit('2'), '04134 12');
      expect(formatter.inputDigit('3'), '04134 123');
      expect(formatter.inputDigit('4'), '04134 1234');

      // 08021 2345
      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('8'), '08');
      expect(formatter.inputDigit('0'), '080');
      expect(formatter.inputDigit('2'), '080 2');
      expect(formatter.inputDigit('1'), '080 21');
      expect(formatter.inputDigit('2'), '08021 2');
      expect(formatter.inputDigit('3'), '08021 23');
      expect(formatter.inputDigit('4'), '08021 234');
      expect(formatter.inputDigit('5'), '08021 2345');

      // 00 1 650 253 2250
      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('0'), '00');
      expect(formatter.inputDigit('1'), '00 1 ');
      expect(formatter.inputDigit('6'), '00 1 6');
      expect(formatter.inputDigit('5'), '00 1 65');
      expect(formatter.inputDigit('0'), '00 1 650');
      expect(formatter.inputDigit('2'), '00 1 650 2');
      expect(formatter.inputDigit('5'), '00 1 650 25');
      expect(formatter.inputDigit('3'), '00 1 650 253');
      expect(formatter.inputDigit('2'), '00 1 650 253 2');
      expect(formatter.inputDigit('2'), '00 1 650 253 22');
      expect(formatter.inputDigit('2'), '00 1 650 253 222');
      expect(formatter.inputDigit('2'), '00 1 650 253 2222');
    });

    test('testAYTFAR', () {
      final formatter = AsYouTypeFormatter('AR', testMode: true);
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('1'), '01');
      expect(formatter.inputDigit('1'), '011');
      expect(formatter.inputDigit('7'), '011 7');
      expect(formatter.inputDigit('0'), '011 70');
      expect(formatter.inputDigit('3'), '011 703');
      expect(formatter.inputDigit('1'), '011 7031');
      expect(formatter.inputDigit('3'), '011 7031-3');
      expect(formatter.inputDigit('0'), '011 7031-30');
      expect(formatter.inputDigit('0'), '011 7031-300');
      expect(formatter.inputDigit('0'), '011 7031-3000');
    });

    test('testAYTFARMobile', () {
      final formatter = AsYouTypeFormatter('AR', testMode: true);
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('5'), '+5');
      expect(formatter.inputDigit('4'), '+54 ');
      expect(formatter.inputDigit('9'), '+54 9');
      expect(formatter.inputDigit('1'), '+54 91');
      expect(formatter.inputDigit('1'), '+54 9 11');
      expect(formatter.inputDigit('2'), '+54 9 11 2');
      expect(formatter.inputDigit('3'), '+54 9 11 23');
      expect(formatter.inputDigit('1'), '+54 9 11 231');
      expect(formatter.inputDigit('2'), '+54 9 11 2312');
      expect(formatter.inputDigit('1'), '+54 9 11 2312 1');
      expect(formatter.inputDigit('2'), '+54 9 11 2312 12');
      expect(formatter.inputDigit('3'), '+54 9 11 2312 123');
      expect(formatter.inputDigit('4'), '+54 9 11 2312 1234');
    });

    test('testAYTFKR', () {
      final formatter = AsYouTypeFormatter('KR', testMode: true);
      // +82 51 234 5678
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('8'), '+8');
      expect(formatter.inputDigit('2'), '+82 ');
      expect(formatter.inputDigit('5'), '+82 5');
      expect(formatter.inputDigit('1'), '+82 51');
      expect(formatter.inputDigit('2'), '+82 51-2');
      expect(formatter.inputDigit('3'), '+82 51-23');
      expect(formatter.inputDigit('4'), '+82 51-234');
      expect(formatter.inputDigit('5'), '+82 51-234-5');
      expect(formatter.inputDigit('6'), '+82 51-234-56');
      expect(formatter.inputDigit('7'), '+82 51-234-567');
      expect(formatter.inputDigit('8'), '+82 51-234-5678');

      // +82 2 531 5678
      formatter.clear();
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('8'), '+8');
      expect(formatter.inputDigit('2'), '+82 ');
      expect(formatter.inputDigit('2'), '+82 2');
      expect(formatter.inputDigit('5'), '+82 25');
      expect(formatter.inputDigit('3'), '+82 2-53');
      expect(formatter.inputDigit('1'), '+82 2-531');
      expect(formatter.inputDigit('5'), '+82 2-531-5');
      expect(formatter.inputDigit('6'), '+82 2-531-56');
      expect(formatter.inputDigit('7'), '+82 2-531-567');
      expect(formatter.inputDigit('8'), '+82 2-531-5678');

      // +82 2 3665 5678
      formatter.clear();
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('8'), '+8');
      expect(formatter.inputDigit('2'), '+82 ');
      expect(formatter.inputDigit('2'), '+82 2');
      expect(formatter.inputDigit('3'), '+82 23');
      expect(formatter.inputDigit('6'), '+82 2-36');
      expect(formatter.inputDigit('6'), '+82 2-366');
      expect(formatter.inputDigit('5'), '+82 2-3665');
      expect(formatter.inputDigit('5'), '+82 2-3665-5');
      expect(formatter.inputDigit('6'), '+82 2-3665-56');
      expect(formatter.inputDigit('7'), '+82 2-3665-567');
      expect(formatter.inputDigit('8'), '+82 2-3665-5678');

      // 02-114
      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('2'), '02');
      expect(formatter.inputDigit('1'), '021');
      expect(formatter.inputDigit('1'), '02-11');
      expect(formatter.inputDigit('4'), '02-114');

      // 02-1300
      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('2'), '02');
      expect(formatter.inputDigit('1'), '021');
      expect(formatter.inputDigit('3'), '02-13');
      expect(formatter.inputDigit('0'), '02-130');
      expect(formatter.inputDigit('0'), '02-1300');

      // 011-456-7890
      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('1'), '01');
      expect(formatter.inputDigit('1'), '011');
      expect(formatter.inputDigit('4'), '011-4');
      expect(formatter.inputDigit('5'), '011-45');
      expect(formatter.inputDigit('6'), '011-456');
      expect(formatter.inputDigit('7'), '011-456-7');
      expect(formatter.inputDigit('8'), '011-456-78');
      expect(formatter.inputDigit('9'), '011-456-789');
      expect(formatter.inputDigit('0'), '011-456-7890');

      // 011-9876-7890
      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('1'), '01');
      expect(formatter.inputDigit('1'), '011');
      expect(formatter.inputDigit('9'), '011-9');
      expect(formatter.inputDigit('8'), '011-98');
      expect(formatter.inputDigit('7'), '011-987');
      expect(formatter.inputDigit('6'), '011-9876');
      expect(formatter.inputDigit('7'), '011-9876-7');
      expect(formatter.inputDigit('8'), '011-9876-78');
      expect(formatter.inputDigit('9'), '011-9876-789');
      expect(formatter.inputDigit('0'), '011-9876-7890');
    });

    test('testAYTF_MX', () {
      final formatter = AsYouTypeFormatter('MX', testMode: true);
      // +52 800 123 4567
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('5'), '+5');
      expect(formatter.inputDigit('2'), '+52 ');
      expect(formatter.inputDigit('8'), '+52 8');
      expect(formatter.inputDigit('0'), '+52 80');
      expect(formatter.inputDigit('0'), '+52 800');
      expect(formatter.inputDigit('1'), '+52 800 1');
      expect(formatter.inputDigit('2'), '+52 800 12');
      expect(formatter.inputDigit('3'), '+52 800 123');
      expect(formatter.inputDigit('4'), '+52 800 123 4');
      expect(formatter.inputDigit('5'), '+52 800 123 45');
      expect(formatter.inputDigit('6'), '+52 800 123 456');
      expect(formatter.inputDigit('7'), '+52 800 123 4567');

      // +529011234567, proactively ensuring that no formatting is applied, where a
      // format is chosen
      // that would otherwise have led to some digits being dropped.
      formatter.clear();
      expect(formatter.inputDigit('9'), '9');
      expect(formatter.inputDigit('0'), '90');
      expect(formatter.inputDigit('1'), '901');
      expect(formatter.inputDigit('1'), '9011');
      expect(formatter.inputDigit('2'), '90112');
      expect(formatter.inputDigit('3'), '901123');
      expect(formatter.inputDigit('4'), '9011234');
      expect(formatter.inputDigit('5'), '90112345');
      expect(formatter.inputDigit('6'), '901123456');
      expect(formatter.inputDigit('7'), '9011234567');

      // +52 55 1234 5678
      formatter.clear();
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('5'), '+5');
      expect(formatter.inputDigit('2'), '+52 ');
      expect(formatter.inputDigit('5'), '+52 5');
      expect(formatter.inputDigit('5'), '+52 55');
      expect(formatter.inputDigit('1'), '+52 55 1');
      expect(formatter.inputDigit('2'), '+52 55 12');
      expect(formatter.inputDigit('3'), '+52 55 123');
      expect(formatter.inputDigit('4'), '+52 55 1234');
      expect(formatter.inputDigit('5'), '+52 55 1234 5');
      expect(formatter.inputDigit('6'), '+52 55 1234 56');
      expect(formatter.inputDigit('7'), '+52 55 1234 567');
      expect(formatter.inputDigit('8'), '+52 55 1234 5678');

      // +52 212 345 6789
      formatter.clear();
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('5'), '+5');
      expect(formatter.inputDigit('2'), '+52 ');
      expect(formatter.inputDigit('2'), '+52 2');
      expect(formatter.inputDigit('1'), '+52 21');
      expect(formatter.inputDigit('2'), '+52 212');
      expect(formatter.inputDigit('3'), '+52 212 3');
      expect(formatter.inputDigit('4'), '+52 212 34');
      expect(formatter.inputDigit('5'), '+52 212 345');
      expect(formatter.inputDigit('6'), '+52 212 345 6');
      expect(formatter.inputDigit('7'), '+52 212 345 67');
      expect(formatter.inputDigit('8'), '+52 212 345 678');
      expect(formatter.inputDigit('9'), '+52 212 345 6789');

      // +52 1 55 1234 5678
      formatter.clear();
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('5'), '+5');
      expect(formatter.inputDigit('2'), '+52 ');
      expect(formatter.inputDigit('1'), '+52 1');
      expect(formatter.inputDigit('5'), '+52 15');
      expect(formatter.inputDigit('5'), '+52 1 55');
      expect(formatter.inputDigit('1'), '+52 1 55 1');
      expect(formatter.inputDigit('2'), '+52 1 55 12');
      expect(formatter.inputDigit('3'), '+52 1 55 123');
      expect(formatter.inputDigit('4'), '+52 1 55 1234');
      expect(formatter.inputDigit('5'), '+52 1 55 1234 5');
      expect(formatter.inputDigit('6'), '+52 1 55 1234 56');
      expect(formatter.inputDigit('7'), '+52 1 55 1234 567');
      expect(formatter.inputDigit('8'), '+52 1 55 1234 5678');

      // +52 1 541 234 5678
      formatter.clear();
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('5'), '+5');
      expect(formatter.inputDigit('2'), '+52 ');
      expect(formatter.inputDigit('1'), '+52 1');
      expect(formatter.inputDigit('5'), '+52 15');
      expect(formatter.inputDigit('4'), '+52 1 54');
      expect(formatter.inputDigit('1'), '+52 1 541');
      expect(formatter.inputDigit('2'), '+52 1 541 2');
      expect(formatter.inputDigit('3'), '+52 1 541 23');
      expect(formatter.inputDigit('4'), '+52 1 541 234');
      expect(formatter.inputDigit('5'), '+52 1 541 234 5');
      expect(formatter.inputDigit('6'), '+52 1 541 234 56');
      expect(formatter.inputDigit('7'), '+52 1 541 234 567');
      expect(formatter.inputDigit('8'), '+52 1 541 234 5678');
    });

    test('testAYTF_International_Toll_Free', () {
      final formatter = AsYouTypeFormatter('US', testMode: true);
      // +800 1234 5678
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('8'), '+8');
      expect(formatter.inputDigit('0'), '+80');
      expect(formatter.inputDigit('0'), '+800 ');
      expect(formatter.inputDigit('1'), '+800 1');
      expect(formatter.inputDigit('2'), '+800 12');
      expect(formatter.inputDigit('3'), '+800 123');
      expect(formatter.inputDigit('4'), '+800 1234');
      expect(formatter.inputDigit('5'), '+800 1234 5');
      expect(formatter.inputDigit('6'), '+800 1234 56');
      expect(formatter.inputDigit('7'), '+800 1234 567');
      expect(formatter.inputDigit('8'), '+800 1234 5678');
      expect(formatter.inputDigit('9'), '+800123456789');
    });

    test('testAYTFMultipleLeadingDigitPatterns', () {
      final formatter = AsYouTypeFormatter('JP', testMode: true);
      // +81 50 2345 6789
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('8'), '+8');
      expect(formatter.inputDigit('1'), '+81 ');
      expect(formatter.inputDigit('5'), '+81 5');
      expect(formatter.inputDigit('0'), '+81 50');
      expect(formatter.inputDigit('2'), '+81 50 2');
      expect(formatter.inputDigit('3'), '+81 50 23');
      expect(formatter.inputDigit('4'), '+81 50 234');
      expect(formatter.inputDigit('5'), '+81 50 2345');
      expect(formatter.inputDigit('6'), '+81 50 2345 6');
      expect(formatter.inputDigit('7'), '+81 50 2345 67');
      expect(formatter.inputDigit('8'), '+81 50 2345 678');
      expect(formatter.inputDigit('9'), '+81 50 2345 6789');

      // +81 222 12 5678
      formatter.clear();
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('8'), '+8');
      expect(formatter.inputDigit('1'), '+81 ');
      expect(formatter.inputDigit('2'), '+81 2');
      expect(formatter.inputDigit('2'), '+81 22');
      expect(formatter.inputDigit('2'), '+81 22 2');
      expect(formatter.inputDigit('1'), '+81 22 21');
      expect(formatter.inputDigit('2'), '+81 2221 2');
      expect(formatter.inputDigit('5'), '+81 222 12 5');
      expect(formatter.inputDigit('6'), '+81 222 12 56');
      expect(formatter.inputDigit('7'), '+81 222 12 567');
      expect(formatter.inputDigit('8'), '+81 222 12 5678');

      // 011113
      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('1'), '01');
      expect(formatter.inputDigit('1'), '011');
      expect(formatter.inputDigit('1'), '011 1');
      expect(formatter.inputDigit('1'), '011 11');
      expect(formatter.inputDigit('3'), '011113');

      // +81 3332 2 5678
      formatter.clear();
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('8'), '+8');
      expect(formatter.inputDigit('1'), '+81 ');
      expect(formatter.inputDigit('3'), '+81 3');
      expect(formatter.inputDigit('3'), '+81 33');
      expect(formatter.inputDigit('3'), '+81 33 3');
      expect(formatter.inputDigit('2'), '+81 3332');
      expect(formatter.inputDigit('2'), '+81 3332 2');
      expect(formatter.inputDigit('5'), '+81 3332 2 5');
      expect(formatter.inputDigit('6'), '+81 3332 2 56');
      expect(formatter.inputDigit('7'), '+81 3332 2 567');
      expect(formatter.inputDigit('8'), '+81 3332 2 5678');
    });

    test('testAYTFLongIDD_AU', () {
      final formatter = AsYouTypeFormatter('AU', testMode: true);
      // 0011 1 650 253 2250
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('0'), '00');
      expect(formatter.inputDigit('1'), '001');
      expect(formatter.inputDigit('1'), '0011');
      expect(formatter.inputDigit('1'), '0011 1 ');
      expect(formatter.inputDigit('6'), '0011 1 6');
      expect(formatter.inputDigit('5'), '0011 1 65');
      expect(formatter.inputDigit('0'), '0011 1 650');
      expect(formatter.inputDigit('2'), '0011 1 650 2');
      expect(formatter.inputDigit('5'), '0011 1 650 25');
      expect(formatter.inputDigit('3'), '0011 1 650 253');
      expect(formatter.inputDigit('2'), '0011 1 650 253 2');
      expect(formatter.inputDigit('2'), '0011 1 650 253 22');
      expect(formatter.inputDigit('2'), '0011 1 650 253 222');
      expect(formatter.inputDigit('2'), '0011 1 650 253 2222');

      // 0011 81 3332 2 5678
      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('0'), '00');
      expect(formatter.inputDigit('1'), '001');
      expect(formatter.inputDigit('1'), '0011');
      expect(formatter.inputDigit('8'), '00118');
      expect(formatter.inputDigit('1'), '0011 81 ');
      expect(formatter.inputDigit('3'), '0011 81 3');
      expect(formatter.inputDigit('3'), '0011 81 33');
      expect(formatter.inputDigit('3'), '0011 81 33 3');
      expect(formatter.inputDigit('2'), '0011 81 3332');
      expect(formatter.inputDigit('2'), '0011 81 3332 2');
      expect(formatter.inputDigit('5'), '0011 81 3332 2 5');
      expect(formatter.inputDigit('6'), '0011 81 3332 2 56');
      expect(formatter.inputDigit('7'), '0011 81 3332 2 567');
      expect(formatter.inputDigit('8'), '0011 81 3332 2 5678');

      // 0011 244 250 253 222
      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('0'), '00');
      expect(formatter.inputDigit('1'), '001');
      expect(formatter.inputDigit('1'), '0011');
      expect(formatter.inputDigit('2'), '00112');
      expect(formatter.inputDigit('4'), '001124');
      expect(formatter.inputDigit('4'), '0011 244 ');
      expect(formatter.inputDigit('2'), '0011 244 2');
      expect(formatter.inputDigit('5'), '0011 244 25');
      expect(formatter.inputDigit('0'), '0011 244 250');
      expect(formatter.inputDigit('2'), '0011 244 250 2');
      expect(formatter.inputDigit('5'), '0011 244 250 25');
      expect(formatter.inputDigit('3'), '0011 244 250 253');
      expect(formatter.inputDigit('2'), '0011 244 250 253 2');
      expect(formatter.inputDigit('2'), '0011 244 250 253 22');
      expect(formatter.inputDigit('2'), '0011 244 250 253 222');
    });

    test('testAYTFLongIDD_KR', () {
      final formatter = AsYouTypeFormatter('KR', testMode: true);
      // 00300 1 650 253 2222
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('0'), '00');
      expect(formatter.inputDigit('3'), '003');
      expect(formatter.inputDigit('0'), '0030');
      expect(formatter.inputDigit('0'), '00300');
      expect(formatter.inputDigit('1'), '00300 1 ');
      expect(formatter.inputDigit('6'), '00300 1 6');
      expect(formatter.inputDigit('5'), '00300 1 65');
      expect(formatter.inputDigit('0'), '00300 1 650');
      expect(formatter.inputDigit('2'), '00300 1 650 2');
      expect(formatter.inputDigit('5'), '00300 1 650 25');
      expect(formatter.inputDigit('3'), '00300 1 650 253');
      expect(formatter.inputDigit('2'), '00300 1 650 253 2');
      expect(formatter.inputDigit('2'), '00300 1 650 253 22');
      expect(formatter.inputDigit('2'), '00300 1 650 253 222');
      expect(formatter.inputDigit('2'), '00300 1 650 253 2222');
    });

    test('testAYTFLongNDD_KR', () {
      final formatter = AsYouTypeFormatter('KR', testMode: true);
      // 08811-9876-7890
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('8'), '08');
      expect(formatter.inputDigit('8'), '088');
      expect(formatter.inputDigit('1'), '0881');
      expect(formatter.inputDigit('1'), '08811');
      expect(formatter.inputDigit('9'), '08811-9');
      expect(formatter.inputDigit('8'), '08811-98');
      expect(formatter.inputDigit('7'), '08811-987');
      expect(formatter.inputDigit('6'), '08811-9876');
      expect(formatter.inputDigit('7'), '08811-9876-7');
      expect(formatter.inputDigit('8'), '08811-9876-78');
      expect(formatter.inputDigit('9'), '08811-9876-789');
      expect(formatter.inputDigit('0'), '08811-9876-7890');

      // 08500 11-9876-7890
      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('8'), '08');
      expect(formatter.inputDigit('5'), '085');
      expect(formatter.inputDigit('0'), '0850');
      expect(formatter.inputDigit('0'), '08500 ');
      expect(formatter.inputDigit('1'), '08500 1');
      expect(formatter.inputDigit('1'), '08500 11');
      expect(formatter.inputDigit('9'), '08500 11-9');
      expect(formatter.inputDigit('8'), '08500 11-98');
      expect(formatter.inputDigit('7'), '08500 11-987');
      expect(formatter.inputDigit('6'), '08500 11-9876');
      expect(formatter.inputDigit('7'), '08500 11-9876-7');
      expect(formatter.inputDigit('8'), '08500 11-9876-78');
      expect(formatter.inputDigit('9'), '08500 11-9876-789');
      expect(formatter.inputDigit('0'), '08500 11-9876-7890');
    });

    test('testAYTFLongNDD_SG', () {
      final formatter = AsYouTypeFormatter('SG', testMode: true);
      // 777777 9876 7890
      expect(formatter.inputDigit('7'), '7');
      expect(formatter.inputDigit('7'), '77');
      expect(formatter.inputDigit('7'), '777');
      expect(formatter.inputDigit('7'), '7777');
      expect(formatter.inputDigit('7'), '77777');
      expect(formatter.inputDigit('7'), '777777 ');
      expect(formatter.inputDigit('9'), '777777 9');
      expect(formatter.inputDigit('8'), '777777 98');
      expect(formatter.inputDigit('7'), '777777 987');
      expect(formatter.inputDigit('6'), '777777 9876');
      expect(formatter.inputDigit('7'), '777777 9876 7');
      expect(formatter.inputDigit('8'), '777777 9876 78');
      expect(formatter.inputDigit('9'), '777777 9876 789');
      expect(formatter.inputDigit('0'), '777777 9876 7890');
    });

    test('testAYTFShortNumberFormattingFix_AU', () {
      // For Australia, the national prefix is not optional when formatting.
      final formatter = AsYouTypeFormatter('AU', testMode: true);

      // 1234567890 - For leading digit 1,
      // the national prefix formatting rule has first group only.
      expect(formatter.inputDigit('1'), '1');
      expect(formatter.inputDigit('2'), '12');
      expect(formatter.inputDigit('3'), '123');
      expect(formatter.inputDigit('4'), '1234');
      expect(formatter.inputDigit('5'), '1234 5');

      expect(formatter.inputDigit('6'), '1234 56');
      expect(formatter.inputDigit('7'), '1234 567');
      expect(formatter.inputDigit('8'), '1234 567 8');
      expect(formatter.inputDigit('9'), '1234 567 89');
      expect(formatter.inputDigit('0'), '1234 567 890');

      // +61 1234 567 890 - Test the same number, but with the country code.
      formatter.clear();
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('6'), '+6');
      expect(formatter.inputDigit('1'), '+61 ');
      expect(formatter.inputDigit('1'), '+61 1');
      expect(formatter.inputDigit('2'), '+61 12');
      expect(formatter.inputDigit('3'), '+61 123');
      expect(formatter.inputDigit('4'), '+61 1234');
      expect(formatter.inputDigit('5'), '+61 1234 5');
      expect(formatter.inputDigit('6'), '+61 1234 56');
      expect(formatter.inputDigit('7'), '+61 1234 567');
      expect(formatter.inputDigit('8'), '+61 1234 567 8');
      expect(formatter.inputDigit('9'), '+61 1234 567 89');
      expect(formatter.inputDigit('0'), '+61 1234 567 890');

      // 212345678 - For leading digit 2, the national prefix formatting rule puts the
      // national prefix before the first group.
      formatter.clear();
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('2'), '02');
      expect(formatter.inputDigit('1'), '021');
      expect(formatter.inputDigit('2'), '02 12');
      expect(formatter.inputDigit('3'), '02 123');
      expect(formatter.inputDigit('4'), '02 1234');
      expect(formatter.inputDigit('5'), '02 1234 5');
      expect(formatter.inputDigit('6'), '02 1234 56');
      expect(formatter.inputDigit('7'), '02 1234 567');
      expect(formatter.inputDigit('8'), '02 1234 5678');

      // 212345678 - Test the same number, but without the leading 0.
      formatter.clear();
      expect(formatter.inputDigit('2'), '2');
      expect(formatter.inputDigit('1'), '21');
      expect(formatter.inputDigit('2'), '212');
      expect(formatter.inputDigit('3'), '2123');
      expect(formatter.inputDigit('4'), '21234');
      expect(formatter.inputDigit('5'), '212345');
      expect(formatter.inputDigit('6'), '2123456');
      expect(formatter.inputDigit('7'), '21234567');
      expect(formatter.inputDigit('8'), '212345678');

      // +61 2 1234 5678 - Test the same number, but with the country code.
      formatter.clear();
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('6'), '+6');
      expect(formatter.inputDigit('1'), '+61 ');
      expect(formatter.inputDigit('2'), '+61 2');
      expect(formatter.inputDigit('1'), '+61 21');
      expect(formatter.inputDigit('2'), '+61 2 12');
      expect(formatter.inputDigit('3'), '+61 2 123');
      expect(formatter.inputDigit('4'), '+61 2 1234');
      expect(formatter.inputDigit('5'), '+61 2 1234 5');
      expect(formatter.inputDigit('6'), '+61 2 1234 56');
      expect(formatter.inputDigit('7'), '+61 2 1234 567');
      expect(formatter.inputDigit('8'), '+61 2 1234 5678');
    });

    test('testAYTFShortNumberFormattingFix_KR', () {
      // For Korea, the national prefix is not optional when formatting, and the
      // national prefix
      // formatting rule doesn't consist of only the first group.
      final formatter = AsYouTypeFormatter('KR', testMode: true);

      // 111
      expect(formatter.inputDigit('1'), '1');
      expect(formatter.inputDigit('1'), '11');
      expect(formatter.inputDigit('1'), '111');

      // 114
      formatter.clear();
      expect(formatter.inputDigit('1'), '1');
      expect(formatter.inputDigit('1'), '11');
      expect(formatter.inputDigit('4'), '114');

      // 13121234 - Test a mobile number without the national prefix. Even though it
      // is not an
      // emergency number, it should be formatted as a block.
      formatter.clear();
      expect(formatter.inputDigit('1'), '1');
      expect(formatter.inputDigit('3'), '13');
      expect(formatter.inputDigit('1'), '131');
      expect(formatter.inputDigit('2'), '1312');
      expect(formatter.inputDigit('1'), '13121');
      expect(formatter.inputDigit('2'), '131212');
      expect(formatter.inputDigit('3'), '1312123');
      expect(formatter.inputDigit('4'), '13121234');

      // +82 131-2-1234 - Test the same number, but with the country code.
      formatter.clear();
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('8'), '+8');
      expect(formatter.inputDigit('2'), '+82 ');
      expect(formatter.inputDigit('1'), '+82 1');
      expect(formatter.inputDigit('3'), '+82 13');
      expect(formatter.inputDigit('1'), '+82 131');
      expect(formatter.inputDigit('2'), '+82 131-2');
      expect(formatter.inputDigit('1'), '+82 131-2-1');
      expect(formatter.inputDigit('2'), '+82 131-2-12');
      expect(formatter.inputDigit('3'), '+82 131-2-123');
      expect(formatter.inputDigit('4'), '+82 131-2-1234');
    });

    test('testAYTFShortNumberFormattingFix_MX', () {
      // For Mexico, the national prefix is optional when formatting.
      final formatter = AsYouTypeFormatter('MX', testMode: true);

      // 911
      expect(formatter.inputDigit('9'), '9');
      expect(formatter.inputDigit('1'), '91');
      expect(formatter.inputDigit('1'), '911');

      // 800 123 4567 - Test a toll-free number, which should have a formatting rule
      // applied to it
      // even though it doesn't begin with the national prefix.
      formatter.clear();
      expect(formatter.inputDigit('8'), '8');
      expect(formatter.inputDigit('0'), '80');
      expect(formatter.inputDigit('0'), '800');
      expect(formatter.inputDigit('1'), '800 1');
      expect(formatter.inputDigit('2'), '800 12');
      expect(formatter.inputDigit('3'), '800 123');
      expect(formatter.inputDigit('4'), '800 123 4');
      expect(formatter.inputDigit('5'), '800 123 45');
      expect(formatter.inputDigit('6'), '800 123 456');
      expect(formatter.inputDigit('7'), '800 123 4567');

      // +52 800 123 4567 - Test the same number, but with the country code.
      formatter.clear();
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('5'), '+5');
      expect(formatter.inputDigit('2'), '+52 ');
      expect(formatter.inputDigit('8'), '+52 8');
      expect(formatter.inputDigit('0'), '+52 80');
      expect(formatter.inputDigit('0'), '+52 800');
      expect(formatter.inputDigit('1'), '+52 800 1');
      expect(formatter.inputDigit('2'), '+52 800 12');
      expect(formatter.inputDigit('3'), '+52 800 123');
      expect(formatter.inputDigit('4'), '+52 800 123 4');
      expect(formatter.inputDigit('5'), '+52 800 123 45');
      expect(formatter.inputDigit('6'), '+52 800 123 456');
      expect(formatter.inputDigit('7'), '+52 800 123 4567');
    });

    test('testAYTFNoNationalPrefix', () {
      final formatter = AsYouTypeFormatter('IT', testMode: true);
      expect(formatter.inputDigit('3'), '3');
      expect(formatter.inputDigit('3'), '33');
      expect(formatter.inputDigit('3'), '333');
      expect(formatter.inputDigit('3'), '333 3');
      expect(formatter.inputDigit('3'), '333 33');
      expect(formatter.inputDigit('3'), '333 333');
    });

    test('testAYTFNoNationalPrefixFormattingRule', () {
      final formatter = AsYouTypeFormatter('AO', testMode: true);
      expect(formatter.inputDigit('3'), '3');
      expect(formatter.inputDigit('3'), '33');
      expect(formatter.inputDigit('3'), '333');
      expect(formatter.inputDigit('3'), '333 3');
      expect(formatter.inputDigit('3'), '333 33');
      expect(formatter.inputDigit('3'), '333 333');
    });

    test('testAYTFShortNumberFormattingFix_US', () {
      // For the US, an initial 1 is treated specially.
      final formatter = AsYouTypeFormatter('US', testMode: true);

      // 101 - Test that the initial 1 is not treated as a national prefix.
      expect(formatter.inputDigit('1'), '1');
      expect(formatter.inputDigit('0'), '10');
      expect(formatter.inputDigit('1'), '101');

      // 112 - Test that the initial 1 is not treated as a national prefix.
      formatter.clear();
      expect(formatter.inputDigit('1'), '1');
      expect(formatter.inputDigit('1'), '11');
      expect(formatter.inputDigit('2'), '112');

      // 122 - Test that the initial 1 is treated as a national prefix.
      formatter.clear();
      expect(formatter.inputDigit('1'), '1');
      expect(formatter.inputDigit('2'), '12');
      expect(formatter.inputDigit('2'), '1 22');
    });

    test('testAYTFClearNDDAfterIDDExtraction', () {
      final formatter = AsYouTypeFormatter('KR', testMode: true);
      // Check that when we have successfully extracted an IDD, the previously
      // extracted NDD is
      // cleared since it is no longer valid.
      expect(formatter.inputDigit('0'), '0');
      expect(formatter.inputDigit('0'), '00');
      expect(formatter.inputDigit('7'), '007');
      expect(formatter.inputDigit('0'), '0070');
      expect(formatter.inputDigit('0'), '00700');
      expect(formatter.extractedNationalPrefix, '0');

      // Once the IDD '00700' has been extracted, it no longer makes sense for the
      // initial '0' to be
      // treated as an NDD.
      expect(formatter.inputDigit('1'), '00700 1 ');
      expect(formatter.extractedNationalPrefix, '');

      expect(formatter.inputDigit('2'), '00700 1 2');
      expect(formatter.inputDigit('3'), '00700 1 23');
      expect(formatter.inputDigit('4'), '00700 1 234');
      expect(formatter.inputDigit('5'), '00700 1 234 5');
      expect(formatter.inputDigit('6'), '00700 1 234 56');
      expect(formatter.inputDigit('7'), '00700 1 234 567');
      expect(formatter.inputDigit('8'), '00700 1 234 567 8');
      expect(formatter.inputDigit('9'), '00700 1 234 567 89');
      expect(formatter.inputDigit('0'), '00700 1 234 567 890');
      expect(formatter.inputDigit('1'), '00700 1 234 567 8901');
      expect(formatter.inputDigit('2'), '00700123456789012');
      expect(formatter.inputDigit('3'), '007001234567890123');
      expect(formatter.inputDigit('4'), '0070012345678901234');
      expect(formatter.inputDigit('5'), '00700123456789012345');
      expect(formatter.inputDigit('6'), '007001234567890123456');
      expect(formatter.inputDigit('7'), '0070012345678901234567');
    });

    test('testAYTFNumberPatternsBecomingInvalidShouldNotResultInDigitLoss', () {
      final formatter = AsYouTypeFormatter('CN', testMode: true);
      expect(formatter.inputDigit('+'), '+');
      expect(formatter.inputDigit('8'), '+8');
      expect(formatter.inputDigit('6'), '+86 ');
      expect(formatter.inputDigit('9'), '+86 9');
      expect(formatter.inputDigit('8'), '+86 98');
      expect(formatter.inputDigit('8'), '+86 988');
      expect(formatter.inputDigit('1'), '+86 988 1');

      // The number pattern is no longer valid because there are multiple leading digit patterns
      // When trying again to extract a country code, it should use the last leading digit pattern
      // rather than the first one
      expect(formatter.inputDigit('2'), '+8698812');
      expect(formatter.inputDigit('3'), '+86988123');
      expect(formatter.inputDigit('4'), '+869881234');
      expect(formatter.inputDigit('5'), '+8698812345');
    });
  });
}
