# Dart LibPhoneNumber
[![Pub Package](https://img.shields.io/pub/v/dlibphonenumber.svg)](https://pub.dev/packages/dlibphonenumber)
[![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](LICENSE)
[![Build Status](https://github.com/superakabo/dlibphonenumber/actions/workflows/release.yml/badge.svg)](https://github.com/superakabo/dlibphonenumber/actions)
[![GitHub stars](https://img.shields.io/github/stars/superakabo/dlibphonenumber?style=social)](https://github.com/superakabo/dlibphonenumber/stargazers)
[![Codecov](https://codecov.io/gh/superakabo/dlibphonenumber/branch/main/graph/badge.svg)](https://codecov.io/gh/superakabo/dlibphonenumber)


A Dart package for working with international phone numbers based on Google's libphonenumber implementation. It parses, formats, and validates numbers without relying on native dependencies.

## ✨ Features

✅ **Parse, format, and validate** phone numbers [[`parse()`](#parse-a-phone-number), [`format()`](#format-a-phone-number), [`isValidNumber()`](#validate-a-phone-number)]\
➝ Convert raw phone numbers into structured objects, apply different formats, and check validity.

✅ **Identify phone number types** [[`getNumberType()`](#🔢-identify-number-types)]\
➝ Distinguishes between Fixed-line, Mobile, Toll-free, Premium Rate, VoIP, etc.

✅ **Match and compare phone numbers** [[`isNumberMatch()`](#🔄-match-and-compare-phone-numbers)]\
➝ Determines whether two numbers are the same or similar.

✅ **Generate example phone numbers** [[`getExampleNumber()`](#💡-generate-example-numbers)]\
➝ Provides valid phone number examples for various countries/regions.

✅ **Perform quick validation** [[`isPossibleNumber()`](#👌-perform-quick-validation)]\
➝ Checks if a number has a valid length without requiring region-specific details.

✅ **Validate phone numbers for a specific region** [[`isValidNumberForRegion()`](#🌍-validate-numbers-for-a-specific-region)]\
➝ Ensures a phone number is valid in the given country based on length and prefix rules.

✅ **Format phone numbers as-you-type** [[`getAsYouTypeFormatter()`](#📐-format-numbers-as-you-type)]\
➝ Dynamically formats phone numbers as users enter each digit.

✅ **Extract phone numbers from text** [[`findNumbers()`](#🔍-extract-numbers-from-text)]\
➝ Detects phone numbers within a block of text (e.g., 'Call me on 0241234567').

✅ **Geocode phone numbers** [[`getDescriptionForNumber()`](#🌍-geocode-a-phone-number)]\
➝ Retrieves geographical information related to a phone number (e.g., 'Zurich' for a Swiss number).

✅ **Retrieve carrier information** [[`getNameForNumber()`](#📡-retrieve-carrier-information)]\
➝ Identifies the telecom provider associated with a number (e.g., 'AT&T', 'Vodafone').

✅ **Find associated timezones** [[`getTimeZonesForNumber()`](#🕰-find-associated-time-zones)]\
➝ Returns timezone(s) linked to a phone number (e.g., 'America/New_York').

## 🚀 Quick Start

### 📌 Installation

Add `dlibphonenumber` to your `pubspec.yaml`:

```yaml
dependencies:
  dlibphonenumber: ^1.1.35 #replace with the current version number.
```

Then run:

```sh
flutter pub get
```

### 🏗️ Usage

#### 📞 Parse a Phone Number

```dart
import 'package:dlibphonenumber/dlibphonenumber.dart';

final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
final PhoneNumber phoneNumber = phoneUtil.parse('0241234567', 'GH');
print('$phoneNumber'); // countryCode: 233, nationalNumber: 241234567
```

#### 👍 Validate a Phone Number

```dart
import 'package:dlibphonenumber/dlibphonenumber.dart';

final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
final PhoneNumber phoneNumber = phoneUtil.parse('0241234567', 'GH');
final bool validPhoneNumber = phoneUtil.isValidNumber(phoneNumber);
print('$validPhoneNumber'); // true
```

#### 📐 Format a Phone Number

```dart
import 'package:dlibphonenumber/dlibphonenumber.dart';

final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
final PhoneNumber phoneNumber = phoneUtil.parse('0241234567', 'GH');

final String e164 = phoneUtil.format(phoneNumber, PhoneNumberFormat.e164);
print('$e164'); // +233241234567

final String international = phoneUtil.format(phoneNumber, PhoneNumberFormat.international);
print('$international'); // +233 24 123 4567

final String national = phoneUtil.format(phoneNumber, PhoneNumberFormat.national);
print('$national'); // 024 123 4567

final String rfc3966 = phoneUtil.format(phoneNumber, PhoneNumberFormat.rfc3966);
print('$rfc3966'); // tel:+233-24-123-4567
```

#### 🔢 Identify Number Types

```dart
import 'package:dlibphonenumber/dlibphonenumber.dart';

final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
final PhoneNumber phoneNumber = phoneUtil.parse('0241234567', 'GH');
final PhoneNumberType type = phoneUtil.getNumberType(phoneNumber);
print('$type'); // PhoneNumberType.mobile
```

#### 🔄 Match and Compare Phone Numbers

```dart
import 'package:dlibphonenumber/dlibphonenumber.dart';

final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
final PhoneNumber phoneNumber1 = phoneUtil.parse('0241234567', 'GH');
final PhoneNumber phoneNumber2 = phoneUtil.parse('+233241234567', '');
final MatchType matchType = phoneUtil.isNumberMatch(phoneNumber1, phoneNumber2);
print('$matchType'); // MatchType.exactMatch
```

#### 💡 Generate Example Numbers

```dart
import 'package:dlibphonenumber/dlibphonenumber.dart';

final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
final PhoneNumber? examplePhoneNumber = phoneUtil.getExampleNumber('GH');
print('$examplePhoneNumber'); // countryCode: 233, nationalNumber: 302345678
```

#### 👌 Perform Quick Validation

```dart
import 'package:dlibphonenumber/dlibphonenumber.dart';

final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
final PhoneNumber phoneNumber = phoneUtil.parse('+233241234567', '');
final bool isPhoneNumber = phoneUtil.isPossibleNumber(phoneNumber);
print('$isPhoneNumber'); // true
```

#### 🌍 Validate Numbers for a Specific Region

```dart
import 'package:dlibphonenumber/dlibphonenumber.dart';

final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
final PhoneNumber phoneNumber = phoneUtil.parse('0241234567', 'GH');
final bool isValidRegionNumber = phoneUtil.isValidNumberForRegion(phoneNumber, 'US');
print('$isValidRegionNumber'); // false
```


#### 🔍 Extract Numbers from Text

```dart
import 'package:dlibphonenumber/dlibphonenumber.dart';

final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
final Iterable<PhoneNumberMatch> foundPhoneNumbers = phoneUtil.findNumbers('Call me on 0201234567', 'GH');
print('${foundPhoneNumbers.map((e) => e.number)}'); // [countryCode: 233, nationalNumber: 201234567]
```

#### 🌍 Geocode a Phone Number

```dart
import 'package:dlibphonenumber/dlibphonenumber.dart';

final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
final PhoneNumber phoneNumber = phoneUtil.parse('0241234567', 'GH');
final String territory = PhoneNumberOfflineGeocoder.instance.getDescriptionForNumber(phoneNumber, Locale.english);
print('$territory'); // Ghana
```

#### 📡 Retrieve Carrier Information

```dart
import 'package:dlibphonenumber/dlibphonenumber.dart';

final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
final PhoneNumber phoneNumber = phoneUtil.parse('0241234567', 'GH');
final String carrier = PhoneNumberToCarrierMapper.instance.getNameForNumber(phoneNumber, Locale.english);
print('$carrier'); // MTN
```

#### 🕰 Find Associated Time Zones

```dart
import 'package:dlibphonenumber/dlibphonenumber.dart';

final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
final PhoneNumber phoneNumber = phoneUtil.parse('0241234567', 'GH');
final List<String> timezones = PhoneNumberToTimeZonesMapper.instance.getTimeZonesForNumber(phoneNumber);
print('$timezones'); // [Africa/Accra]
```

#### 📐 Format Numbers As-You-Type

```dart
import 'package:dlibphonenumber/dlibphonenumber.dart';

final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
final AsYouTypeFormatter asYouTypeFormatter = phoneUtil.getAsYouTypeFormatter('GH');
final String inputPhoneNumber = '+233241234567';
for (int i = 0; i < inputPhoneNumber.length; i++) {
  final String char = inputPhoneNumber[i];
  print(asYouTypeFormatter.inputDigit(char));
}
// +
// +2
// +23
// +233
// +233 2
// +233 24
// +233 24 1
// +233 24 12
// +233 24 123
// +233 24 123 4
// +233 24 123 45
// +233 24 123 456
// +233 24 123 4567
```

## 📜 License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details.
