import 'package:dlibphonenumber/dlibphonenumber.dart';

void main() {
  final phoneUtil = PhoneNumberUtil.instance;
  final phoneNumber = phoneUtil.parse('0241234567', 'GH');
  final validPhoneNumber = phoneUtil.isValidNumber(phoneNumber);
  final e164 = phoneUtil.format(phoneNumber, PhoneNumberFormat.e164);
  final international = phoneUtil.format(phoneNumber, PhoneNumberFormat.international);
  final national = phoneUtil.format(phoneNumber, PhoneNumberFormat.national);
  final rfc3966 = phoneUtil.format(phoneNumber, PhoneNumberFormat.rfc3966);

  print('e164: $e164');
  print('international: $international');
  print('national: $national');
  print('rfc3966: $rfc3966');
  print('validPhoneNumber: $validPhoneNumber');
  print('phoneNumber: $phoneNumber');
}
