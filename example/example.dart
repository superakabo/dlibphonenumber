import 'package:dlibphonenumber/dlibphonenumber.dart';

void main() {
  final phoneUtil = PhoneNumberUtil.instance;
  final phoneNumber = phoneUtil.parse('0241234567', 'GH');
  final validPhoneNumber = phoneUtil.isValidNumber(phoneNumber);
  final e164 = phoneUtil.format(phoneNumber, PhoneNumberFormat.e164);
  final international = phoneUtil.format(phoneNumber, PhoneNumberFormat.international);
  final national = phoneUtil.format(phoneNumber, PhoneNumberFormat.national);
  final rfc3966 = phoneUtil.format(phoneNumber, PhoneNumberFormat.rfc3966);

  print('e164: $e164'); // +233241234567
  print('international: $international'); // +233 24 123 4567
  print('national: $national'); // 024 123 4567
  print('rfc3966: $rfc3966'); // tel:+233-24-123-4567
  print('validPhoneNumber: $validPhoneNumber'); // true
  print('phoneNumber: $phoneNumber'); // countryCode: 233, nationalNumber: 241234567
}
