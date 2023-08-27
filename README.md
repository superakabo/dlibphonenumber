# What is it?

This is a Dart port of [Google's libphonenumber library](https://github.com/google/libphonenumber)
Google's library for parsing, formatting, and validating international phone numbers.

# Highlights of functionality

*   Parsing, formatting, and validating phone numbers for all countries/regions
    of the world.
*   `getNumberType` - gets the type of the number based on the number itself;
    able to distinguish Fixed-line, Mobile, Toll-free, Premium Rate, Shared
    Cost, VoIP, Personal Numbers, UAN, Pager, and Voicemail (whenever feasible).
*   `isNumberMatch` - gets a confidence level on whether two numbers could be
    the same.
*   `getExampleNumber` and `getExampleNumberForType` - provide valid example
    numbers for all countries/regions, with the option of specifying which type
    of example phone number is needed.
*   `isPossibleNumber` - quickly guesses whether a number is a possible
    phone number by using only the length information, much faster than a full
    validation.
*   `isValidNumber` - full validation of a phone number for a region using
    length and prefix information.

<!-- *   `AsYouTypeFormatter` - formats phone numbers on-the-fly when users enter
    each digit.
*   `findNumbers` - finds numbers in text.
*   `PhoneNumberOfflineGeocoder` - provides geographical information related to
    a phone number.
*   `PhoneNumberToCarrierMapper` - provides carrier information related to a
    phone number.
*   `PhoneNumberToTimeZonesMapper` - provides timezone information related to a
    phone number. -->

# Quick Examples

Let's say you have a string representing a phone number from Switzerland. This
is how you parse/normalize it into a `PhoneNumber` object:

```dart
String swissNumberStr = "044 668 18 00";
PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
try {
  PhoneNumber swissNumberProto = phoneUtil.parse(swissNumberStr, "CH");
} on NumberParseException catch (e) {
  print("NumberParseException was thrown: ${e.toString()}");
}
```

At this point, `swissNumberProto` contains:

```json
{
  "country_code": 41,
  "national_number": 446681800
}
```

Now let us validate whether the number is valid:

```dart
bool isValid = phoneUtil.isValidNumber(swissNumberProto); // returns true
```

There are a few formats supported by the formatting method, as illustrated
below:

```dart
// Produces "+41 44 668 18 00"
print(phoneUtil.format(swissNumberProto, PhoneNumberFormat.international));
// Produces "044 668 18 00"
print(phoneUtil.format(swissNumberProto, PhoneNumberFormat.national));
// Produces "+41446681800"
print(phoneUtil.format(swissNumberProto, PhoneNumberFormat.e164));
```

You could also choose to format the number in the way it is dialed from another
country:

```dart
// Produces "011 41 44 668 1800", the number when it is dialed in the United States.
print(phoneUtil.formatOutOfCountryCallingNumber(swissNumberProto, "US"));
```

<!-- ## Formatting Phone Numbers 'as you type'

```java
PhoneNumberUtil phoneUtil = PhoneNumberUtil.getInstance();
AsYouTypeFormatter formatter = phoneUtil.getAsYouTypeFormatter("US");
System.out.println(formatter.inputDigit('6'));  // Outputs "6"
...  // Input more digits
System.out.println(formatter.inputDigit('3'));  // Now outputs "650 253"
``` -->

<!-- ## Geocoding Phone Numbers

```java
PhoneNumberOfflineGeocoder geocoder = PhoneNumberOfflineGeocoder.getInstance();
// Outputs "Zurich"
System.out.println(geocoder.getDescriptionForNumber(swissNumberProto, Locale.ENGLISH));
// Outputs "Zürich"
System.out.println(geocoder.getDescriptionForNumber(swissNumberProto, Locale.GERMAN));
// Outputs "Zurigo"
System.out.println(geocoder.getDescriptionForNumber(swissNumberProto, Locale.ITALIAN));
``` -->

<!-- ## Mapping Phone Numbers to original carriers

Caveat: We do not provide data about the current carrier of a phone number, only
the original carrier who is assigned the corresponding range. Read about [number
portability](FAQ.md#what-is-mobile-number-portability).

```java
PhoneNumber swissMobileNumber =
    new PhoneNumber().setCountryCode(41).setNationalNumber(798765432L);
PhoneNumberToCarrierMapper carrierMapper = PhoneNumberToCarrierMapper.getInstance();
// Outputs "Swisscom"
System.out.println(carrierMapper.getNameForNumber(swissMobileNumber, Locale.ENGLISH));
``` -->