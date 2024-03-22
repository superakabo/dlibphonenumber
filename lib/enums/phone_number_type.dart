/// Based on the original Java code: .../phonenumbers/PhoneNumberUtil.java
///
/// [license]
/// Copyright (C) 2009 The Libphonenumber Authors
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

/// Type of phone numbers.
enum PhoneNumberType {
  fixedLine,
  mobile,

  /// In some regions (e.g. the USA), it is impossible to distinguish between fixed-line and
  /// mobile numbers by looking at the phone number itself.
  fixedLineOrMobile,

  /// Freephone lines
  tollFree,
  premiumRate,

  /// The cost of this call is shared between the caller and the recipient, and is hence typically
  /// less than PREMIUM_RATE calls. See // http://en.wikipedia.org/wiki/Shared_Cost_Service for
  /// more information.
  sharedCost,

  /// Voice over IP numbers. This includes TSoIP (Telephony Service over IP).
  voip,

  /// A personal number is associated with a particular person, and may be routed to either a
  /// MOBILE or FIXED_LINE number. Some more information can be found here:
  /// http://en.wikipedia.org/wiki/Personal_Numbers
  personalNumber,
  pager,

  /// Used for 'Universal Access Numbers' or 'Company Numbers'. They may be further routed to
  /// specific offices, but allow one number to be used for a company.
  uan,

  /// Used for 'Voice Mail Access Numbers'.
  voicemail,

  /// A phone number is of type UNKNOWN when it does not fit any of the known patterns for a
  /// specific region.
  unknown
}
