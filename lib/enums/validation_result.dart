/* Based on the original Java code: .../phonenumbers/PhoneNumberUtil.java
 *
 * Copyright (C) 2009 The Libphonenumber Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/// Possible outcomes when testing if a PhoneNumber is possible.
enum ValidationResult {
  /// The number length matches that of valid numbers for this region.
  isPossible,

  /// The number length matches that of local numbers for this region only (i.e. numbers that may
  /// be able to be dialled within an area, but do not have all the information to be dialled from
  /// anywhere inside or outside the country).
  isPossibleLocalOnly,

  /// The number has an invalid country calling code.
  invalidCountryCode,

  /// The number is shorter than all valid numbers for this region.
  tooShort,

  /// The number is longer than the shortest valid numbers for this region, shorter than the
  /// longest valid numbers for this region, and does not itself have a number length that matches
  /// valid numbers for this region. This can also be returned in the case where
  /// isPossibleNumberForTypeWithReason was called, and there are no numbers of this type at all
  /// for this region.
  invalidLength,

  /// The number is longer than all valid numbers for this region.
  tooLong,
}
