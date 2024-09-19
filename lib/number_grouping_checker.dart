// Based on the original Java code: .../phonenumbers/PhoneNumberMatcher.NumberGroupingChecker.java
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

import 'generated/classes/phone_number/phonenumber.pb.dart';
import 'phone_number_matcher.dart';
import 'phone_number_util.dart';

/// Small helper interface such that the number groups can be checked according to different
/// criteria, both for our default way of performing formatting and for any alternate formats we
/// may want to check.
abstract class NumberGroupingChecker {
  /// Returns true if the groups of digits found in our candidate
  /// phone number match our expectations.
  ///
  /// [number] the original number we found when parsing [normalizedCandidate]
  /// the candidate number, normalized to only contain ASCII digits,
  /// but with non-digits (spaces etc) retained [expectedNumberGroups]
  /// the groups of digits that we would expect to see if we formatted this number
  bool checkGroups(
    PhoneNumberUtil util,
    PhoneNumber number,
    StringBuffer normalizedCandidate,
    List<String> expectedNumberGroups,
  );
}

class NumberGroupingCheckerStrictGrouping implements NumberGroupingChecker {
  const NumberGroupingCheckerStrictGrouping();

  @override
  bool checkGroups(
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
  }
}

class NumberGroupingCheckerExactGrouping implements NumberGroupingChecker {
  const NumberGroupingCheckerExactGrouping();

  @override
  bool checkGroups(
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
  }
}
