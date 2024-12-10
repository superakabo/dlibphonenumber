// Based on the original Java code: .../phonenumbers/NumberParseException.java
//
// Copyright (C) 2009 The Libphonenumber Authors
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

/// Errors encountered when parsing phone numbers.
enum ErrorType {
  invalidCountryCode('Invalid country calling code'),

  /// This indicates the string passed is not a valid number. Either the string
  /// had less than 3 digits in it or had an invalid phone-context parameter.
  /// More specifically, the number failed to match the regular expression
  /// `validPhoneNumber`, `rfc3966GlobalNumberDigits`, or `rfc3966Domainname`.
  notANumber('The string supplied did not seem to be a phone number'),

  /// This indicates the string started with an international dialing prefix, but
  /// after this was stripped from the number, had less digits than any valid
  /// phone number (including country calling code) could have.
  tooShortAfterIdd('Phone number too short after IDD'),

  /// This indicates the string, after any country calling code has been
  /// stripped, had less digits than any valid phone number could have.
  tooShortNsn('The string supplied is too short to be a phone number'),

  /// This indicates the string had more digits than any valid phone number could
  /// have.
  tooLong('The string supplied is too long to be a phone number');

  final String message;
  const ErrorType(this.message);
}
