/// Based on the original Java code: .../phonenumbers/PhoneNumberMatch.java
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

import 'exceptions/illegal_argument_exception.dart';
import 'generated/phone_number/phonenumber.pb.dart';

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
