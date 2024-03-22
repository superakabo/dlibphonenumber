/// Based on the original Java code: .../phonenumbers/PhoneNumberMatchTest.java
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

void main() {
  group('PhoneNumberMatchTest', () {
    /// Tests the value type semantics. Equality and hash code must be based on the covered range and
    /// corresponding phone number. Range and number correctness are tested by
    /// [PhoneNumberMatcherTest}.
    test('testValueTypeSemantics', () {
      PhoneNumber number = PhoneNumber();
      PhoneNumberMatch match1 = PhoneNumberMatch(10, '1 800 234 45 67', number);
      PhoneNumberMatch match2 = PhoneNumberMatch(10, '1 800 234 45 67', number);

      expect(match2, match1);
      expect(match2.hashCode, match1.hashCode);
      expect(match2.start, match1.start);
      expect(match2.end, match1.end);
      expect(match2.number, match1.number);
      expect(match2.rawString, match1.rawString);
      expect(match1.rawString, '1 800 234 45 67');
    });

    /// Tests the value type semantics for matches with a null number.
    test('testIllegalArguments', () {
      expect(
        () => PhoneNumberMatch(-110, '1 800 234 45 67', PhoneNumber()),
        throwsA(isA<IllegalArgumentException>()),
      );
    });
  });
}
