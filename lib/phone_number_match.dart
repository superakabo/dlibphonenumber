// Based on the original Java code: .../phonenumbers/PhoneNumberMatch.java
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

import 'exceptions/illegal_argument_exception.dart';
import 'generated/classes/phone_number/phonenumber.pb.dart';

/// The immutable match of a phone number within a piece of text.
/// Matches may be found using [PhoneNumberUtil.findNumbers].
///
/// <p>A match consists of the [number] phone number
/// as well as the [start] and [end] offsets of the corresponding subsequence
/// of the searched text. Use [rawString] to obtain a copy of the matched subsequence.
///
/// <p>The following annotated example clarifies the relationship between the
///  searched text, the match offsets, and the parsed number:
///
/// <pre>
/// String text = "Call me at +1 425 882-8080 for details.";
/// String country = "US";
/// PhoneNumberUtil util = PhoneNumberUtil.instance;
///
/// // Find the first phone number match:
/// PhoneNumberMatch m = util.findNumbers(text, country).iterator.current;
///
/// // rawString contains the phone number as it appears in the text.
/// "+1 425 882-8080" == m.rawString;
///
/// // start and end define the range of the matched subsequence.
/// String subsequence = text.subSequence(m.start, m.end);
/// "+1 425 882-8080" == subsequence;
///
/// // number returns the the same result as [PhoneNumberUtil.parse]
/// // invoked on rawString.
/// util.parse(m.rawString, country).equals(m.number);
/// </pre>
class PhoneNumberMatch {
  final int start;
  final String rawString;
  final PhoneNumber number;

  PhoneNumberMatch(this.start, this.rawString, this.number) {
    if (start < 0) {
      throw IllegalArgumentException('Start index must be >= 0.');
    }
  }

  int get end => start + rawString.length;

  @override
  int get hashCode {
    return Object.hashAll([
      start,
      rawString,
      number.countryCode,
      number.nationalNumber,
    ]);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PhoneNumberMatch &&
            runtimeType == other.runtimeType &&
            start == other.start &&
            rawString == other.rawString &&
            number.countryCode == other.number.countryCode &&
            number.nationalNumber == other.number.nationalNumber;
  }

  @override
  String toString() {
    return 'PhoneNumberMatch [$start,$end) $rawString';
  }
}
