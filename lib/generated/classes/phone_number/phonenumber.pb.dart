// This is a generated file - do not edit.
//
// Generated from phonenumber.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'phonenumber.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'phonenumber.pbenum.dart';

class PhoneNumber extends $pb.GeneratedMessage {
  factory PhoneNumber({
    $core.int? countryCode,
    $fixnum.Int64? nationalNumber,
    $core.String? extension_3,
    $core.bool? italianLeadingZero,
    $core.String? rawInput,
    PhoneNumber_CountryCodeSource? countryCodeSource,
    $core.String? preferredDomesticCarrierCode,
    $core.int? numberOfLeadingZeros,
  }) {
    final result = create();
    if (countryCode != null) result.countryCode = countryCode;
    if (nationalNumber != null) result.nationalNumber = nationalNumber;
    if (extension_3 != null) result.extension_3 = extension_3;
    if (italianLeadingZero != null)
      result.italianLeadingZero = italianLeadingZero;
    if (rawInput != null) result.rawInput = rawInput;
    if (countryCodeSource != null) result.countryCodeSource = countryCodeSource;
    if (preferredDomesticCarrierCode != null)
      result.preferredDomesticCarrierCode = preferredDomesticCarrierCode;
    if (numberOfLeadingZeros != null)
      result.numberOfLeadingZeros = numberOfLeadingZeros;
    return result;
  }

  PhoneNumber._();

  factory PhoneNumber.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PhoneNumber.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PhoneNumber',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'i18n.phonenumbers'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'countryCode', fieldType: $pb.PbFieldType.Q3)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'nationalNumber', $pb.PbFieldType.QU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'extension')
    ..aOB(4, _omitFieldNames ? '' : 'italianLeadingZero')
    ..aOS(5, _omitFieldNames ? '' : 'rawInput')
    ..aE<PhoneNumber_CountryCodeSource>(
        6, _omitFieldNames ? '' : 'countryCodeSource',
        enumValues: PhoneNumber_CountryCodeSource.values)
    ..aOS(7, _omitFieldNames ? '' : 'preferredDomesticCarrierCode')
    ..aI(8, _omitFieldNames ? '' : 'numberOfLeadingZeros', defaultOrMaker: 1);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PhoneNumber clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PhoneNumber copyWith(void Function(PhoneNumber) updates) =>
      super.copyWith((message) => updates(message as PhoneNumber))
          as PhoneNumber;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PhoneNumber create() => PhoneNumber._();
  @$core.override
  PhoneNumber createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PhoneNumber getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PhoneNumber>(create);
  static PhoneNumber? _defaultInstance;

  /// The country calling code for this number, as defined by the International
  /// Telecommunication Union (ITU). For example, this would be 1 for NANPA
  /// countries, and 33 for France.
  @$pb.TagNumber(1)
  $core.int get countryCode => $_getIZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => $_clearField(1);

  /// The National (significant) Number, as defined in International
  /// Telecommunication Union (ITU) Recommendation E.164, without any leading
  /// zero. The leading-zero is stored separately if required, since this is an
  /// uint64 and hence cannot store such information. Do not use this field
  /// directly: if you want the national significant number, call the
  /// getNationalSignificantNumber method of PhoneNumberUtil.
  ///
  /// For countries which have the concept of an "area code" or "national
  /// destination code", this is included in the National (significant) Number.
  /// Although the ITU says the maximum length should be 15, we have found longer
  /// numbers in some countries e.g. Germany.
  /// Note that the National (significant) Number does not contain the National
  /// (trunk) prefix. Obviously, as a uint64, it will never contain any
  /// formatting (hyphens, spaces, parentheses), nor any alphanumeric spellings.
  @$pb.TagNumber(2)
  $fixnum.Int64 get nationalNumber => $_getI64(1);
  @$pb.TagNumber(2)
  set nationalNumber($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNationalNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearNationalNumber() => $_clearField(2);

  /// Extension is not standardized in ITU recommendations, except for being
  /// defined as a series of numbers with a maximum length of 40 digits. It is
  /// defined as a string here to accommodate for the possible use of a leading
  /// zero in the extension (organizations have complete freedom to do so, as
  /// there is no standard defined). Other than digits, some other dialling
  /// characters such as "," (indicating a wait) may be stored here.
  @$pb.TagNumber(3)
  $core.String get extension_3 => $_getSZ(2);
  @$pb.TagNumber(3)
  set extension_3($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExtension_3() => $_has(2);
  @$pb.TagNumber(3)
  void clearExtension_3() => $_clearField(3);

  /// In some countries, the national (significant) number starts with one or
  /// more "0"s without this being a national prefix or trunk code of some kind.
  /// For example, the leading zero in the national (significant) number of an
  /// Italian phone number indicates the number is a fixed-line number.  There
  /// have been plans to migrate fixed-line numbers to start with the digit two
  /// since December 2000, but it has not happened yet. See
  /// http://en.wikipedia.org/wiki/%2B39 for more details.
  ///
  /// These fields can be safely ignored (there is no need to set them) for most
  /// countries. Some limited number of countries behave like Italy - for these
  /// cases, if the leading zero(s) of a number would be retained even when
  /// dialling internationally, set this flag to true, and also set the number of
  /// leading zeros.
  ///
  /// Clients who use the parsing functionality of the i18n phone
  /// number libraries will have these fields set if necessary automatically.
  @$pb.TagNumber(4)
  $core.bool get italianLeadingZero => $_getBF(3);
  @$pb.TagNumber(4)
  set italianLeadingZero($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasItalianLeadingZero() => $_has(3);
  @$pb.TagNumber(4)
  void clearItalianLeadingZero() => $_clearField(4);

  /// This field is used to store the raw input string containing phone numbers
  /// before it was canonicalized by the library. For example, it could be used
  /// to store alphanumerical numbers such as "1-800-GOOG-411".
  @$pb.TagNumber(5)
  $core.String get rawInput => $_getSZ(4);
  @$pb.TagNumber(5)
  set rawInput($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRawInput() => $_has(4);
  @$pb.TagNumber(5)
  void clearRawInput() => $_clearField(5);

  /// The source from which the country_code is derived.
  @$pb.TagNumber(6)
  PhoneNumber_CountryCodeSource get countryCodeSource => $_getN(5);
  @$pb.TagNumber(6)
  set countryCodeSource(PhoneNumber_CountryCodeSource value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCountryCodeSource() => $_has(5);
  @$pb.TagNumber(6)
  void clearCountryCodeSource() => $_clearField(6);

  /// The carrier selection code that is preferred when calling this phone number
  /// domestically. This also includes codes that need to be dialed in some
  /// countries when calling from landlines to mobiles or vice versa. For
  /// example, in Columbia, a "3" needs to be dialed before the phone number
  /// itself when calling from a mobile phone to a domestic landline phone and
  /// vice versa.
  ///
  /// Note this is the "preferred" code, which means other codes may work as
  /// well.
  @$pb.TagNumber(7)
  $core.String get preferredDomesticCarrierCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set preferredDomesticCarrierCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPreferredDomesticCarrierCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearPreferredDomesticCarrierCode() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get numberOfLeadingZeros => $_getI(7, 1);
  @$pb.TagNumber(8)
  set numberOfLeadingZeros($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasNumberOfLeadingZeros() => $_has(7);
  @$pb.TagNumber(8)
  void clearNumberOfLeadingZeros() => $_clearField(8);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
