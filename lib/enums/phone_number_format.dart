// Based on the original Java code: .../phonenumbers/PhoneNumberUtil.java
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

/// [international] and [national] formats are consistent with the definition in ITU-T Recommendation
/// E.123. However we follow local conventions such as using '-' instead of whitespace as
/// separators. For example, the number of the Google Switzerland office will be written as
/// '+41 44 668 1800' in [international] format, and as '044 668 1800' in [national] format. [e164]
/// format is as per [international] format but with no formatting applied, e.g. '+41446681800'.
/// [rfc3966] is as per [international] format, but with all spaces and other separating symbols
/// replaced with a hyphen, and with any phone number extension appended with ';ext='. It also
/// will have a prefix of 'tel:' added, e.g. 'tel:+41-44-668-1800'.
///
/// Note: If you are considering storing the number in a neutral format,
/// you are highly advised to use the PhoneNumber class.
enum PhoneNumberFormat {
  e164,
  international,
  national,
  rfc3966;
}
