//
//  Generated code. Do not modify.
//  source: resources/phonemetadata.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class NumberFormat extends $pb.GeneratedMessage {
  factory NumberFormat() => create();
  NumberFormat._() : super();
  factory NumberFormat.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NumberFormat.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NumberFormat',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'i18n.phonenumbers'),
      createEmptyInstance: create)
    ..aQS(1, _omitFieldNames ? '' : 'pattern')
    ..aQS(2, _omitFieldNames ? '' : 'format')
    ..pPS(3, _omitFieldNames ? '' : 'leadingDigitsPattern')
    ..aOS(4, _omitFieldNames ? '' : 'nationalPrefixFormattingRule')
    ..aOS(5, _omitFieldNames ? '' : 'domesticCarrierCodeFormattingRule')
    ..aOB(6, _omitFieldNames ? '' : 'nationalPrefixOptionalWhenFormatting');

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NumberFormat clone() => NumberFormat()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NumberFormat copyWith(void Function(NumberFormat) updates) =>
      super.copyWith((message) => updates(message as NumberFormat))
          as NumberFormat;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NumberFormat create() => NumberFormat._();
  NumberFormat createEmptyInstance() => create();
  static $pb.PbList<NumberFormat> createRepeated() =>
      $pb.PbList<NumberFormat>();
  @$core.pragma('dart2js:noInline')
  static NumberFormat getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NumberFormat>(create);
  static NumberFormat? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get pattern => $_getSZ(0);
  @$pb.TagNumber(1)
  set pattern($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPattern() => $_has(0);
  @$pb.TagNumber(1)
  void clearPattern() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get format => $_getSZ(1);
  @$pb.TagNumber(2)
  set format($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFormat() => $_has(1);
  @$pb.TagNumber(2)
  void clearFormat() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get leadingDigitsPattern => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get nationalPrefixFormattingRule => $_getSZ(3);
  @$pb.TagNumber(4)
  set nationalPrefixFormattingRule($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasNationalPrefixFormattingRule() => $_has(3);
  @$pb.TagNumber(4)
  void clearNationalPrefixFormattingRule() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get domesticCarrierCodeFormattingRule => $_getSZ(4);
  @$pb.TagNumber(5)
  set domesticCarrierCodeFormattingRule($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasDomesticCarrierCodeFormattingRule() => $_has(4);
  @$pb.TagNumber(5)
  void clearDomesticCarrierCodeFormattingRule() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get nationalPrefixOptionalWhenFormatting => $_getBF(5);
  @$pb.TagNumber(6)
  set nationalPrefixOptionalWhenFormatting($core.bool v) {
    $_setBool(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasNationalPrefixOptionalWhenFormatting() => $_has(5);
  @$pb.TagNumber(6)
  void clearNationalPrefixOptionalWhenFormatting() => clearField(6);
}

class PhoneNumberDesc extends $pb.GeneratedMessage {
  factory PhoneNumberDesc() => create();
  PhoneNumberDesc._() : super();
  factory PhoneNumberDesc.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PhoneNumberDesc.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PhoneNumberDesc',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'i18n.phonenumbers'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'nationalNumberPattern')
    ..aOS(6, _omitFieldNames ? '' : 'exampleNumber')
    ..p<$core.int>(
        9, _omitFieldNames ? '' : 'possibleLength', $pb.PbFieldType.P3)
    ..p<$core.int>(10, _omitFieldNames ? '' : 'possibleLengthLocalOnly',
        $pb.PbFieldType.P3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PhoneNumberDesc clone() => PhoneNumberDesc()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PhoneNumberDesc copyWith(void Function(PhoneNumberDesc) updates) =>
      super.copyWith((message) => updates(message as PhoneNumberDesc))
          as PhoneNumberDesc;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PhoneNumberDesc create() => PhoneNumberDesc._();
  PhoneNumberDesc createEmptyInstance() => create();
  static $pb.PbList<PhoneNumberDesc> createRepeated() =>
      $pb.PbList<PhoneNumberDesc>();
  @$core.pragma('dart2js:noInline')
  static PhoneNumberDesc getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PhoneNumberDesc>(create);
  static PhoneNumberDesc? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get nationalNumberPattern => $_getSZ(0);
  @$pb.TagNumber(2)
  set nationalNumberPattern($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNationalNumberPattern() => $_has(0);
  @$pb.TagNumber(2)
  void clearNationalNumberPattern() => clearField(2);

  @$pb.TagNumber(6)
  $core.String get exampleNumber => $_getSZ(1);
  @$pb.TagNumber(6)
  set exampleNumber($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasExampleNumber() => $_has(1);
  @$pb.TagNumber(6)
  void clearExampleNumber() => clearField(6);

  @$pb.TagNumber(9)
  $core.List<$core.int> get possibleLength => $_getList(2);

  @$pb.TagNumber(10)
  $core.List<$core.int> get possibleLengthLocalOnly => $_getList(3);
}

class PhoneMetadata extends $pb.GeneratedMessage {
  factory PhoneMetadata() => create();
  PhoneMetadata._() : super();
  factory PhoneMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PhoneMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PhoneMetadata',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'i18n.phonenumbers'),
      createEmptyInstance: create)
    ..aOM<PhoneNumberDesc>(1, _omitFieldNames ? '' : 'generalDesc',
        subBuilder: PhoneNumberDesc.create)
    ..aOM<PhoneNumberDesc>(2, _omitFieldNames ? '' : 'fixedLine',
        subBuilder: PhoneNumberDesc.create)
    ..aOM<PhoneNumberDesc>(3, _omitFieldNames ? '' : 'mobile',
        subBuilder: PhoneNumberDesc.create)
    ..aOM<PhoneNumberDesc>(4, _omitFieldNames ? '' : 'tollFree',
        subBuilder: PhoneNumberDesc.create)
    ..aOM<PhoneNumberDesc>(5, _omitFieldNames ? '' : 'premiumRate',
        subBuilder: PhoneNumberDesc.create)
    ..aOM<PhoneNumberDesc>(6, _omitFieldNames ? '' : 'sharedCost',
        subBuilder: PhoneNumberDesc.create)
    ..aOM<PhoneNumberDesc>(7, _omitFieldNames ? '' : 'personalNumber',
        subBuilder: PhoneNumberDesc.create)
    ..aOM<PhoneNumberDesc>(8, _omitFieldNames ? '' : 'voip',
        subBuilder: PhoneNumberDesc.create)
    ..aQS(9, _omitFieldNames ? '' : 'id')
    ..a<$core.int>(10, _omitFieldNames ? '' : 'countryCode', $pb.PbFieldType.O3)
    ..aOS(11, _omitFieldNames ? '' : 'internationalPrefix')
    ..aOS(12, _omitFieldNames ? '' : 'nationalPrefix')
    ..aOS(13, _omitFieldNames ? '' : 'preferredExtnPrefix')
    ..aOS(15, _omitFieldNames ? '' : 'nationalPrefixForParsing')
    ..aOS(16, _omitFieldNames ? '' : 'nationalPrefixTransformRule')
    ..aOS(17, _omitFieldNames ? '' : 'preferredInternationalPrefix')
    ..aOB(18, _omitFieldNames ? '' : 'sameMobileAndFixedLinePattern')
    ..pc<NumberFormat>(
        19, _omitFieldNames ? '' : 'numberFormat', $pb.PbFieldType.PM,
        subBuilder: NumberFormat.create)
    ..pc<NumberFormat>(
        20, _omitFieldNames ? '' : 'intlNumberFormat', $pb.PbFieldType.PM,
        subBuilder: NumberFormat.create)
    ..aOM<PhoneNumberDesc>(21, _omitFieldNames ? '' : 'pager',
        subBuilder: PhoneNumberDesc.create)
    ..aOB(22, _omitFieldNames ? '' : 'mainCountryForCode')
    ..aOS(23, _omitFieldNames ? '' : 'leadingDigits')
    ..aOM<PhoneNumberDesc>(24, _omitFieldNames ? '' : 'noInternationalDialling',
        subBuilder: PhoneNumberDesc.create)
    ..aOM<PhoneNumberDesc>(25, _omitFieldNames ? '' : 'uan',
        subBuilder: PhoneNumberDesc.create)
    ..aOM<PhoneNumberDesc>(27, _omitFieldNames ? '' : 'emergency',
        subBuilder: PhoneNumberDesc.create)
    ..aOM<PhoneNumberDesc>(28, _omitFieldNames ? '' : 'voicemail',
        subBuilder: PhoneNumberDesc.create)
    ..aOM<PhoneNumberDesc>(29, _omitFieldNames ? '' : 'shortCode',
        subBuilder: PhoneNumberDesc.create)
    ..aOM<PhoneNumberDesc>(30, _omitFieldNames ? '' : 'standardRate',
        subBuilder: PhoneNumberDesc.create)
    ..aOM<PhoneNumberDesc>(31, _omitFieldNames ? '' : 'carrierSpecific',
        subBuilder: PhoneNumberDesc.create)
    ..aOB(32, _omitFieldNames ? '' : 'mobileNumberPortableRegion')
    ..aOM<PhoneNumberDesc>(33, _omitFieldNames ? '' : 'smsServices',
        subBuilder: PhoneNumberDesc.create);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PhoneMetadata clone() => PhoneMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PhoneMetadata copyWith(void Function(PhoneMetadata) updates) =>
      super.copyWith((message) => updates(message as PhoneMetadata))
          as PhoneMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PhoneMetadata create() => PhoneMetadata._();
  PhoneMetadata createEmptyInstance() => create();
  static $pb.PbList<PhoneMetadata> createRepeated() =>
      $pb.PbList<PhoneMetadata>();
  @$core.pragma('dart2js:noInline')
  static PhoneMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PhoneMetadata>(create);
  static PhoneMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  PhoneNumberDesc get generalDesc => $_getN(0);
  @$pb.TagNumber(1)
  set generalDesc(PhoneNumberDesc v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasGeneralDesc() => $_has(0);
  @$pb.TagNumber(1)
  void clearGeneralDesc() => clearField(1);
  @$pb.TagNumber(1)
  PhoneNumberDesc ensureGeneralDesc() => $_ensure(0);

  @$pb.TagNumber(2)
  PhoneNumberDesc get fixedLine => $_getN(1);
  @$pb.TagNumber(2)
  set fixedLine(PhoneNumberDesc v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFixedLine() => $_has(1);
  @$pb.TagNumber(2)
  void clearFixedLine() => clearField(2);
  @$pb.TagNumber(2)
  PhoneNumberDesc ensureFixedLine() => $_ensure(1);

  @$pb.TagNumber(3)
  PhoneNumberDesc get mobile => $_getN(2);
  @$pb.TagNumber(3)
  set mobile(PhoneNumberDesc v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasMobile() => $_has(2);
  @$pb.TagNumber(3)
  void clearMobile() => clearField(3);
  @$pb.TagNumber(3)
  PhoneNumberDesc ensureMobile() => $_ensure(2);

  @$pb.TagNumber(4)
  PhoneNumberDesc get tollFree => $_getN(3);
  @$pb.TagNumber(4)
  set tollFree(PhoneNumberDesc v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasTollFree() => $_has(3);
  @$pb.TagNumber(4)
  void clearTollFree() => clearField(4);
  @$pb.TagNumber(4)
  PhoneNumberDesc ensureTollFree() => $_ensure(3);

  @$pb.TagNumber(5)
  PhoneNumberDesc get premiumRate => $_getN(4);
  @$pb.TagNumber(5)
  set premiumRate(PhoneNumberDesc v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasPremiumRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearPremiumRate() => clearField(5);
  @$pb.TagNumber(5)
  PhoneNumberDesc ensurePremiumRate() => $_ensure(4);

  @$pb.TagNumber(6)
  PhoneNumberDesc get sharedCost => $_getN(5);
  @$pb.TagNumber(6)
  set sharedCost(PhoneNumberDesc v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasSharedCost() => $_has(5);
  @$pb.TagNumber(6)
  void clearSharedCost() => clearField(6);
  @$pb.TagNumber(6)
  PhoneNumberDesc ensureSharedCost() => $_ensure(5);

  @$pb.TagNumber(7)
  PhoneNumberDesc get personalNumber => $_getN(6);
  @$pb.TagNumber(7)
  set personalNumber(PhoneNumberDesc v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasPersonalNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearPersonalNumber() => clearField(7);
  @$pb.TagNumber(7)
  PhoneNumberDesc ensurePersonalNumber() => $_ensure(6);

  @$pb.TagNumber(8)
  PhoneNumberDesc get voip => $_getN(7);
  @$pb.TagNumber(8)
  set voip(PhoneNumberDesc v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasVoip() => $_has(7);
  @$pb.TagNumber(8)
  void clearVoip() => clearField(8);
  @$pb.TagNumber(8)
  PhoneNumberDesc ensureVoip() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.String get id => $_getSZ(8);
  @$pb.TagNumber(9)
  set id($core.String v) {
    $_setString(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasId() => $_has(8);
  @$pb.TagNumber(9)
  void clearId() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get countryCode => $_getIZ(9);
  @$pb.TagNumber(10)
  set countryCode($core.int v) {
    $_setSignedInt32(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasCountryCode() => $_has(9);
  @$pb.TagNumber(10)
  void clearCountryCode() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get internationalPrefix => $_getSZ(10);
  @$pb.TagNumber(11)
  set internationalPrefix($core.String v) {
    $_setString(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasInternationalPrefix() => $_has(10);
  @$pb.TagNumber(11)
  void clearInternationalPrefix() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get nationalPrefix => $_getSZ(11);
  @$pb.TagNumber(12)
  set nationalPrefix($core.String v) {
    $_setString(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasNationalPrefix() => $_has(11);
  @$pb.TagNumber(12)
  void clearNationalPrefix() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get preferredExtnPrefix => $_getSZ(12);
  @$pb.TagNumber(13)
  set preferredExtnPrefix($core.String v) {
    $_setString(12, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasPreferredExtnPrefix() => $_has(12);
  @$pb.TagNumber(13)
  void clearPreferredExtnPrefix() => clearField(13);

  @$pb.TagNumber(15)
  $core.String get nationalPrefixForParsing => $_getSZ(13);
  @$pb.TagNumber(15)
  set nationalPrefixForParsing($core.String v) {
    $_setString(13, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasNationalPrefixForParsing() => $_has(13);
  @$pb.TagNumber(15)
  void clearNationalPrefixForParsing() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get nationalPrefixTransformRule => $_getSZ(14);
  @$pb.TagNumber(16)
  set nationalPrefixTransformRule($core.String v) {
    $_setString(14, v);
  }

  @$pb.TagNumber(16)
  $core.bool hasNationalPrefixTransformRule() => $_has(14);
  @$pb.TagNumber(16)
  void clearNationalPrefixTransformRule() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get preferredInternationalPrefix => $_getSZ(15);
  @$pb.TagNumber(17)
  set preferredInternationalPrefix($core.String v) {
    $_setString(15, v);
  }

  @$pb.TagNumber(17)
  $core.bool hasPreferredInternationalPrefix() => $_has(15);
  @$pb.TagNumber(17)
  void clearPreferredInternationalPrefix() => clearField(17);

  @$pb.TagNumber(18)
  $core.bool get sameMobileAndFixedLinePattern => $_getBF(16);
  @$pb.TagNumber(18)
  set sameMobileAndFixedLinePattern($core.bool v) {
    $_setBool(16, v);
  }

  @$pb.TagNumber(18)
  $core.bool hasSameMobileAndFixedLinePattern() => $_has(16);
  @$pb.TagNumber(18)
  void clearSameMobileAndFixedLinePattern() => clearField(18);

  @$pb.TagNumber(19)
  $core.List<NumberFormat> get numberFormat => $_getList(17);

  @$pb.TagNumber(20)
  $core.List<NumberFormat> get intlNumberFormat => $_getList(18);

  @$pb.TagNumber(21)
  PhoneNumberDesc get pager => $_getN(19);
  @$pb.TagNumber(21)
  set pager(PhoneNumberDesc v) {
    setField(21, v);
  }

  @$pb.TagNumber(21)
  $core.bool hasPager() => $_has(19);
  @$pb.TagNumber(21)
  void clearPager() => clearField(21);
  @$pb.TagNumber(21)
  PhoneNumberDesc ensurePager() => $_ensure(19);

  @$pb.TagNumber(22)
  $core.bool get mainCountryForCode => $_getBF(20);
  @$pb.TagNumber(22)
  set mainCountryForCode($core.bool v) {
    $_setBool(20, v);
  }

  @$pb.TagNumber(22)
  $core.bool hasMainCountryForCode() => $_has(20);
  @$pb.TagNumber(22)
  void clearMainCountryForCode() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get leadingDigits => $_getSZ(21);
  @$pb.TagNumber(23)
  set leadingDigits($core.String v) {
    $_setString(21, v);
  }

  @$pb.TagNumber(23)
  $core.bool hasLeadingDigits() => $_has(21);
  @$pb.TagNumber(23)
  void clearLeadingDigits() => clearField(23);

  @$pb.TagNumber(24)
  PhoneNumberDesc get noInternationalDialling => $_getN(22);
  @$pb.TagNumber(24)
  set noInternationalDialling(PhoneNumberDesc v) {
    setField(24, v);
  }

  @$pb.TagNumber(24)
  $core.bool hasNoInternationalDialling() => $_has(22);
  @$pb.TagNumber(24)
  void clearNoInternationalDialling() => clearField(24);
  @$pb.TagNumber(24)
  PhoneNumberDesc ensureNoInternationalDialling() => $_ensure(22);

  @$pb.TagNumber(25)
  PhoneNumberDesc get uan => $_getN(23);
  @$pb.TagNumber(25)
  set uan(PhoneNumberDesc v) {
    setField(25, v);
  }

  @$pb.TagNumber(25)
  $core.bool hasUan() => $_has(23);
  @$pb.TagNumber(25)
  void clearUan() => clearField(25);
  @$pb.TagNumber(25)
  PhoneNumberDesc ensureUan() => $_ensure(23);

  @$pb.TagNumber(27)
  PhoneNumberDesc get emergency => $_getN(24);
  @$pb.TagNumber(27)
  set emergency(PhoneNumberDesc v) {
    setField(27, v);
  }

  @$pb.TagNumber(27)
  $core.bool hasEmergency() => $_has(24);
  @$pb.TagNumber(27)
  void clearEmergency() => clearField(27);
  @$pb.TagNumber(27)
  PhoneNumberDesc ensureEmergency() => $_ensure(24);

  @$pb.TagNumber(28)
  PhoneNumberDesc get voicemail => $_getN(25);
  @$pb.TagNumber(28)
  set voicemail(PhoneNumberDesc v) {
    setField(28, v);
  }

  @$pb.TagNumber(28)
  $core.bool hasVoicemail() => $_has(25);
  @$pb.TagNumber(28)
  void clearVoicemail() => clearField(28);
  @$pb.TagNumber(28)
  PhoneNumberDesc ensureVoicemail() => $_ensure(25);

  @$pb.TagNumber(29)
  PhoneNumberDesc get shortCode => $_getN(26);
  @$pb.TagNumber(29)
  set shortCode(PhoneNumberDesc v) {
    setField(29, v);
  }

  @$pb.TagNumber(29)
  $core.bool hasShortCode() => $_has(26);
  @$pb.TagNumber(29)
  void clearShortCode() => clearField(29);
  @$pb.TagNumber(29)
  PhoneNumberDesc ensureShortCode() => $_ensure(26);

  @$pb.TagNumber(30)
  PhoneNumberDesc get standardRate => $_getN(27);
  @$pb.TagNumber(30)
  set standardRate(PhoneNumberDesc v) {
    setField(30, v);
  }

  @$pb.TagNumber(30)
  $core.bool hasStandardRate() => $_has(27);
  @$pb.TagNumber(30)
  void clearStandardRate() => clearField(30);
  @$pb.TagNumber(30)
  PhoneNumberDesc ensureStandardRate() => $_ensure(27);

  @$pb.TagNumber(31)
  PhoneNumberDesc get carrierSpecific => $_getN(28);
  @$pb.TagNumber(31)
  set carrierSpecific(PhoneNumberDesc v) {
    setField(31, v);
  }

  @$pb.TagNumber(31)
  $core.bool hasCarrierSpecific() => $_has(28);
  @$pb.TagNumber(31)
  void clearCarrierSpecific() => clearField(31);
  @$pb.TagNumber(31)
  PhoneNumberDesc ensureCarrierSpecific() => $_ensure(28);

  @$pb.TagNumber(32)
  $core.bool get mobileNumberPortableRegion => $_getBF(29);
  @$pb.TagNumber(32)
  set mobileNumberPortableRegion($core.bool v) {
    $_setBool(29, v);
  }

  @$pb.TagNumber(32)
  $core.bool hasMobileNumberPortableRegion() => $_has(29);
  @$pb.TagNumber(32)
  void clearMobileNumberPortableRegion() => clearField(32);

  @$pb.TagNumber(33)
  PhoneNumberDesc get smsServices => $_getN(30);
  @$pb.TagNumber(33)
  set smsServices(PhoneNumberDesc v) {
    setField(33, v);
  }

  @$pb.TagNumber(33)
  $core.bool hasSmsServices() => $_has(30);
  @$pb.TagNumber(33)
  void clearSmsServices() => clearField(33);
  @$pb.TagNumber(33)
  PhoneNumberDesc ensureSmsServices() => $_ensure(30);
}

class PhoneMetadataCollection extends $pb.GeneratedMessage {
  factory PhoneMetadataCollection() => create();
  PhoneMetadataCollection._() : super();
  factory PhoneMetadataCollection.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PhoneMetadataCollection.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PhoneMetadataCollection',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'i18n.phonenumbers'),
      createEmptyInstance: create)
    ..pc<PhoneMetadata>(
        1, _omitFieldNames ? '' : 'metadata', $pb.PbFieldType.PM,
        subBuilder: PhoneMetadata.create);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PhoneMetadataCollection clone() =>
      PhoneMetadataCollection()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PhoneMetadataCollection copyWith(
          void Function(PhoneMetadataCollection) updates) =>
      super.copyWith((message) => updates(message as PhoneMetadataCollection))
          as PhoneMetadataCollection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PhoneMetadataCollection create() => PhoneMetadataCollection._();
  PhoneMetadataCollection createEmptyInstance() => create();
  static $pb.PbList<PhoneMetadataCollection> createRepeated() =>
      $pb.PbList<PhoneMetadataCollection>();
  @$core.pragma('dart2js:noInline')
  static PhoneMetadataCollection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PhoneMetadataCollection>(create);
  static PhoneMetadataCollection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PhoneMetadata> get metadata => $_getList(0);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
