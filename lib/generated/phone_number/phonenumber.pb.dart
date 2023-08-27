//
//  Generated code. Do not modify.
//  source: resources/phonenumber.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'phonenumber.pbenum.dart';

export 'phonenumber.pbenum.dart';

class PhoneNumber extends $pb.GeneratedMessage {
  factory PhoneNumber() => create();
  PhoneNumber._() : super();
  factory PhoneNumber.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PhoneNumber.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PhoneNumber',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'i18n.phonenumbers'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'countryCode', $pb.PbFieldType.Q3)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'nationalNumber', $pb.PbFieldType.QU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'extension')
    ..aOB(4, _omitFieldNames ? '' : 'italianLeadingZero')
    ..aOS(5, _omitFieldNames ? '' : 'rawInput')
    ..e<PhoneNumber_CountryCodeSource>(
        6, _omitFieldNames ? '' : 'countryCodeSource', $pb.PbFieldType.OE,
        defaultOrMaker: PhoneNumber_CountryCodeSource.UNSPECIFIED,
        valueOf: PhoneNumber_CountryCodeSource.valueOf,
        enumValues: PhoneNumber_CountryCodeSource.values)
    ..aOS(7, _omitFieldNames ? '' : 'preferredDomesticCarrierCode')
    ..a<$core.int>(
        8, _omitFieldNames ? '' : 'numberOfLeadingZeros', $pb.PbFieldType.O3,
        defaultOrMaker: 1);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PhoneNumber clone() => PhoneNumber()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PhoneNumber copyWith(void Function(PhoneNumber) updates) =>
      super.copyWith((message) => updates(message as PhoneNumber))
          as PhoneNumber;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PhoneNumber create() => PhoneNumber._();
  PhoneNumber createEmptyInstance() => create();
  static $pb.PbList<PhoneNumber> createRepeated() => $pb.PbList<PhoneNumber>();
  @$core.pragma('dart2js:noInline')
  static PhoneNumber getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PhoneNumber>(create);
  static PhoneNumber? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get countryCode => $_getIZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get nationalNumber => $_getI64(1);
  @$pb.TagNumber(2)
  set nationalNumber($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNationalNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearNationalNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get extension_3 => $_getSZ(2);
  @$pb.TagNumber(3)
  set extension_3($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasExtension_3() => $_has(2);
  @$pb.TagNumber(3)
  void clearExtension_3() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get italianLeadingZero => $_getBF(3);
  @$pb.TagNumber(4)
  set italianLeadingZero($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasItalianLeadingZero() => $_has(3);
  @$pb.TagNumber(4)
  void clearItalianLeadingZero() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get rawInput => $_getSZ(4);
  @$pb.TagNumber(5)
  set rawInput($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasRawInput() => $_has(4);
  @$pb.TagNumber(5)
  void clearRawInput() => clearField(5);

  @$pb.TagNumber(6)
  PhoneNumber_CountryCodeSource get countryCodeSource => $_getN(5);
  @$pb.TagNumber(6)
  set countryCodeSource(PhoneNumber_CountryCodeSource v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasCountryCodeSource() => $_has(5);
  @$pb.TagNumber(6)
  void clearCountryCodeSource() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get preferredDomesticCarrierCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set preferredDomesticCarrierCode($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasPreferredDomesticCarrierCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearPreferredDomesticCarrierCode() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get numberOfLeadingZeros => $_getI(7, 1);
  @$pb.TagNumber(8)
  set numberOfLeadingZeros($core.int v) {
    $_setSignedInt32(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasNumberOfLeadingZeros() => $_has(7);
  @$pb.TagNumber(8)
  void clearNumberOfLeadingZeros() => clearField(8);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
