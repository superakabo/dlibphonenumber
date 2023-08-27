/* Based on the original Java code: .../phonenumbers/NumberParseException.java
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

import '../enums/error_type.dart';

/// Generic exception class for errors encountered when parsing phone numbers.
class NumberParseException implements Exception {
  final ErrorType _errorType;

  const NumberParseException(this._errorType);

  /// Returns the error type of the exception that has been thrown.
  ErrorType get errorType => _errorType;

  String get message => _errorType.message;

  @override
  String toString() => 'Error type: $errorType. $message';
}
