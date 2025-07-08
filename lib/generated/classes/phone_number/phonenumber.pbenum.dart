// This is a generated file - do not edit.
//
// Generated from phonenumber.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// The source from which the country_code is derived. This is not set in the
/// general parsing method, but in the method that parses and keeps raw_input.
/// New fields could be added upon request.
class PhoneNumber_CountryCodeSource extends $pb.ProtobufEnum {
  /// Default value returned if this is not set, because the phone number was
  /// created using parse, not parseAndKeepRawInput. hasCountryCodeSource will
  /// return false if this is the case.
  static const PhoneNumber_CountryCodeSource UNSPECIFIED =
      PhoneNumber_CountryCodeSource._(0, _omitEnumNames ? '' : 'UNSPECIFIED');

  /// The country_code is derived based on a phone number with a leading "+",
  /// e.g. the French number "+33 1 42 68 53 00".
  static const PhoneNumber_CountryCodeSource FROM_NUMBER_WITH_PLUS_SIGN =
      PhoneNumber_CountryCodeSource._(
          1, _omitEnumNames ? '' : 'FROM_NUMBER_WITH_PLUS_SIGN');

  /// The country_code is derived based on a phone number with a leading IDD,
  /// e.g. the French number "011 33 1 42 68 53 00", as it is dialled from US.
  static const PhoneNumber_CountryCodeSource FROM_NUMBER_WITH_IDD =
      PhoneNumber_CountryCodeSource._(
          5, _omitEnumNames ? '' : 'FROM_NUMBER_WITH_IDD');

  /// The country_code is derived based on a phone number without a leading
  /// "+", e.g. the French number "33 1 42 68 53 00" when defaultCountry is
  /// supplied as France.
  static const PhoneNumber_CountryCodeSource FROM_NUMBER_WITHOUT_PLUS_SIGN =
      PhoneNumber_CountryCodeSource._(
          10, _omitEnumNames ? '' : 'FROM_NUMBER_WITHOUT_PLUS_SIGN');

  /// The country_code is derived NOT based on the phone number itself, but
  /// from the defaultCountry parameter provided in the parsing function by the
  /// clients. This happens mostly for numbers written in the national format
  /// (without country code). For example, this would be set when parsing the
  /// French number "01 42 68 53 00", when defaultCountry is supplied as
  /// France.
  static const PhoneNumber_CountryCodeSource FROM_DEFAULT_COUNTRY =
      PhoneNumber_CountryCodeSource._(
          20, _omitEnumNames ? '' : 'FROM_DEFAULT_COUNTRY');

  static const $core.List<PhoneNumber_CountryCodeSource> values =
      <PhoneNumber_CountryCodeSource>[
    UNSPECIFIED,
    FROM_NUMBER_WITH_PLUS_SIGN,
    FROM_NUMBER_WITH_IDD,
    FROM_NUMBER_WITHOUT_PLUS_SIGN,
    FROM_DEFAULT_COUNTRY,
  ];

  static final $core.Map<$core.int, PhoneNumber_CountryCodeSource> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static PhoneNumber_CountryCodeSource? valueOf($core.int value) =>
      _byValue[value];

  const PhoneNumber_CountryCodeSource._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
