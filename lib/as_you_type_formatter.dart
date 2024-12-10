// Based on the original JavaScript code: .../phonenumbers/asyoutypeformatter.js
//
// Copyright (C) 2010 The Libphonenumber Authors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:math';
import 'package:meta/meta.dart';
import 'generated/classes/phone_metadata/phonemetadata.pb.dart';
import 'phone_number_util.dart';

/// A formatter which formats phone numbers as they are entered.
/// (based on the java implementation).
///
/// <p>An AsYouTypeFormatter can be created by new AsYouTypeFormatter(). After
/// that, digits can be added by invoking [inputDigit] on the formatter
/// instance, and the partially formatted phone number will be returned each time
/// a digit is added. [clear] can be invoked before formatting a new
/// number.
///
/// <p>See the unittests for more details on how the formatter is to be used.
///

/// Constructs an AsYouTypeFormatter for the specific region.
///
/// `regionCode` the CLDR two-letter region code that denotes the
/// region where the phone number is being entered.
class AsYouTypeFormatter {
  final PhoneNumberUtil _phoneUtil;

  final RegExp _digitPattern = RegExp(_digitPlaceholder);

  /// A pattern that is used to determine if a numberFormat under availableFormats
  /// is eligible to be used by the AYTF. It is eligible when the format element
  /// under numberFormat contains groups of the dollar sign followed by a single
  /// digit, separated by valid phone number punctuation. This prevents invalid
  /// punctuation (such as the star sign in Israeli star numbers) getting into the
  /// output of the AYTF. We require that the first group is present in the output
  /// pattern to ensure no data is lost while formatting; when we format as you
  /// type, this should always be the case.
  final RegExp _eligibleFormatPattern =
      RegExp('[${PhoneNumberUtil.validPunctuation}]*'
          r'\$1'
          '[${PhoneNumberUtil.validPunctuation}]*(\\\$\\d'
          '[${PhoneNumberUtil.validPunctuation}]*)*');

  /// A set of characters that, if found in a national prefix formatting rules, are
  /// an indicator to us that we should separate the national prefix from the
  /// number when formatting.
  final RegExp _nationalPrefixSeparatorsPattern = RegExp(r'[- ]');

  final StringBuffer _formattingTemplate = StringBuffer();

  final StringBuffer _accruedInput = StringBuffer();

  final StringBuffer _accruedInputWithoutFormatting = StringBuffer();

  /// This contains anything that has been entered so far preceding the national
  /// significant number, and it is formatted (e.g. with space inserted). For
  /// example, this can contain IDD, country code, and/or NDD, etc.
  final StringBuffer _prefixBeforeNationalNumber = StringBuffer();

  final StringBuffer _nationalNumber = StringBuffer();

  /// The digits that have not been entered yet will be represented by a \u2008,
  /// the punctuation space.
  static const String _digitPlaceholder = '\u2008';

  String _currentOutput = '';

  /// The pattern from numberFormat that is currently used to create
  /// formattingTemplate.
  String _currentFormattingPattern = '';

  /// This contains the national prefix that has been extracted. It contains only
  /// digits without formatting.
  String _extractedNationalPrefix = '';

  final String _defaultCountry;

  /// Character used when appropriate to separate a prefix, such as a long NDD or a
  /// country calling code, from the national number.
  final String _separatorBeforeNationalNumber = ' ';

  /// This indicates whether AsYouTypeFormatter is currently doing the
  /// formatting.
  bool _ableToFormat = true;

  /// Set to true when users enter their own formatting. AsYouTypeFormatter will
  /// do no formatting at all when this is set to true.
  bool _inputHasFormatting = false;

  /// This is set to true when we know the user is entering a full national
  /// significant number, since we have either detected a national prefix or an
  /// international dialing prefix. When this is true, we will no longer use
  /// local number formatting patterns.
  bool _isCompleteNumber = false;

  bool _isExpectingCountryCallingCode = false;

  bool _shouldAddSpaceAfterNationalPrefix = false;

  int _lastMatchPosition = 0;

  /// The position of a digit upon which inputDigitAndRememberPosition is most
  /// recently invoked, as found in the original sequence of characters the user
  /// entered.
  int _originalPosition = 0;

  /// The position of a digit upon which inputDigitAndRememberPosition is most
  /// recently invoked, as found in accruedInputWithoutFormatting.
  /// entered.
  int _positionToRemember = 0;

  /// This is the minimum length of national number accrued that is required to
  /// trigger the formatter. The first element of the leadingDigitsPattern of
  /// each numberFormat contains a regular expression that matches up to this
  /// number of digits.
  final int _minLeadingDigitsLength = 3;

  final List<NumberFormat> _possibleFormats = [];

  late PhoneMetadata _currentMetadata;

  late PhoneMetadata _defaultMetadata;

  final PhoneMetadata _emptyMetadata = PhoneMetadata()
    ..internationalPrefix = 'NA';

  @internal
  AsYouTypeFormatter(String regionCode, PhoneNumberUtil phoneUtil)
      : _phoneUtil = phoneUtil,
        _defaultCountry = regionCode {
    _currentMetadata = _getMetadataForRegion(_defaultCountry);
    _defaultMetadata = _currentMetadata;
  }

  /// The metadata needed by this class is the same for all regions sharing the
  /// same country calling code. Therefore, we return the metadata for 'main'
  /// region for this country calling code.
  /// [regionCode] an ISO 3166-1 two-letter region code.
  /// returns main metadata for this region.
  PhoneMetadata _getMetadataForRegion(String regionCode) {
    final int countryCallingCode =
        _phoneUtil.getCountryCodeForRegion(regionCode);
    final String mainCountry =
        _phoneUtil.getRegionCodeForCountryCode(countryCallingCode);
    final PhoneMetadata? metadata =
        _phoneUtil.getMetadataForRegion(regionCode: mainCountry);

    if (metadata != null) {
      return metadata;
    }

    // Set to a default instance of the metadata. This allows us to function with
    // an incorrect region code, even if formatting only works for numbers
    // specified with '+'.
    return _emptyMetadata;
  }

  /// returns true if a new template is created as opposed to reusing the existing template.
  bool _maybeCreateNewTemplate() {
    // When there are multiple available formats, the formatter uses the first
    // format where a formatting template could be created.
    for (final NumberFormat numberFormat in _possibleFormats) {
      final String pattern = numberFormat.pattern;

      if (_currentFormattingPattern == pattern) {
        return false;
      }

      if (_createFormattingTemplate(numberFormat)) {
        _currentFormattingPattern = pattern;
        _shouldAddSpaceAfterNationalPrefix = _nationalPrefixSeparatorsPattern
            .hasMatch(numberFormat.nationalPrefixFormattingRule);
        // With a new formatting template, the matched position using the old
        // template needs to be reset.
        _lastMatchPosition = 0;
        return true;
      }
    }

    _ableToFormat = false;

    return false;
  }

  bool _createFormattingTemplate(NumberFormat format) {
    final String numberPattern = format.pattern;

    _formattingTemplate.clear();

    final String tempTemplate =
        _getFormattingTemplate(numberPattern, format.format);

    if (tempTemplate.isNotEmpty) {
      _formattingTemplate.write(tempTemplate);
      return true;
    }

    return false;
  }

  /// Gets a formatting template which can be used to efficiently format a
  /// partial number where digits are added one by one.
  String _getFormattingTemplate(String numberPattern, String numberFormat) {
    // Creates a phone number consisting only of the digit 9 that matches the
    // numberPattern by applying the pattern to the longestPhoneNumber string.
    final String longestPhoneNumber = '999999999999999';
    final RegExp regExp = RegExp(numberPattern);
    final RegExpMatch? m = regExp.firstMatch(longestPhoneNumber);
    final String aPhoneNumber = m?.group(0) ?? '';

    // No formatting template can be created if the number of digits entered so far
    // is longer than
    // the maximum the current formatting rule can accommodate.
    if (aPhoneNumber.length < _nationalNumber.length) {
      return '';
    }

    // Formats the number according to numberFormat
    final String template = _phoneUtil.replaceAllAndFormat(
      aPhoneNumber,
      RegExp(numberPattern),
      numberFormat,
    );

    // Replaces each digit with character DIGIT_PLACEHOLDER
    return template.replaceAll('9', _digitPlaceholder);
  }

  void _getAvailableFormats(String leadingDigits) {
    // First decide whether we should use international or national number rules.
    final bool isInternationalNumber =
        _isCompleteNumber && _extractedNationalPrefix.isEmpty;

    final List<NumberFormat> formatList =
        (isInternationalNumber && _currentMetadata.intlNumberFormat.isNotEmpty)
            ? _currentMetadata.intlNumberFormat
            : _currentMetadata.numberFormat;

    for (final NumberFormat format in formatList) {
      // Discard a few formats that we know are not relevant based on the
      // presence of the national prefix.
      if (_extractedNationalPrefix.isNotEmpty &&
          PhoneNumberUtil.formattingRuleHasFirstGroupOnly(
              format.nationalPrefixFormattingRule) &&
          !format.nationalPrefixOptionalWhenFormatting &&
          !format.hasDomesticCarrierCodeFormattingRule()) {
        // If it is a national number that had a national prefix, any rules that
        // aren't valid with a national prefix should be excluded. A rule that
        // has a carrier-code formatting rule is kept since the national prefix
        // might actually be an extracted carrier code - we don't distinguish
        // between these when extracting it in the AYTF.
        continue;
      } else if (_extractedNationalPrefix.isEmpty &&
          !PhoneNumberUtil.formattingRuleHasFirstGroupOnly(
              format.nationalPrefixFormattingRule) &&
          !format.nationalPrefixOptionalWhenFormatting &&
          !_isCompleteNumber) {
        // This number was entered without a national prefix, and this formatting
        // rule requires one, so we discard it.
        continue;
      }
      if (_eligibleFormatPattern.hasMatch(format.format)) {
        _possibleFormats.add(format);
      }
    }
    _narrowDownPossibleFormats(leadingDigits);
  }

  void _narrowDownPossibleFormats(String leadingDigits) {
    final int indexOfLeadingDigitsPattern =
        leadingDigits.length - _minLeadingDigitsLength;

    _possibleFormats.removeWhere((format) {
      // Keep everything that isn't restricted by leading digits.
      if (format.leadingDigitsPattern.isEmpty) {
        return false;
      }

      final int lastLeadingDigitsPattern = min(
          indexOfLeadingDigitsPattern, format.leadingDigitsPattern.length - 1);
      final RegExp leadingDigitsPattern =
          RegExp(format.leadingDigitsPattern[lastLeadingDigitsPattern]);
      final RegExpMatch? m = leadingDigitsPattern.firstMatch(leadingDigits);

      return m == null || m.start != 0;
    });
  }

  /// Clears the internal state of the formatter, so it can be reused.
  void clear() {
    _currentOutput = '';
    _accruedInput.clear();
    _accruedInputWithoutFormatting.clear();
    _formattingTemplate.clear();
    _lastMatchPosition = 0;
    _currentFormattingPattern = '';
    _prefixBeforeNationalNumber.clear();
    _extractedNationalPrefix = '';
    _nationalNumber.clear();
    _ableToFormat = true;
    _inputHasFormatting = false;
    _positionToRemember = 0;
    _originalPosition = 0;
    _isCompleteNumber = false;
    _isExpectingCountryCallingCode = false;
    _possibleFormats.clear();
    _shouldAddSpaceAfterNationalPrefix = false;
    if (_currentMetadata != _defaultMetadata) {
      _currentMetadata = _getMetadataForRegion(_defaultCountry);
    }
  }

  /// Formats a phone number on-the-fly as each digit is entered.
  ///
  /// [nextChar] the most recently entered digit of a phone number.
  /// Formatting characters are allowed, but as soon as they are encountered
  /// this method formats the number as entered and not 'as you type' anymore.
  /// Full width digits and Arabic-indic digits are allowed, and will be shown
  /// as they are.
  /// returns the partially formatted phone number.
  String inputDigit(String nextChar) {
    _currentOutput = _inputDigitWithOptionToRememberPosition(nextChar, false);
    return _currentOutput;
  }

  /// Same as [inputDigit], but remembers the position where
  /// [nextChar] is inserted, so that it can be retrieved later by using
  /// [getRememberedPosition]. The remembered position will be automatically
  /// adjusted if additional formatting characters are later inserted/removed in
  /// front of [nextChar].
  String inputDigitAndRememberPosition(String nextChar) {
    _currentOutput = _inputDigitWithOptionToRememberPosition(nextChar, true);
    return _currentOutput;
  }

  String _inputDigitWithOptionToRememberPosition(
      String nextChar, bool rememberPosition) {
    _accruedInput.write(nextChar);

    if (rememberPosition) {
      _originalPosition = _accruedInput.length;
    }

    // We do formatting on-the-fly only when each character entered is either a
    // digit, or a plus sign (accepted at the start of the number only).
    if (!_isDigitOrLeadingPlusSign(nextChar)) {
      _ableToFormat = false;
      _inputHasFormatting = true;
    } else {
      nextChar =
          _normalizeAndAccrueDigitsAndPlusSign(nextChar, rememberPosition);
    }

    if (!_ableToFormat) {
      // When we are unable to format because of reasons other than that
      // formatting chars have been entered, it can be due to really long IDDs or
      // NDDs. If that is the case, we might be able to do formatting again after
      // extracting them.
      if (_inputHasFormatting) {
        return _accruedInput.toString();
      } else if (_attemptToExtractIdd()) {
        if (_attemptToExtractCountryCallingCode()) {
          return _attemptToChoosePatternWithPrefixExtracted();
        }
      } else if (_ableToExtractLongerNdd()) {
        // Add an additional space to separate long NDD and national significant
        // number for readability. We don't set shouldAddSpaceAfterNationalPrefix_
        // to true, since we don't want this to change later when we choose
        // formatting templates.
        _prefixBeforeNationalNumber.write(_separatorBeforeNationalNumber);
        return _attemptToChoosePatternWithPrefixExtracted();
      }
      return _accruedInput.toString();
    }

    // We start to attempt to format only when at least MIN_LEADING_DIGITS_LENGTH
    // digits (the plus sign is counted as a digit as well for this purpose) have
    // been entered.
    switch (_accruedInputWithoutFormatting.length) {
      case 0:
      case 1:
      case 2:
        return _accruedInput.toString();
      case 3:
        if (_attemptToExtractIdd()) {
          _isExpectingCountryCallingCode = true;
          continue fallthrough;
        } else {
          // No IDD or plus sign is found, might be entering in national format.
          _extractedNationalPrefix = _removeNationalPrefixFromNationalNumber();
          return _attemptToChooseFormattingPattern();
        }
      fallthrough:
      default:
        if (_isExpectingCountryCallingCode) {
          if (_attemptToExtractCountryCallingCode()) {
            _isExpectingCountryCallingCode = false;
          }
          return _prefixBeforeNationalNumber.toString() +
              _nationalNumber.toString();
        }

        if (_possibleFormats.isNotEmpty) {
          // The formatting patterns are already chosen.
          final String tempNationalNumber = _inputDigitHelper(nextChar);
          // See if the accrued digits can be formatted properly already. If not,
          // use the results from inputDigitHelper, which does formatting based on
          // the formatting pattern chosen.

          final String formattedNumber = _attemptToFormatAccruedDigits();
          if (formattedNumber.isNotEmpty) {
            return formattedNumber;
          }

          _narrowDownPossibleFormats(_nationalNumber.toString());

          if (_maybeCreateNewTemplate()) {
            return _inputAccruedNationalNumber();
          }

          return _ableToFormat
              ? _appendNationalNumber(tempNationalNumber)
              : _accruedInput.toString();
        } else {
          return _attemptToChooseFormattingPattern();
        }
    }
  }

  bool _isDigitOrLeadingPlusSign(String nextChar) {
    return PhoneNumberUtil.capturingDigitPattern.hasMatch(nextChar) ||
        (_accruedInput.length == 1 &&
            PhoneNumberUtil.plusCharsPattern.hasMatch(nextChar));
  }

  /// Accrues digits and the plus sign to accruedInputWithoutFormatting for later
  /// use. If nextChar contains a digit in non-ASCII format (e.g. the full-width
  /// version of digits), it is first normalized to the ASCII version. The return
  /// value is nextChar itself, or its normalized version, if nextChar is a digit
  /// in non-ASCII format. This method assumes its input is either a digit or the
  /// plus sign.
  String _normalizeAndAccrueDigitsAndPlusSign(
      String nextChar, bool rememberPosition) {
    String normalizedChar;
    if (nextChar == PhoneNumberUtil.plusSign) {
      normalizedChar = nextChar;
      _accruedInputWithoutFormatting.write(nextChar);
    } else {
      normalizedChar = '${PhoneNumberUtil.characterToDigit(nextChar)}';
      _accruedInputWithoutFormatting.write(normalizedChar);
      _nationalNumber.write(normalizedChar);
    }
    if (rememberPosition) {
      _positionToRemember = _accruedInputWithoutFormatting.length;
    }
    return normalizedChar;
  }

  /// Extracts IDD and plus sign to prefixBeforeNationalNumber when they are
  /// available, and places the remaining input into nationalNumber.
  ///
  /// returns true when accruedInputWithoutFormatting begins with the
  /// plus sign or valid IDD for defaultCountry.
  bool _attemptToExtractIdd() {
    final RegExp internationalPrefix = RegExp(
        '\\${PhoneNumberUtil.plusSign}|${_currentMetadata.internationalPrefix}');
    final RegExpMatch? iddMatcher = internationalPrefix
        .firstMatch(_accruedInputWithoutFormatting.toString());

    if (iddMatcher != null && iddMatcher.start == 0) {
      _isCompleteNumber = true;

      final int startOfCountryCallingCode = iddMatcher.end;

      _nationalNumber
        ..clear()
        ..write(_accruedInputWithoutFormatting
            .toString()
            .substring(startOfCountryCallingCode));

      _prefixBeforeNationalNumber
        ..clear()
        ..write(_accruedInputWithoutFormatting
            .toString()
            .substring(0, startOfCountryCallingCode));

      if (_accruedInputWithoutFormatting.toString()[0] !=
          PhoneNumberUtil.plusSign) {
        _prefixBeforeNationalNumber.write(_separatorBeforeNationalNumber);
      }

      return true;
    }

    return false;
  }

  /// Extracts the country calling code from the beginning of nationalNumber to
  /// prefixBeforeNationalNumber when they are available, and places the remaining
  /// input into nationalNumber.
  ///
  /// returns true when a valid country calling code can be found.
  bool _attemptToExtractCountryCallingCode() {
    if (_nationalNumber.length == 0) {
      return false;
    }

    final StringBuffer numberWithoutCountryCallingCode = StringBuffer();

    final int countryCode = _phoneUtil.extractCountryCode(
      _nationalNumber,
      numberWithoutCountryCallingCode,
    );

    if (countryCode == 0) {
      return false;
    }

    _nationalNumber
      ..clear()
      ..write(numberWithoutCountryCallingCode.toString());

    final String newRegionCode =
        _phoneUtil.getRegionCodeForCountryCode(countryCode);

    _currentMetadata =
        (PhoneNumberUtil.regionCodeForNonGeoEntity == newRegionCode)
            ? _phoneUtil.getMetadataForNonGeographicalRegion(countryCode)!
            : _getMetadataForRegion(newRegionCode);

    _prefixBeforeNationalNumber
      ..write('$countryCode')
      ..write(_separatorBeforeNationalNumber);

    // When we have successfully extracted the IDD, the previously extracted NDD
    // should be cleared because it is no longer valid.
    _extractedNationalPrefix = '';
    return true;
  }

  String _attemptToChoosePatternWithPrefixExtracted() {
    _ableToFormat = true;
    _isExpectingCountryCallingCode = false;
    _possibleFormats.clear();
    _lastMatchPosition = 0;
    _formattingTemplate.clear();
    _currentFormattingPattern = '';
    return _attemptToChooseFormattingPattern();
  }

  /// Attempts to set the formatting template and returns a string which contains
  /// the formatted version of the digits entered so far.
  String _attemptToChooseFormattingPattern() {
    final String nationalNumber = _nationalNumber.toString();

    // We start to attempt to format only when at least _minLeadingDigitsLength
    // digits of national number (excluding national prefix) have been entered.
    if (nationalNumber.length >= _minLeadingDigitsLength) {
      _getAvailableFormats(nationalNumber);
      // See if the accrued digits can be formatted properly already.
      final String formattedNumber = _attemptToFormatAccruedDigits();

      if (formattedNumber.isNotEmpty) {
        return formattedNumber;
      }

      return _maybeCreateNewTemplate()
          ? _inputAccruedNationalNumber()
          : _accruedInput.toString();
    } else {
      return _appendNationalNumber(nationalNumber);
    }
  }

  /// Check to see if there is an exact pattern match for these digits. If so, we
  /// should use this instead of any other formatting template whose
  /// leadingDigitsPattern also matches the input.
  String _attemptToFormatAccruedDigits() {
    for (final NumberFormat numberFormat in _possibleFormats) {
      final RegExp pattern = RegExp(numberFormat.pattern);
      final RegExpMatch? m = pattern.firstMatch(_nationalNumber.toString());

      if (m != null && m.group(0) == _nationalNumber.toString()) {
        _shouldAddSpaceAfterNationalPrefix = _nationalPrefixSeparatorsPattern
            .hasMatch(numberFormat.nationalPrefixFormattingRule);

        final String formattedNumber = _phoneUtil.replaceAllAndFormat(
          _nationalNumber.toString(),
          pattern,
          numberFormat.format,
        );

        // Check that we did not remove nor add any extra digits when we matched
        // this formatting pattern. This usually happens after we entered the last
        // digit during AYTF. Eg: In case of MX, we swallow mobile token (1) when
        // formatted but AYTF should retain all the number entered and not change
        // in order to match a format (of same leading digits and length) display
        // in that way.
        final String fullOutput = _appendNationalNumber(formattedNumber);
        final String formattedNumberDigitsOnly =
            _phoneUtil.normalizeDiallableCharsOnly(fullOutput);

        if (formattedNumberDigitsOnly ==
            _accruedInputWithoutFormatting.toString()) {
          // If it's the same (i.e entered number and format is same), then it's
          // safe to return this in formatted number as nothing is lost / added.
          return fullOutput;
        }
      }
    }

    return '';
  }

  /// Invokes inputDigitHelper on each digit of the national number accrued, and
  /// returns a formatted string in the end.
  String _inputAccruedNationalNumber() {
    final String nationalNumber = _nationalNumber.toString();
    final int lengthOfNationalNumber = nationalNumber.length;

    if (lengthOfNationalNumber > 0) {
      String tempNationalNumber = '';

      for (var i = 0; i < lengthOfNationalNumber; i++) {
        tempNationalNumber = _inputDigitHelper(nationalNumber[i]);
      }

      return _ableToFormat
          ? _appendNationalNumber(tempNationalNumber)
          : _accruedInput.toString();
    } else {
      return _prefixBeforeNationalNumber.toString();
    }
  }

  /// Combines the national number with any prefix (IDD/+ and country code or
  /// national prefix) that was collected. A space will be inserted between them if
  /// the current formatting template indicates this to be suitable.
  String _appendNationalNumber(String nationalNumber) {
    int prefixBeforeNationalNumberLength = _prefixBeforeNationalNumber.length;

    if (_shouldAddSpaceAfterNationalPrefix &&
        prefixBeforeNationalNumberLength > 0 &&
        _prefixBeforeNationalNumber
                .toString()[prefixBeforeNationalNumberLength - 1] !=
            _separatorBeforeNationalNumber) {
      // We want to add a space after the national prefix if the national prefix
      // formatting rule
      // indicates that this would normally be done, with the exception of the case
      // where we already
      // appended a space because the NDD was surprisingly long.
      return '${_prefixBeforeNationalNumber.toString()}$_separatorBeforeNationalNumber$nationalNumber';
    } else {
      return _prefixBeforeNationalNumber.toString() + nationalNumber;
    }
  }

  /// Some national prefixes are a substring of others. If extracting the shorter
  /// NDD doesn't result in a number we can format, we try to see if we can extract
  /// a longer version here.
  bool _ableToExtractLongerNdd() {
    if (extractedNationalPrefix.isNotEmpty) {
      // Put the extracted NDD back to the national number before attempting to
      // extract a new NDD.
      final nationalNumber = _nationalNumber.toString();
      _nationalNumber
        ..clear()
        ..write(extractedNationalPrefix)
        ..write(nationalNumber);

      // Remove the previously extracted NDD from prefixBeforeNationalNumber. We
      // cannot simply set
      // it to an empty string because people sometimes incorrectly enter the national prefix
      // after the
      // country code, e.g. +44 (0)20-1234-5678.
      final int indexOfPreviousNdd = _prefixBeforeNationalNumber
          .toString()
          .lastIndexOf(extractedNationalPrefix);

      _prefixBeforeNationalNumber
        ..clear()
        ..write(_prefixBeforeNationalNumber
            .toString()
            .substring(0, indexOfPreviousNdd));
    }

    return extractedNationalPrefix != _removeNationalPrefixFromNationalNumber();
  }

  /// Returns the national prefix extracted, or an empty string if it is not
  /// present.
  String _removeNationalPrefixFromNationalNumber() {
    final String nationalNumber = _nationalNumber.toString();

    int startOfNationalNumber = 0;

    if (_isNanpaNumberWithNationalPrefix()) {
      startOfNationalNumber = 1;

      _prefixBeforeNationalNumber
        ..write('1')
        ..write(_separatorBeforeNationalNumber);

      _isCompleteNumber = true;
    } else if (_currentMetadata.hasNationalPrefixForParsing()) {
      final RegExp nationalPrefixForParsing =
          RegExp('^(?:${_currentMetadata.nationalPrefixForParsing})');
      final RegExpMatch? m =
          nationalPrefixForParsing.firstMatch(_nationalNumber.toString());

      // Since some national prefix patterns are entirely optional, check that a
      // national prefix could actually be extracted.
      if (m != null && m.end > 0) {
        // When the national prefix is detected, we use international formatting
        // rules instead of national ones, because national formatting rules could
        // contain local formatting rules for numbers entered without area code.
        _isCompleteNumber = true;
        startOfNationalNumber = m.end;
        _prefixBeforeNationalNumber
            .write(nationalNumber.substring(0, startOfNationalNumber));
      }
    }

    _nationalNumber
      ..clear()
      ..write(nationalNumber.substring(startOfNationalNumber));

    return nationalNumber.substring(0, startOfNationalNumber);
  }

  String _inputDigitHelper(String nextChar) {
    // Note that formattingTemplate is not guaranteed to have a value, it could be
    // empty, e.g.
    // when the next digit is entered after extracting an IDD or NDD.
    final RegExpMatch? digitMatcher =
        _digitPattern.firstMatch(_formattingTemplate.toString());

    if (digitMatcher != null) {
      final String tempTemplate = _phoneUtil.replaceFirstAndFormat(
        _formattingTemplate.toString(),
        _digitPattern,
        nextChar,
      );

      _formattingTemplate
        ..clear()
        ..write(tempTemplate);

      _lastMatchPosition = digitMatcher.start;
      return _formattingTemplate
          .toString()
          .substring(0, _lastMatchPosition + 1);
    } else {
      if (_possibleFormats.length == 1) {
        // More digits are entered than we could handle,
        // and there are no other valid patterns to try.
        _ableToFormat = false;
      } // else, we just reset the formatting pattern.
      _currentFormattingPattern = '';
      return _accruedInput.toString();
    }
  }

  /// returns true if the current country is a NANPA country and the
  /// national number begins with the national prefix.
  bool _isNanpaNumberWithNationalPrefix() {
    // For NANPA numbers beginning with 1[2-9], treat the 1 as the national
    // prefix. The reason is that national significant numbers in NANPA always
    // start with [2-9] after the national prefix. Numbers beginning with 1[01]
    // can only be short/emergency numbers, which don't need the national prefix.

    return (_currentMetadata.countryCode == 1) &&
        (_nationalNumber.toString()[0] == '1') &&
        (_nationalNumber.toString()[1] != '0') &&
        (_nationalNumber.toString()[1] != '1');
  }

  @visibleForTesting
  String get extractedNationalPrefix {
    return _extractedNationalPrefix;
  }

  /// Returns the current position in the partially formatted phone number of the
  /// character which was previously passed in as the parameter of
  /// [inputDigitAndRememberPosition].
  int getRememberedPosition() {
    if (!_ableToFormat) {
      return _originalPosition;
    }

    int accruedInputIndex = 0;
    int currentOutputIndex = 0;

    while (accruedInputIndex < _positionToRemember &&
        currentOutputIndex < _currentOutput.length) {
      if (_accruedInputWithoutFormatting.toString()[accruedInputIndex] ==
          _currentOutput[currentOutputIndex]) {
        accruedInputIndex++;
      }
      currentOutputIndex++;
    }
    return currentOutputIndex;
  }
}
