/// Based on the original Java code: .../phonenumbers/PhoneNumberUtil.Leniency.java
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

import '../generated/classes/phone_number/phonenumber.pb.dart';
import '../phone_number_matcher.dart';
import '../phone_number_util.dart';

/// Leniency when [PhoneNumberUtil.findNumbers] finding potential
/// phone numbers in text
/// segments. The levels here are ordered in increasing strictness.
enum Leniency {
  possible,
  valid,
  strictGrouping,
  exactGrouping;

  /// Returns true if [number] is a verified number
  /// according to this leniency.
  bool verify(
    PhoneNumber number,
    String candidate,
    PhoneNumberUtil util,
    PhoneNumberMatcherImpl matcher,
  ) {
    switch (this) {
      /// Phone numbers accepted are
      /// [PhoneNumberUtil.isPossibleNumber(PhoneNumber)]
      /// possible}, but not necessarily
      /// [PhoneNumberUtil.isValidNumber(PhoneNumber]) valid.
      case Leniency.possible:
        return util.isPossibleNumber(number);

      /// Phone numbers accepted are
      /// [PhoneNumberUtil.isPossibleNumber(PhoneNumber)]
      /// possible and [PhoneNumberUtil#isValidNumber(PhoneNumber)] valid.
      /// Numbers written in national format must have their national-prefix
      /// present if it is usually written for a number of this type.
      case Leniency.valid:
        if (!util.isValidNumber(number) ||
            !PhoneNumberMatcherImpl.containsOnlyValidXChars(
                number, candidate.toString(), util)) {
          return false;
        }
        return PhoneNumberMatcherImpl.isNationalPrefixPresentIfRequired(
            number, util);

      /// Phone numbers accepted are
      /// [PhoneNumberUtil.isValidNumber(PhoneNumber)] valid and
      /// are grouped in a possible way for this locale. For example, a US number
      /// written as
      /// "65 02 53 00 00" and "650253 0000" are not accepted at this leniency level,
      /// whereas
      /// "650 253 0000", "650 2530000" or "6502530000" are.
      /// Numbers with more than one '/' symbol in the national significant number are
      /// also dropped at
      /// this level.
      /// <p>
      /// Warning: This level might result in lower coverage especially for regions
      /// outside of country
      /// code "+1". If you are not sure about which level to use, email the discussion
      /// group
      /// libphonenumber-discuss@googlegroups.com.
      case Leniency.strictGrouping:
        if (!util.isValidNumber(number) ||
            !PhoneNumberMatcherImpl.containsOnlyValidXChars(
                number, candidate, util) ||
            PhoneNumberMatcherImpl.containsMoreThanOneSlashInNationalNumber(
                number, candidate) ||
            !PhoneNumberMatcherImpl.isNationalPrefixPresentIfRequired(
                number, util)) {
          return false;
        }
        return matcher.checkNumberGroupingIsValid(number, candidate, util, (
          PhoneNumberUtil util,
          PhoneNumber number,
          StringBuffer normalizedCandidate,
          List<String> expectedNumberGroups,
        ) {
          return PhoneNumberMatcherImpl.allNumberGroupsRemainGrouped(
            util,
            number,
            normalizedCandidate,
            expectedNumberGroups,
          );
        });

      /// Phone numbers accepted are [PhoneNumberUtil.isValidNumber(PhoneNumber)]
      /// valid and are grouped in the same way that we would have formatted it,
      /// or as a single block. For example, a US number written as "650 2530000"
      /// is not accepted at this leniency level, whereas "650 253 0000" or "6502530000"
      /// are. Numbers with more than one '/' symbol are also dropped at this level.
      /// <p>
      /// Warning: This level might result in lower coverage especially for regions
      /// outside of country code "+1". If you are not sure about which level to use,
      /// email the discussion group libphonenumber-discuss@googlegroups.com.
      case Leniency.exactGrouping:
        if (!util.isValidNumber(number) ||
            !PhoneNumberMatcherImpl.containsOnlyValidXChars(
                number, candidate, util) ||
            PhoneNumberMatcherImpl.containsMoreThanOneSlashInNationalNumber(
                number, candidate) ||
            !PhoneNumberMatcherImpl.isNationalPrefixPresentIfRequired(
                number, util)) {
          return false;
        }
        return matcher.checkNumberGroupingIsValid(number, candidate, util, (
          PhoneNumberUtil util,
          PhoneNumber number,
          StringBuffer normalizedCandidate,
          List<String> expectedNumberGroups,
        ) {
          return PhoneNumberMatcherImpl.allNumberGroupsAreExactlyPresent(
            util,
            number,
            normalizedCandidate,
            expectedNumberGroups,
          );
        });
    }
  }
}
