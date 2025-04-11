import 'package:dlibphonenumber/dlibphonenumber.dart';

void main() {
  final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
  final PhoneNumber phoneNumber1 = phoneUtil.parse('0241234567', 'GH');
  final PhoneNumber phoneNumber2 = phoneUtil.parse('+233241234567', '');
  final bool validPhoneNumber = phoneUtil.isValidNumber(phoneNumber1);
  final String e164 = phoneUtil.format(phoneNumber1, PhoneNumberFormat.e164);
  final String international = phoneUtil.format(phoneNumber1, PhoneNumberFormat.international);
  final String national = phoneUtil.format(phoneNumber1, PhoneNumberFormat.national);
  final String rfc3966 = phoneUtil.format(phoneNumber1, PhoneNumberFormat.rfc3966);
  final PhoneNumberType numberType1 = phoneUtil.getNumberType(phoneNumber1);
  final PhoneNumberType numberType2 = phoneUtil.getNumberType(phoneNumber2);
  final MatchType matchType = phoneUtil.isNumberMatch(phoneNumber1, phoneNumber2);
  final PhoneNumber? examplePhoneNumber = phoneUtil.getExampleNumber('IC');
  final bool isPhoneNumber = phoneUtil.isPossibleNumber(phoneNumber2);
  final bool isValidRegionNumber = phoneUtil.isValidNumberForRegion(phoneNumber1, 'US');
  final AsYouTypeFormatter asYouTypeFormatter = phoneUtil.getAsYouTypeFormatter('GH');
  final Iterable<PhoneNumberMatch> foundPhoneNumbers = phoneUtil.findNumbers('Call me on 0201234567', 'GH');
  final String territory = PhoneNumberOfflineGeocoder.instance.getDescriptionForNumber(phoneNumber1, Locale.english);
  final List<String> timezones = PhoneNumberToTimeZonesMapper.instance.getTimeZonesForNumber(phoneNumber1);
  final String carrier = PhoneNumberToCarrierMapper.instance.getNameForNumber(phoneNumber1, Locale.english);

  /// prints: +233241234567
  print('e164: $e164');

  /// prints: +233 24 123 4567
  print('international: $international');

  /// prints: 024 123 4567
  print('national: $national');

  /// prints: tel:+233-24-123-4567
  print('rfc3966: $rfc3966');

  /// prints: true
  print('validPhoneNumber: $validPhoneNumber');

  /// prints: (countryCode: 233, nationalNumber: 241234567)
  print('phoneNumber1: $phoneNumber1');

  /// prints: (countryCode: 233, nationalNumber: 241234567)
  print('phoneNumber2: $phoneNumber2');

  /// prints: PhoneNumberType.mobile
  print('phoneNumberType1: $numberType1');

  /// prints: PhoneNumberType.mobile
  print('phoneNumberType2: $numberType2');

  /// prints: (countryCode: 233, nationalNumber: 302345678)
  print('examplePhoneNumber: $examplePhoneNumber');

  /// prints: MatchType.exactMatch
  print('matchType: $matchType');

  /// prints: true
  print('isPhoneNumber: $isPhoneNumber');

  /// prints: false
  print('isValidRegionNumber: $isValidRegionNumber');

  /// prints: [countryCode: 233, nationalNumber: 201234567]
  print('foundPhoneNumbers: ${foundPhoneNumbers.map((e) => e.number)}');

  /// prints: Ghana
  print('territory: $territory');

  /// prints: [Africa/Accra]
  print('timezones: $timezones');

  /// prints: MTN
  print('carrier: $carrier');

  /// prints:
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
  final String inputPhoneNumber = '+233241234567';
  for (int i = 0; i < inputPhoneNumber.length; i++) {
    final String char = inputPhoneNumber[i];
    print(asYouTypeFormatter.inputDigit(char));
  }
}
