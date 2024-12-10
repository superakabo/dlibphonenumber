// Based on the original JavaScript code: .../phonenumbers/PhoneNumberUtil.js
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

import 'package:fixnum/fixnum.dart';
import 'package:meta/meta.dart';
import 'package:protobuf/protobuf.dart';

import 'as_you_type_formatter.dart';
import 'enums/error_type.dart';
import 'enums/leniency.dart';
import 'enums/match_type.dart';
import 'enums/phone_number_format.dart';
import 'enums/phone_number_type.dart';
import 'enums/validation_result.dart';
import 'exceptions/illegal_argument_exception.dart';
import 'exceptions/number_parse_exception.dart';
import 'generated/classes/phone_metadata/phonemetadata.pb.dart';
import 'generated/classes/phone_number/phonenumber.pb.dart';
import 'generated/metadata/phone_number_alt_formats_metadata_map.dart';
import 'generated/metadata/phone_number_metadata_map.dart';
import 'metadata_map_loader.dart';
import 'phone_number_match.dart';
import 'phone_number_matcher.dart';

///
/// Utility for international phone numbers.
/// Functionality includes formatting, parsing and validation.
/// (based on the java implementation).
///
/// NOTE: A lot of methods in this class require Region Code strings. These must
/// be provided using CLDR two-letter region-code format. These should be in
/// upper-case. The list of the codes can be found here:
/// http://www.unicode.org/cldr/charts/30/supplemental/territory_information.html
///
class PhoneNumberUtil {
  static PhoneNumberUtil get instance => _instance;
  static final PhoneNumberUtil _instance =
      PhoneNumberUtil(const PhoneNumberMetadataMap());

  @internal
  PhoneNumberUtil(this._metadataMapLoader);

  /// Gets an [AsYouTypeFormatter] for the specific region.
  ///
  /// [regionCode] the region where the phone number is being entered
  /// returns an [AsYouTypeFormatter] object, which can be used
  /// to format phone numbers in the specific region "as you type"
  AsYouTypeFormatter getAsYouTypeFormatter(String regionCode) {
    return AsYouTypeFormatter(regionCode, this);
  }

  final MetadataMapLoader _metadataMapLoader;

  final Map<String, PhoneMetadata> regionToMetadataMap = {};

  static const int _nanpaCountryCode = 1;

  /// The minimum length of the national significant number.
  static const int _minLengthForNsn = 2;

  /// The maximum length of the country calling code.
  static const int maxLengthCountryCode = 3;

  /// The ITU says the maximum length should be 15,
  /// but we have found longer numbers in Germany.
  static const int maxLengthForNsn = 17;

  /// We don't allow input strings for parsing to be longer than 250 chars.
  /// This prevents malicious input from consuming CPU.
  static const int _maxInputStringLength = 250;

  /// Region-code for the unknown region.
  static const String _unknownRegion = 'ZZ';

  /// Map of country calling codes that use a mobile token before the area code.
  /// One example of when this is relevant is when determining the length of the
  /// national destination code, which should be the length of the area code plus
  /// the length of the mobile token.
  static const Map<int, String> _mobileTokenMappings = {54: '9'};

  /// Set of country calling codes that have geographically assigned mobile
  /// numbers. This may not be complete; we add calling codes case by case, as we
  /// find geographical mobile numbers or hear from user reports.
  static const List<int> _geoMobileCountries = [
    52, // Mexico
    54, // Argentina
    55, // Brazil
    62, // Indonesia: some prefixes only (fixed CMDA wireless)
  ];

  /// The PLUS_SIGN signifies the international prefix.
  static const String plusSign = '+';

  static const String _starSign = '*';

  /// The RFC 3966 format for extensions.
  static const String _rfc3966ExtnPrefix = ';ext=';

  static const String _rfc3966Prefix = 'tel:';

  static const String _rfc3966PhoneContext = ';phone-context=';

  static const String _rfc3966IsdnSubaddress = ';isub=';

  /// A map that contains characters that are essential when dialling. That means
  /// any of the characters in this map must not be removed from a number when
  /// dialling, otherwise the call will not reach the intended destination.
  static const Map<String, String> _diallableCharMappings = {
    '0': '0',
    '1': '1',
    '2': '2',
    '3': '3',
    '4': '4',
    '5': '5',
    '6': '6',
    '7': '7',
    '8': '8',
    '9': '9',
    '+': plusSign,
    '*': _starSign,
    '#': '#'
  };

  /// For performance reasons, amalgamate both into one map.
  static const Map<String, String> _allNormalizationMappings = {
    '0': '0',
    '1': '1',
    '2': '2',
    '3': '3',
    '4': '4',
    '5': '5',
    '6': '6',
    '7': '7',
    '8': '8',
    '9': '9',
    '\uFF10': '0', // Fullwidth digit 0
    '\uFF11': '1', // Fullwidth digit 1
    '\uFF12': '2', // Fullwidth digit 2
    '\uFF13': '3', // Fullwidth digit 3
    '\uFF14': '4', // Fullwidth digit 4
    '\uFF15': '5', // Fullwidth digit 5
    '\uFF16': '6', // Fullwidth digit 6
    '\uFF17': '7', // Fullwidth digit 7
    '\uFF18': '8', // Fullwidth digit 8
    '\uFF19': '9', // Fullwidth digit 9
    '\u0660': '0', // Arabic-indic digit 0
    '\u0661': '1', // Arabic-indic digit 1
    '\u0662': '2', // Arabic-indic digit 2
    '\u0663': '3', // Arabic-indic digit 3
    '\u0664': '4', // Arabic-indic digit 4
    '\u0665': '5', // Arabic-indic digit 5
    '\u0666': '6', // Arabic-indic digit 6
    '\u0667': '7', // Arabic-indic digit 7
    '\u0668': '8', // Arabic-indic digit 8
    '\u0669': '9', // Arabic-indic digit 9
    '\u06F0': '0', // Eastern-Arabic digit 0
    '\u06F1': '1', // Eastern-Arabic digit 1
    '\u06F2': '2', // Eastern-Arabic digit 2
    '\u06F3': '3', // Eastern-Arabic digit 3
    '\u06F4': '4', // Eastern-Arabic digit 4
    '\u06F5': '5', // Eastern-Arabic digit 5
    '\u06F6': '6', // Eastern-Arabic digit 6
    '\u06F7': '7', // Eastern-Arabic digit 7
    '\u06F8': '8', // Eastern-Arabic digit 8
    '\u06F9': '9', // Eastern-Arabic digit 9
    'A': '2',
    'B': '2',
    'C': '2',
    'D': '3',
    'E': '3',
    'F': '3',
    'G': '4',
    'H': '4',
    'I': '4',
    'J': '5',
    'K': '5',
    'L': '5',
    'M': '6',
    'N': '6',
    'O': '6',
    'P': '7',
    'Q': '7',
    'R': '7',
    'S': '7',
    'T': '8',
    'U': '8',
    'V': '8',
    'W': '9',
    'X': '9',
    'Y': '9',
    'Z': '9'
  };

  /// Separate map of all symbols that we wish to retain when formatting alpha
  /// numbers. This includes digits, ASCII letters and number grouping symbols such
  /// as '-' and ' '.
  static const Map<String, String> _allPlusNumberGroupingSymbols = {
    '0': '0',
    '1': '1',
    '2': '2',
    '3': '3',
    '4': '4',
    '5': '5',
    '6': '6',
    '7': '7',
    '8': '8',
    '9': '9',
    'A': 'A',
    'B': 'B',
    'C': 'C',
    'D': 'D',
    'E': 'E',
    'F': 'F',
    'G': 'G',
    'H': 'H',
    'I': 'I',
    'J': 'J',
    'K': 'K',
    'L': 'L',
    'M': 'M',
    'N': 'N',
    'O': 'O',
    'P': 'P',
    'Q': 'Q',
    'R': 'R',
    'S': 'S',
    'T': 'T',
    'U': 'U',
    'V': 'V',
    'W': 'W',
    'X': 'X',
    'Y': 'Y',
    'Z': 'Z',
    'a': 'A',
    'b': 'B',
    'c': 'C',
    'd': 'D',
    'e': 'E',
    'f': 'F',
    'g': 'G',
    'h': 'H',
    'i': 'I',
    'j': 'J',
    'k': 'K',
    'l': 'L',
    'm': 'M',
    'n': 'N',
    'o': 'O',
    'p': 'P',
    'q': 'Q',
    'r': 'R',
    's': 'S',
    't': 'T',
    'u': 'U',
    'v': 'V',
    'w': 'W',
    'x': 'X',
    'y': 'Y',
    'z': 'Z',
    '-': '-',
    '\uFF0D': '-',
    '\u2010': '-',
    '\u2011': '-',
    '\u2012': '-',
    '\u2013': '-',
    '\u2014': '-',
    '\u2015': '-',
    '\u2212': '-',
    '/': '/',
    '\uFF0F': '/',
    ' ': ' ',
    '\u3000': ' ',
    '\u2060': ' ',
    '.': '.',
    '\uFF0E': '.'
  };

  /// Pattern that makes it easy to distinguish whether a region has a single
  /// international dialing prefix or not. If a region has a single international
  /// prefix (e.g. 011 in USA), it will be represented as a string that contains
  /// a sequence of ASCII digits, and possibly a tilde, which signals waiting for
  /// the tone. If there are multiple available international prefixes in a
  /// region, they will be represented as a regex string that always contains one
  /// or more characters that are not ASCII digits or a tilde.
  static const String _singleInternationalPrefix =
      '[\\d]+(?:[~\u2053\u223C\uFF5E][\\d]+)?';

  /// Regular expression of acceptable punctuation found in phone numbers, used to
  /// find numbers in text and to decide what is a viable phone number. This
  /// excludes diallable characters.
  /// This consists of dash characters, white space characters, full stops,
  /// slashes, square brackets, parentheses and tildes. It also includes the letter
  /// 'x' as that is found as a placeholder for carrier information in some phone
  /// numbers. Full-width variants are also present.
  static const String validPunctuation =
      '-x\u2010-\u2015\u2212\u30FC\uFF0D-\uFF0F '
      '\u00A0\u00AD\u200B\u2060\u3000()\uFF08\uFF09\uFF3B\uFF3D.\\[\\]/~\u2053\u223C\uFF5E';

  /// Digits accepted in phone numbers (ascii, fullwidth, arabic-indic, mongolian, and eastern arabic digits).
  static const String _validDigits =
      '0-9\uFF10-\uFF19\u0660-\u0669\u06F0-\u06F9\u1810-\u1819\u1040-\u1049';

  /// We accept alpha characters in phone numbers, ASCII only, upper and lower case.
  static const String _validAlpha = 'A-Za-z';

  static const String plusChars = '+\uFF0B';

  static final RegExp plusCharsPattern = RegExp('[$plusChars]+');

  static final RegExp _leadingPlusCharsPattern = RegExp('^[$plusChars]+');

  static const String _separatorPattern = '[$validPunctuation]+';

  static final RegExp capturingDigitPattern = RegExp('([$_validDigits])');

  ///  Regular expression of acceptable characters that may start a phone number for
  /// the purposes of parsing. This allows us to strip away meaningless prefixes to
  /// phone numbers that may be mistakenly given to us. This consists of digits,
  /// the plus symbol and arabic-indic digits. This does not contain alpha
  /// characters, although they may be used later in the number. It also does not
  /// include other punctuation, as this will be stripped later during parsing and
  /// is of no information value when parsing a number.
  static final RegExp _validStartCharPattern =
      RegExp('[$plusChars$_validDigits]');

  /// Regular expression of characters typically used to start a second phone
  /// number for the purposes of parsing. This allows us to strip off parts of the
  /// number that are actually the start of another number, such as for:
  /// (530) 583-6985 x302/x2303 -> the second extension here makes this actually
  /// two phone numbers, (530) 583-6985 x302 and (530) 583-6985 x2303. We remove
  /// the second extension so that the first number is parsed correctly.
  static final RegExp secondNumberStartPattern = RegExp(r'[\\/] *x');

  /// Regular expression of trailing characters that we want to remove. We remove
  /// all characters that are not alpha or numerical characters. The hash character
  /// is retained here, as it may signify the previous block was an extension.
  static final RegExp unwantedEndCharPattern = RegExp(
    '[^$_validDigits$_validAlpha#]+\$',
    unicode: true,
    caseSensitive: false,
  );

  /// We use this pattern to check if the phone number has at least three letters
  /// in it - if so, then we treat it as a number where some phone-number digits
  /// are represented by letters.
  static final RegExp _validAlphaPhonePattern = RegExp('(?:.*?[A-Za-z]){3}.*');

  /// Regular expression of viable phone numbers. This is location independent.
  /// Checks we have at least three leading digits, and only valid punctuation,
  /// alpha characters and digits in the phone number. Does not include extension
  /// data. The symbol 'x' is allowed here as valid punctuation since it is often
  /// used as a placeholder for carrier codes, for example in Brazilian phone
  /// numbers. We also allow multiple '+' characters at the start.
  /// Corresponds to the following:
  /// [digits]{minLengthNsn}|
  /// plus_sign*
  /// (([punctuation]|[star])*[digits]){3,}([punctuation]|[star]|[digits]|[alpha])*
  ///
  /// The first reg-ex is to allow short numbers (two digits long) to be parsed if
  /// they are entered as '15' etc, but only if there is no punctuation in them.
  /// The second expression restricts the number of digits to three or more, but
  /// then allows them to be in international form, and to have alpha-characters
  /// and punctuation. We split up the two reg-exes here and combine them when
  /// creating the reg-ex VALID_PHONE_NUMBER_PATTERN_ itself so we can prefix it
  /// with ^ and append $ to each branch.
  ///
  /// Note [validPunctuation] starts with a -, so must be the first in the range.
  static const String _minLengthPhoneNumberPattern =
      '[$_validDigits]{$_minLengthForNsn}';

  /// See [_minLengthPhoneNumberPattern] for a full description of this reg-exp.
  static const String _validPhoneNumber = '[$plusChars]'
      '*(?:[$validPunctuation$_starSign]'
      '*[$_validDigits]){3,}'
      '[$validPunctuation$_starSign'
      '$_validAlpha$_validDigits]*';

  /// Default extension prefix to use when formatting. This will be put in front of
  /// any extension component of the number, after the main national number is
  /// formatted. For example, if you wish the default extension formatting to be
  /// ' extn: 3456', then you should specify ' extn: ' here as the default
  /// extension prefix. This can be overridden by region-specific preferences.
  static const String _defaultExtnPrefix = ' ext. ';

  static final String _extnPatternsForParsing = _createExtnPattern(true);
  static final String extnPatternsForMatching = _createExtnPattern(false);

  static const String _rfc3966VisualSeparator = '[\\-\\.\\(\\)]?';

  static const String _rfc3966PhoneDigit =
      '([$_validDigits]|$_rfc3966VisualSeparator)';

  static const String _rfc3966GlobalNumberDigits =
      '^\\$plusSign$_rfc3966PhoneDigit*[$_validDigits]$_rfc3966PhoneDigit*\$';

  /// Regular expression of valid global-number-digits for the phone-context
  /// parameter, following the syntax defined in RFC3966.
  static final RegExp _rfc3966GlobalNumberDigitsPattern =
      RegExp(_rfc3966GlobalNumberDigits);

  static const String _alphanum = '$_validAlpha$_validDigits';

  static const String _rfc3966Domainlabel =
      '[$_alphanum]+((\\-)*[$_alphanum])*';

  static const String _rfc3966Toplabel = '[$_validAlpha]+((\\-)*[$_alphanum])*';

  static const String _rfc3966DomainName =
      '^($_rfc3966Domainlabel\\.)*$_rfc3966Toplabel\\.?\$';

  /// Regular expression of valid domainname for the phone-context parameter,
  /// following the syntax defined in RFC3966.
  static final RegExp _rfc3966DomainnamePattern = RegExp(_rfc3966DomainName);

  /// Helper method for constructing regular expressions for parsing. Creates
  /// an expression that captures up to max_length digits.
  static String _extnDigits(int maxLength) {
    return ('([$_validDigits]{1,$maxLength})');
  }

  /// Helper initialiser method to create the regular-expression pattern to match
  /// extensions.
  /// Note that there are currently six capturing groups for the extension itself.
  /// If this number is
  /// changed, MaybeStripExtension needs to be updated.
  static String _createExtnPattern(bool forParsing) {
    // We cap the maximum length of an extension based on the ambiguity of the way
    // the extension is
    // prefixed. As per ITU, the officially allowed length for extensions is
    // actually 40, but we
    // don't support this since we haven't seen real examples and this introduces
    // many false
    // interpretations as the extension labels are not standardized.
    int extLimitAfterExplicitLabel = 20;
    int extLimitAfterLikelyLabel = 15;
    int extLimitAfterAmbiguousChar = 9;
    int extLimitWhenNotSure = 6;

    String possibleSeparatorsBetweenNumberAndExtLabel = '[ \\u00A0\\t,]*';

    // Optional full stop (.) or colon, followed by zero or more spaces/tabs/commas.
    String possibleCharsAfterExtLabel = '[:\\.\\uFF0E]?[ \\u00A0\\t,-]*';
    String optionalExtnSuffix = "#?";

    // Here the extension is called out in more explicit way, i.e mentioning it
    // obvious patterns
    // like "ext.". Canonical-equivalence doesn't seem to be an option with Android
    // java, so we
    // allow two options for representing the accented o - the character itself, and
    // one in the
    // unicode decomposed form with the combining acute accent.
    String explicitExtLabels =
        '(?:e?xt(?:ensi(?:o\u0301?|\\u00F3))?n?|\\uFF45?\\uFF58\\uFF54\\uFF4E?|\\u0434\\u043E\\u0431|anexo)';

    // One-character symbols that can be used to indicate an extension, and less
    // commonly used
    // or more ambiguous extension labels.
    String ambiguousExtLabels =
        '(?:[x\\uFF58#\\uFF03~\\uFF5E]|int|\\uFF49\\uFF4E\\uFF54)';

    // When extension is not separated clearly.
    String ambiguousSeparator = '[- ]+';

    String rfcExtn =
        _rfc3966ExtnPrefix + _extnDigits(extLimitAfterExplicitLabel);

    String explicitExtn = possibleSeparatorsBetweenNumberAndExtLabel +
        explicitExtLabels +
        possibleCharsAfterExtLabel +
        _extnDigits(extLimitAfterExplicitLabel) +
        optionalExtnSuffix;

    String ambiguousExtn = possibleSeparatorsBetweenNumberAndExtLabel +
        ambiguousExtLabels +
        possibleCharsAfterExtLabel +
        _extnDigits(extLimitAfterAmbiguousChar) +
        optionalExtnSuffix;

    String americanStyleExtnWithSuffix =
        "$ambiguousSeparator${_extnDigits(extLimitWhenNotSure)}#";

    // The first regular expression covers RFC 3966 format, where the extension is
    // added using
    // ";ext=". The second more generic where extension is mentioned with explicit
    // labels like
    // "ext:". In both the above cases we allow more numbers in extension than any
    // other extension
    // labels. The third one captures when single character extension labels or less
    // commonly used
    // labels are used. In such cases we capture fewer extension digits in order to
    // reduce the
    // chance of falsely interpreting two numbers beside each other as a number +
    // extension. The
    // fourth one covers the special case of American numbers where the extension is
    // written with a
    // hash at the end, such as "- 503#".
    String extensionPattern =
        "$rfcExtn|$explicitExtn|$ambiguousExtn|$americanStyleExtnWithSuffix";
    // Additional pattern that is supported when parsing extensions, not when
    // matching.
    if (forParsing) {
      // This is same as possibleSeparatorsBetweenNumberAndExtLabel, but not matching
      // comma as
      // extension label may have it.
      String possibleSeparatorsNumberExtLabelNoComma = '[ \\u00A0\\t]*';
      // ",," is commonly used for auto dialling the extension when connected. First
      // comma is matched
      // through possibleSeparatorsBetweenNumberAndExtLabel, so we do not repeat it
      // here. Semi-colon
      // works in Iphone and Android also to pop up a button with the extension number
      // following.
      String autoDialingAndExtLabelsFound = '(?:,{2}|;)';

      String autoDialingExtn = possibleSeparatorsNumberExtLabelNoComma +
          autoDialingAndExtLabelsFound +
          possibleCharsAfterExtLabel +
          _extnDigits(extLimitAfterLikelyLabel) +
          optionalExtnSuffix;

      String onlyCommasExtn =
          "$possibleSeparatorsNumberExtLabelNoComma(?:,)+$possibleCharsAfterExtLabel${_extnDigits(extLimitAfterAmbiguousChar)}$optionalExtnSuffix";
      // Here the first pattern is exclusively for extension autodialling formats
      // which are used
      // when dialling and in this case we accept longer extensions. However, the
      // second pattern
      // is more liberal on the number of commas that acts as extension labels, so we
      // have a strict
      // cap on the number of digits in such extensions.
      return "$extensionPattern|$autoDialingExtn|$onlyCommasExtn";
    }
    return extensionPattern;
  }
//////////*****/////////////

  /// Regexp of all known extension prefixes used by different
  /// regions followed by 1 or more valid digits, for use when parsing.
  static final RegExp _extnPattern = RegExp(
    '(?:$_extnPatternsForParsing)\$',
    caseSensitive: false,
    unicode: true,
  );

  /// We append optionally the extension pattern to the end here, as a valid phone
  /// number may have an extension prefix appended, followed by 1 or more digits.
  static final RegExp _validPhoneNumberPattern = RegExp(
    '^$_minLengthPhoneNumberPattern\$|^$_validPhoneNumber(?:$_extnPatternsForParsing)?\$',
    caseSensitive: false,
    unicode: true,
  );

  static final RegExp nonDigitsPattern = RegExp('\\D+');

  /// This was originally set to $1 but there are some countries for which the
  /// first group is not used in the national pattern (e.g. Argentina) so the $1
  /// group does not match correctly.  Therefore, we use \d, so that the first
  /// group actually used in the pattern will be matched.
  static final RegExp firstGroupPattern = RegExp(r'\$(\d)');

  static final String _npString = '\$NP';

  static final String _fgString = '\$FG';

  static final String _ccString = '\$CC';

  /// A pattern that is used to determine if the national prefix formatting rule
  /// has the first group only, i.e., does not start with the national prefix.
  /// Note that the pattern explicitly allows for unbalanced parentheses.
  static final RegExp _firstGroupOnlyPrefixPattern = RegExp(r'^\(?\$1\)?$');

  static const String regionCodeForNonGeoEntity = '001';

  /// Attempts to extract a possible number from the string passed in. This
  /// currently strips all leading characters that cannot be used to start a phone
  /// number. Characters that can be used to start a phone number are defined in
  /// the [_validStartCharPattern]. If none of these characters are found in the
  /// number passed in, an empty string is returned. This function also attempts to
  /// strip off any alternative extensions or endings if two or more are present,
  /// such as in the case of: (530) 583-6985 x302/x2303. The second extension here
  /// makes this actually two phone numbers, (530) 583-6985 x302 and (530) 583-6985
  /// x2303. We remove the second extension so that the first number is parsed
  /// correctly.
  /// [number] is the string that might contain a phone number.
  /// [extractPossibleNumber] returns the number, stripped of any non-phone-number prefix
  /// (such as 'Tel:') or an empty string if no character used to start phone numbers
  /// (such as + or any digit) is found in the number.
  static String extractPossibleNumber(String number) {
    RegExpMatch? m = _validStartCharPattern.firstMatch(number);
    if (m != null) {
      number = number.substring(m.start, number.length);
      // Remove trailing non-alpha non-numerical characters.
      RegExpMatch? trailingCharsMatcher =
          unwantedEndCharPattern.firstMatch(number);
      if (trailingCharsMatcher != null) {
        number = number.substring(0, trailingCharsMatcher.start);
      }
      // Check for extra numbers at the end.
      RegExpMatch? secondNumber = secondNumberStartPattern.firstMatch(number);
      if (secondNumber != null) {
        number = number.substring(0, secondNumber.start);
      }
      return number;
    } else {
      return '';
    }
  }

  /// Checks to see if the string of characters could possibly be a phone number at
  /// all. At the moment, checks to see that the string begins with at least 2
  /// digits, ignoring any punctuation commonly found in phone numbers. This method
  /// does not require the number to be normalized in advance - but does assume
  /// that leading non-number symbols have been removed, such as by the method
  /// extractPossibleNumber.
  /// [number] is the string to be checked for viability as a phone number.
  /// [isViablePhoneNumber] returns true if the number could be a
  /// phone number of some sort, otherwise false.
  bool isViablePhoneNumber(String number) {
    if (number.length < _minLengthForNsn) {
      return false;
    }
    return matchesEntirely(_validPhoneNumberPattern, number);
  }

  /// Normalizes a string of characters representing a phone number. This performs
  /// the following conversions:
  ///   Punctuation is stripped.
  ///   For ALPHA/VANITY numbers:
  ///   Letters are converted to their numeric representation on a telephone
  ///       keypad. The keypad used here is the one defined in ITU Recommendation
  ///       E.161. This is only done if there are 3 or more letters in the number,
  ///       to lessen the risk that such letters are typos.
  ///   For other numbers:
  ///   Wide-ascii digits are converted to normal ASCII (European) digits.
  ///   Arabic-Indic numerals are converted to European numerals.
  ///   Spurious alpha characters are stripped.
  ///
  /// [number] a string of characters representing a phone number.
  /// returns the normalized string version of the phone number.
  String normalize(StringBuffer number) {
    RegExpMatch? m = _validAlphaPhonePattern.firstMatch(number.toString());
    if (m != null && m.group(0) == number.toString()) {
      String normalized =
          _normalizeHelper(number.toString(), _allNormalizationMappings, true);
      number
        ..clear()
        ..write(normalized);
    } else {
      String normalized = normalizeDigitsOnly(number.toString());
      number
        ..clear()
        ..write(normalized);
    }
    return number.toString();
  }

  /// Normalizes a string of characters representing a phone number. This converts
  /// wide-ascii and arabic-indic numerals to European numerals, and strips
  /// punctuation and alpha characters.
  ///
  /// [number] a string of characters representing a phone number.
  /// [normalizeDigitsOnly] returns the normalized string version of the phone number.
  static String normalizeDigitsOnly(String number) {
    return normalizeDigits(number, false).toString();
  }

  /// normalizes a string of characters representing a phone number. this strips
  /// all characters which are not diallable on a mobile phone keypad (including
  /// all non-ascii digits).
  ///
  /// [number] is a string of characters representing a phone number.
  /// [normalizeDiallableCharsOnly] returns the normalized string version of the phone number.
  String normalizeDiallableCharsOnly(String number) {
    return _normalizeHelper(number, _diallableCharMappings, true);
  }

  /// Converts all alpha characters in a number to their respective digits on a
  /// keypad, but retains existing formatting. Also converts wide-ascii digits to
  /// normal ascii digits, and converts Arabic-Indic numerals to European numerals.
  ///
  /// [number] a string of characters representing a phone number.
  /// [convertAlphaCharactersInNumber] returns the normalized string version of the phone number.
  String convertAlphaCharactersInNumber(String number) {
    return _normalizeHelper(number, _allNormalizationMappings, false);
  }

  /// Gets the length of the geographical area code from the
  ///  [nationalNumber] field of the PhoneNumber object passed in, so that
  /// clients could use it to split a national significant number into geographical
  /// area code and subscriber number. It works in such a way that the resultant
  /// subscriber number should be diallable, at least on some devices. An example
  /// of how this could be used:
  ///
  /// <pre>
  /// var phoneUtil = PhoneNumberUtil.instance;
  /// var number = phoneUtil.parse('16502530000', 'US');
  /// var nationalSignificantNumber =
  ///     phoneUtil.getNationalSignificantNumber(number);
  /// var areaCode;
  /// var subscriberNumber;
  ///
  /// var areaCodeLength = phoneUtil.getLengthOfGeographicalAreaCode(number);
  /// if (areaCodeLength > 0) {
  ///   areaCode = nationalSignificantNumber.substring(0, areaCodeLength);
  ///   subscriberNumber = nationalSignificantNumber.substring(areaCodeLength);
  /// } else {
  ///   areaCode = '';
  ///   subscriberNumber = nationalSignificantNumber;
  /// }
  /// </pre>
  ///
  /// N.B.: area code is a very ambiguous concept, so the I18N team generally
  /// recommends against using it for most purposes, but recommends using the more
  /// general [nationalNumber] instead. Read the following carefully before
  /// deciding to use this method:
  /// <ul>
  ///  <li> geographical area codes change over time, and this method honors those
  ///    changes; therefore, it doesn't guarantee the stability of the result it
  ///    produces.
  ///  <li> subscriber numbers may not be diallable from all devices (notably
  ///    mobile devices, which typically requires the full national_number to be
  ///    dialled in most regions).
  ///  <li> most non-geographical numbers have no area codes, including numbers
  ///    from non-geographical entities.
  ///  <li> some geographical numbers have no area codes.
  /// </ul>
  ///
  /// [PhoneNumber] number the PhoneNumber object for
  /// which clients want to know the length of the area code.
  /// @return {number} the length of area code of the PhoneNumber object passed in.
  int getLengthOfGeographicalAreaCode(PhoneNumber number) {
    String? regionCode = getRegionCodeForNumber(number);
    PhoneMetadata? metadata = getMetadataForRegion(regionCode: regionCode);
    if (metadata == null) return 0;

    // If a country doesn't use a national prefix, and this number doesn't have
    // an Italian leading zero, we assume it is a closed dialling plan with no
    // area codes.
    if (!metadata.hasNationalPrefix() && !number.italianLeadingZero) return 0;
    if (!isNumberGeographical(phoneNumber: number)) return 0;
    return getLengthOfNationalDestinationCode(number);
  }

  /// Gets the length of the national destination code (NDC) from the PhoneNumber
  /// object passed in, so that clients could use it to split a national
  /// significant number into NDC and subscriber number. The NDC of a phone number
  /// is normally the first group of digit(s) right after the country calling code
  /// when the number is formatted in the international format, if there is a
  /// subscriber number part that follows.
  ///
  /// N.B.: similar to an area code, not all numbers have an NDC!
  ///
  /// An example of how this could be used:
  ///
  /// <pre>
  /// var phoneUtil = PhoneNumberUtil.instance;
  /// var number = phoneUtil.parse('18002530000', 'US');
  /// var nationalSignificantNumber =
  ///     phoneUtil.getNationalSignificantNumber(number);
  /// var nationalDestinationCode;
  /// var subscriberNumber;
  ///
  /// var nationalDestinationCodeLength =
  ///     phoneUtil.getLengthOfNationalDestinationCode(number);
  /// if (nationalDestinationCodeLength > 0) {
  ///   nationalDestinationCode =
  ///       nationalSignificantNumber.substring(0, nationalDestinationCodeLength);
  ///   subscriberNumber =
  ///       nationalSignificantNumber.substring(nationalDestinationCodeLength);
  /// } else {
  ///   nationalDestinationCode = '';
  ///   subscriberNumber = nationalSignificantNumber;
  /// }
  /// </pre>
  ///
  /// Refer to the unittests to see the difference between this function and
  /// [getLengthOfGeographicalAreaCode].
  ///
  /// PhoneNumber [number] is the PhoneNumber object for which clients want to know the length of the NDC.
  /// [getLengthOfNationalDestinationCode] returns the length of NDC of the PhoneNumber object passed in,
  /// which could be zero.
  int getLengthOfNationalDestinationCode(PhoneNumber number) {
    PhoneNumber copiedProto;
    if (number.hasExtension_3()) {
      // We don't want to alter the proto given to us, but we don't want to
      // include the extension when we format it, so we copy it and clear the
      // extension here.
      copiedProto = number.deepCopy();
      copiedProto.clearExtension_3();
    } else {
      copiedProto = number;
    }

    String nationalSignificantNumber =
        format(copiedProto, PhoneNumberFormat.international);

    List<String> numberGroups =
        nationalSignificantNumber.split(nonDigitsPattern);
    // The pattern will start with '+COUNTRY_CODE ' so the first group will always
    // be the empty string (before the + symbol) and the second group will be the
    // country calling code. The third group will be area code if it is not the
    // last group.
    // NOTE: On IE the first group that is supposed to be the empty string does
    // not appear in the array of number groups... so make the result on non-IE
    // browsers to be that of IE.
    if (numberGroups.first.isEmpty) numberGroups.removeAt(0);
    if (numberGroups.length <= 2) return 0;

    if (getNumberType(number) == PhoneNumberType.mobile) {
      // For example Argentinian mobile numbers, when formatted in the
      // international format, are in the form of +54 9 NDC XXXX.... As a result,
      // we take the length of the third group (NDC) and add the length of the
      // mobile token, which also forms part of the national significant number.
      // This assumes that the mobile token is always formatted separately from
      // the rest of the phone number.
      String mobileToken = getCountryMobileToken(number.countryCode);
      if (mobileToken != '') {
        return numberGroups[2].length + mobileToken.length;
      }
    }
    return numberGroups[1].length;
  }

  /// Returns the mobile token for the provided country calling code if it has
  /// one, otherwise returns an empty string. A mobile token is a number inserted
  /// before the area code when dialing a mobile number from that country from
  /// abroad.
  ///
  /// [number] countryCallingCode the country calling code for which we want the mobile token.
  /// [getCountryMobileToken] returns the mobile token for the given country calling code.
  static String getCountryMobileToken(int countryCallingCode) {
    return _mobileTokenMappings[countryCallingCode] ?? '';
  }

  bool _isNonGeographicalRegionCode(List<String> regionCodes) {
    return (regionCodes.length == 1) &&
        (regionCodeForNonGeoEntity == regionCodes.first);
  }

  /// Returns all regions the library has metadata for.
  /// This returns the two-letter region codes for every geographical
  /// region the library supports.
  List<String> get supportedRegions {
    final List<List<String>> regionCodesList = _metadataMapLoader
        .countryCodeToRegionCodeMap.entries
        .where((mapEntry) => !_isNonGeographicalRegionCode(mapEntry.value))
        .map((e) => e.value)
        .toList();
    return regionCodesList.expand((e) => e).toList();
  }

  /// Returns all global network calling codes the library has metadata for.
  /// This returns the country calling codes for every
  /// non-geographical entity the library supports.
  List<int> get supportedGlobalNetworkCallingCodes {
    return _metadataMapLoader.countryCodeToRegionCodeMap.entries
        .where((mapEntry) => _isNonGeographicalRegionCode(mapEntry.value))
        .map((e) => int.parse(e.key))
        .toList();
  }

  /// Returns all country calling codes the library has metadata for, covering
  /// both non-geographical entities (global network calling codes) and those used
  /// for geographical entities. This could be used to populate a drop-down box of
  /// country calling codes for a phone-number widget, for instance.
  ///
  /// returns the country calling codes for every geographical
  /// and non-geographical entity the library supports.
  List<int> getSupportedCallingCodes() {
    return _metadataMapLoader.countryCodeToRegionCodeMap.keys
        .map((e) => int.parse(e))
        .toList();
  }

  /// Returns true if there is any possibleLength data set for a particular PhoneNumberDesc.
  bool _descHasPossibleNumberData(PhoneNumberDesc desc) {
    // If this is empty, it means numbers of this type inherit from the 'general
    // desc' -> the value '-1' means that no numbers exist for this type.
    return desc.possibleLength.length != 1 || desc.possibleLength.first != -1;
  }

  /// Returns true if there is any data set for a particular PhoneNumberDesc.
  bool _descHasData(PhoneNumberDesc desc) {
    // Checking most properties since we don't know what's present, since a
    // custom build may have stripped just one of them (e.g. liteBuild strips
    // exampleNumber). We don't bother checking the possibleLengthsLocalOnly,
    // since if this is the only thing that's present we don't really support the
    // type at all: no type-specific methods will work with only this data.
    return (desc.hasExampleNumber() ||
        _descHasPossibleNumberData(desc) ||
        desc.hasNationalNumberPattern());
  }

  /// Returns the types we have metadata for based on the PhoneMetadata object passed in.
  List<PhoneNumberType> _getSupportedTypesForMetadata(PhoneMetadata metadata) {
    List<PhoneNumberType> types = [];

    for (var type in PhoneNumberType.values) {
      // Never return `fixedLineOrMobile` (it is a convenience type, and
      // represents that a particular number type can't be determined) or
      // `unknown` (the non-type).
      if (type != PhoneNumberType.fixedLineOrMobile &&
          type != PhoneNumberType.unknown) {
        PhoneNumberDesc desc = _getNumberDescByType(metadata, type);
        if (_descHasData(desc)) types.add(type);
      }
    }
    return types;
  }

  /// Returns the types for a given region which the library has metadata for.
  /// Will not include `fixedLineOrMobile` (if numbers for this non-geographical
  /// entity could be classified as `fixedLineOrMobile`, both `fixedLine` and
  /// `mobile` would be present) and `unknown`.
  ///
  /// No types will be returned for invalid or unknown region codes.
  List<PhoneNumberType> getSupportedTypesForRegion(String? regionCode) {
    if (!_isValidRegionCode(regionCode)) return [];
    PhoneMetadata metadata = getMetadataForRegion(regionCode: regionCode)!;
    return _getSupportedTypesForMetadata((metadata));
  }

  /// Returns the types for a country-code belonging to a non-geographical entity
  /// which the library has metadata for. Will not include `fixedLineOrMobile`
  /// (instead both `fixedLine` and `fixedLineOrMobile` (if numbers for this
  /// non-geographical entity could be classified as `fixedLineOrMobile`, both
  /// `fixedLine` and `mobile` would be present) and `unknown`.
  ///
  /// No types will be returned for country calling codes that do not map to a
  /// known non-geographical entity.
  List<PhoneNumberType> getSupportedTypesForNonGeoEntity(
      int countryCallingCode) {
    PhoneMetadata? metadata =
        getMetadataForNonGeographicalRegion(countryCallingCode);
    if (metadata == null) return [];
    return _getSupportedTypesForMetadata((metadata));
  }

  /// Normalizes a string of characters representing a phone number by replacing
  /// all characters found in the accompanying map with the values therein, and
  ///  stripping all other characters if removeNonMatches is true.
  ///
  /// [number] a string of characters representing a phone number.
  /// [normalizationReplacements] a mapping of characters to what they should be
  /// replaced by in the normalized version of the phone number.
  /// [removeNonMatches] indicates whether characters that are not
  /// able to be replaced should be stripped from the number. If this is false,
  /// they will be left unchanged in the number.
  static String _normalizeHelper(String number,
      Map<String, String> normalizationReplacements, bool removeNonMatches) {
    StringBuffer normalizedNumber = StringBuffer();

    for (int i = 0; i < number.length; i++) {
      final String character = number[i];
      final String? newDigit =
          normalizationReplacements[character.toUpperCase()];
      if (newDigit != null) {
        normalizedNumber.write(newDigit);
      } else if (!removeNonMatches) {
        normalizedNumber.write(character);
      }
      // If neither of the above are true, we remove this character.
    }

    return normalizedNumber.toString();
  }

  static int? characterToDigit(String input) {
    final regex = RegExp(r'\p{N}', unicode: true);
    int position = -1;
    // Since the unicode scalar could be [0-9],
    // we count from [0-9] to determine its proximity to 9.
    for (var i = 0; i < 10; i++) {
      final codeUnit = input.codeUnitAt(0) + i;
      final character = String.fromCharCode(codeUnit);
      if (regex.hasMatch(character)) {
        position++;
      } else {
        break;
      }
    }
    // we substract from 9 to get the index of the character,
    // which corresponds to an arabic number of [0-9].
    int number = (9 - position);
    return (number > 9) ? null : number;
  }

  static StringBuffer normalizeDigits(String number, bool keepNonDigits) {
    StringBuffer normalizedDigits = StringBuffer();
    for (int i = 0; i < number.length; i++) {
      final String c = number[i];
      final int? digit = characterToDigit(c);
      if (digit != null) {
        normalizedDigits.write(digit);
      } else if (keepNonDigits) {
        normalizedDigits.write(c);
      }
    }

    return normalizedDigits;
  }

  /// Helper function to check if the national prefix formatting rule has the first
  /// group only, i.e., does not start with the national prefix.
  ///
  /// [nationalPrefixFormattingRule] The formatting rule for the national prefix.
  static bool formattingRuleHasFirstGroupOnly(
      String nationalPrefixFormattingRule) {
    return nationalPrefixFormattingRule.isEmpty ||
        _firstGroupOnlyPrefixPattern.hasMatch(nationalPrefixFormattingRule);
  }

  /// Tests whether a phone number has a geographical association. It checks if the
  /// number is associated with a certain region in the country to which it
  /// belongs. Note that this doesn't verify if the number is actually in use.
  ///
  /// [phoneNumber] The phone number to test.
  bool isNumberGeographical(
      {PhoneNumber? phoneNumber,
      PhoneNumberType? phoneNumberType,
      int? countryCallingCode}) {
    if (phoneNumber != null) {
      phoneNumberType = getNumberType(phoneNumber);
      countryCallingCode = phoneNumber.countryCode;
    }

    return phoneNumberType == PhoneNumberType.fixedLine ||
        phoneNumberType == PhoneNumberType.fixedLineOrMobile ||
        (_geoMobileCountries.contains(countryCallingCode) &&
            phoneNumberType == PhoneNumberType.mobile);
  }

  /// Helper function to check region code is not unknown or null.
  /// [regionCode] the CLDR two-letter region code.
  bool _isValidRegionCode(String? regionCode) {
    // In Java we check whether the regionCode is contained in supportedRegions
    // that is built out of all the values of countryCallingCodeToRegionCodeMap
    // (countryCodeToRegionCodeMap in Dart) minus [regionCodeForNonGeoEntity].
    // In Dart we check whether the regionCode is contained in the keys of
    // countryToMetadata but since for non-geographical country calling codes
    // (e.g. +800) we use the country calling codes instead of the region code as
    // key in the map we have to make sure regionCode is not a number to prevent
    // returning true for non-geographical country calling codes.

    if (regionCode == null) return false;
    return ((int.tryParse(regionCode) == null) &&
        supportedRegions.contains(regionCode.toUpperCase()));
  }

  /// Helper function to check the country calling code is valid.
  /// [countryCallingCode] the country calling code.
  bool _hasValidCountryCallingCode(int countryCallingCode) {
    return _metadataMapLoader.countryCodeToRegionCodeMap
        .containsKey('$countryCallingCode');
  }

  /// Formats a phone number in the specified format using default rules. Note that
  /// this does not promise to produce a phone number that the user can dial from
  /// where they are - although we do format in either 'national' or
  /// 'international' format depending on what the client asks for, we do not
  /// currently support a more abbreviated format, such as for users in the same
  /// 'area' who could potentially dial the number without area code. Note that if
  /// the phone number has a country calling code of 0 or an otherwise invalid
  /// country calling code, we cannot work out which formatting rules to apply so
  /// we return the national significant number with no formatting applied.
  ///
  /// [number] the phone number to be formatted.
  /// [numberFormat] the format the phone number should be formatted into.
  String format(PhoneNumber number, PhoneNumberFormat numberFormat) {
    if (number.nationalNumber == 0 && number.hasRawInput()) {
      // Unparseable numbers that kept their raw input just use that.
      // This is the only case where a number can be formatted as E164 without a
      // leading '+' symbol (but the original number wasn't parseable anyway).
      // TODO: Consider removing the 'if' above so that unparseable strings
      // without raw input format to the empty string instead of '+00'
      String rawInput = number.rawInput;
      if (rawInput.isNotEmpty) return rawInput;
    }

    int countryCallingCode = number.countryCode;
    String nationalSignificantNumber = getNationalSignificantNumber(number);

    if (numberFormat == PhoneNumberFormat.e164) {
      // Early exit for E164 case (even if the country calling code is invalid)
      // since no formatting of the national number needs to be applied.
      // Extensions are not formatted.
      return _prefixNumberWithCountryCallingCode(
        countryCallingCode,
        PhoneNumberFormat.e164,
        nationalSignificantNumber,
        '',
      );
    }
    if (!_hasValidCountryCallingCode(countryCallingCode)) {
      return nationalSignificantNumber;
    }
    // Note [getRegionCodeForCountryCode()] is used because formatting information
    // for regions which share a country calling code is contained by only one
    // region for performance reasons. For example, for NANPA regions it will be
    // contained in the metadata for US.
    String regionCode = getRegionCodeForCountryCode(countryCallingCode);

    // Metadata cannot be null because the country calling code is valid (which
    // means that the region code cannot be ZZ and must be one of our supported
    // region codes).
    PhoneMetadata metadata =
        _getMetadataForRegionOrCallingCode(countryCallingCode, regionCode)!;

    String formattedExtension = _maybeGetFormattedExtension(
      number,
      metadata,
      numberFormat,
    );

    String formattedNationalNumber = _formatNsn(
      nationalSignificantNumber,
      metadata,
      numberFormat,
    );

    return _prefixNumberWithCountryCallingCode(
      countryCallingCode,
      numberFormat,
      formattedNationalNumber,
      formattedExtension,
    );
  }

  /// Formats a phone number in the specified format using client-defined
  /// formatting rules. Note that if the phone number has a country calling code of
  /// zero or an otherwise invalid country calling code, we cannot work out things
  /// like whether there should be a national prefix applied, or how to format
  /// extensions, so we return the national significant number with no formatting
  /// applied.
  ///
  /// [number] the phone  number to be formatted.
  /// [numberFormat] the format the phone number should be formatted into.
  /// [userDefinedFormats] formatting rules specified by clients.
  String formatByPattern(PhoneNumber number, PhoneNumberFormat numberFormat,
      List<NumberFormat> userDefinedFormats) {
    int countryCallingCode = number.countryCode;

    String nationalSignificantNumber = getNationalSignificantNumber(number);
    if (!_hasValidCountryCallingCode(countryCallingCode)) {
      return nationalSignificantNumber;
    }
    // Note getRegionCodeForCountryCode() is used because formatting information
    // for regions which share a country calling code is contained by only one
    // region for performance reasons. For example, for NANPA regions it will be
    // contained in the metadata for US.
    String regionCode = getRegionCodeForCountryCode(countryCallingCode);

    // Metadata cannot be null because the country calling code is valid
    PhoneMetadata metadata =
        _getMetadataForRegionOrCallingCode(countryCallingCode, regionCode)!;

    String formattedNumber = '';

    NumberFormat? formattingPattern = chooseFormattingPatternForNumber(
      userDefinedFormats,
      nationalSignificantNumber,
    );

    if (formattingPattern == null) {
      // If no pattern above is matched, we format the number as a whole.
      formattedNumber = nationalSignificantNumber;
    } else {
      // Before we do a replacement of the national prefix pattern $NP with the
      // national prefix, we need to copy the rule so that subsequent replacements
      // for different numbers have the appropriate national prefix.
      NumberFormat numFormatCopy = formattingPattern.deepCopy();
      String nationalPrefixFormattingRule =
          formattingPattern.nationalPrefixFormattingRule;
      if (nationalPrefixFormattingRule.isNotEmpty) {
        String nationalPrefix = metadata.nationalPrefix;
        if (nationalPrefix.isNotEmpty) {
          // Replace $NP with national prefix and $FG with the first group ($1).
          nationalPrefixFormattingRule = nationalPrefixFormattingRule
              .replaceFirst(_npString, nationalPrefix)
              .replaceFirst(_fgString, '\$1');
          numFormatCopy.nationalPrefixFormattingRule =
              nationalPrefixFormattingRule;
        } else {
          // We don't want to have a rule for how to format the national prefix if
          // there isn't one.
          numFormatCopy.clearNationalPrefixFormattingRule();
        }
      }

      formattedNumber = formatNsnUsingPattern(
        nationalSignificantNumber,
        numFormatCopy,
        numberFormat,
      );
    }

    String formattedExtension = _maybeGetFormattedExtension(
      number,
      metadata,
      numberFormat,
    );

    return _prefixNumberWithCountryCallingCode(
      countryCallingCode,
      numberFormat,
      formattedNumber,
      formattedExtension,
    );
  }

  /// Formats a phone number in national format for dialing using the carrier as
  /// specified in the {@code carrierCode}. The {@code carrierCode} will always be
  /// used regardless of whether the phone number already has a preferred domestic
  /// carrier code stored. If {@code carrierCode} contains an empty string, returns
  /// the number in national format without any carrier code.
  ///
  /// [number] the phone number to be formatted.
  /// [carrierCode] the carrier selection code to be used.
  String formatNationalNumberWithCarrierCode(
      PhoneNumber number, String carrierCode) {
    int countryCallingCode = number.countryCode;

    String nationalSignificantNumber = getNationalSignificantNumber(number);
    if (!_hasValidCountryCallingCode(countryCallingCode)) {
      return nationalSignificantNumber;
    }

    // Note getRegionCodeForCountryCode() is used because formatting information
    // for regions which share a country calling code is contained by only one
    // region for performance reasons. For example, for NANPA regions it will be
    // contained in the metadata for US.
    String regionCode = getRegionCodeForCountryCode(countryCallingCode);

    // Metadata cannot be null because the country calling code is valid.
    PhoneMetadata metadata =
        _getMetadataForRegionOrCallingCode(countryCallingCode, regionCode)!;

    String formattedExtension = _maybeGetFormattedExtension(
      number,
      metadata,
      PhoneNumberFormat.national,
    );

    String formattedNationalNumber = _formatNsn(
      nationalSignificantNumber,
      metadata,
      PhoneNumberFormat.national,
      carrierCode,
    );

    return _prefixNumberWithCountryCallingCode(
      countryCallingCode,
      PhoneNumberFormat.national,
      formattedNationalNumber,
      formattedExtension,
    );
  }

  PhoneMetadata? _getMetadataForRegionOrCallingCode(
      int countryCallingCode, String? regionCode) {
    return regionCodeForNonGeoEntity == regionCode
        ? getMetadataForNonGeographicalRegion(countryCallingCode)
        : getMetadataForRegion(regionCode: regionCode);
  }

  /// Formats a phone number in national format for dialing using the carrier as
  /// specified in the `preferredDomesticCarrierCode` field of the PhoneNumber
  /// object passed in. If that is missing, use the  [fallbackCarrierCode]
  /// passed in instead. If there is no  `preferredDomesticCarrierCode`,
  /// and the [fallbackCarrierCode] contains an empty string, return the
  /// number in national format without any carrier code.
  ///
  /// <p>Use [formatNationalNumberWithCarrierCode] instead if the carrier
  /// code passed in should take precedence over the number's
  /// `preferredDomesticCarrierCode` when formatting.
  ///
  /// [number] the phone number to be formatted.
  /// [fallbackCarrierCode] the carrier selection code to be used, if
  /// none is found in the phone number itself.
  String formatNationalNumberWithPreferredCarrierCode(
      PhoneNumber number, String fallbackCarrierCode) {
    return formatNationalNumberWithCarrierCode(
      number,
      // Historically, we set this to an empty string when parsing with raw
      // input if none was found in the input string. However, this doesn't
      // result in a number we can dial. For this reason, we treat the empty
      // string the same as if it isn't set at all.
      number.preferredDomesticCarrierCode.isNotEmpty
          ? number.preferredDomesticCarrierCode
          : fallbackCarrierCode,
    );
  }

  /// Returns a number formatted in such a way that it can be dialed from a mobile
  /// phone in a specific region. If the number cannot be reached from the region
  /// (e.g. some countries block toll-free numbers from being called outside of the
  /// country), the method returns an empty string.
  ///
  /// [number] the phone number to be formatted.
  /// [regionCallingFrom] the region where the call is being placed.
  /// [withFormatting] whether the number should be returned with
  /// formatting symbols, such as spaces and dashes.
  String formatNumberForMobileDialing(
      PhoneNumber number, String regionCallingFrom, bool withFormatting) {
    int countryCallingCode = number.countryCode;
    if (!_hasValidCountryCallingCode(countryCallingCode)) {
      return number.hasRawInput() ? number.rawInput : '';
    }

    String formattedNumber = '';
    // Clear the extension, as that part cannot normally be dialed together with
    // the main number.
    PhoneNumber numberNoExt = number.deepCopy();
    numberNoExt.clearExtension_3();

    String regionCode = getRegionCodeForCountryCode(countryCallingCode);

    PhoneNumberType numberType = getNumberType(numberNoExt);

    bool isValidNumber = (numberType != PhoneNumberType.unknown);
    if (regionCallingFrom == regionCode) {
      bool isFixedLineOrMobile = (numberType == PhoneNumberType.fixedLine) ||
          (numberType == PhoneNumberType.mobile) ||
          (numberType == PhoneNumberType.fixedLineOrMobile);
      // Carrier codes may be needed in some countries. We handle this here.
      if (regionCode == 'BR' && isFixedLineOrMobile) {
        formattedNumber =
            // Historically, we set this to an empty string when parsing with raw
            // input if none was found in the input string. However, this doesn't
            // result in a number we can dial. For this reason, we treat the empty
            // string the same as if it isn't set at all.
            numberNoExt.preferredDomesticCarrierCode.isNotEmpty
                ? formatNationalNumberWithPreferredCarrierCode(numberNoExt, '')
                :
                // Brazilian fixed line and mobile numbers need to be dialed with a
                // carrier code when called within Brazil. Without that, most of the
                // carriers won't connect the call. Because of that, we return an
                // empty string here.
                '';
      } else if (countryCallingCode == _nanpaCountryCode) {
        // For NANPA countries, we output international format for numbers that
        // can be dialed internationally, since that always works, except for
        // numbers which might potentially be short numbers, which are always
        // dialled in national format.
        PhoneMetadata regionMetadata =
            getMetadataForRegion(regionCode: regionCallingFrom)!;
        if (canBeInternationallyDialled(numberNoExt) &&
            _testNumberLength(getNationalSignificantNumber(numberNoExt),
                    regionMetadata) !=
                ValidationResult.tooShort) {
          formattedNumber =
              format(numberNoExt, PhoneNumberFormat.international);
        } else {
          formattedNumber = format(numberNoExt, PhoneNumberFormat.national);
        }
      } else {
        // For non-geographical countries, and Mexican, Chilean and Uzbek fixed
        // line and mobile numbers, we output international format for numbers
        // that can be dialed internationally as that always works.
        if ((regionCode == regionCodeForNonGeoEntity ||
                // MX fixed line and mobile numbers should always be formatted in
                // international format, even when dialed within MX. For national
                // format to work, a carrier code needs to be used, and the correct
                // carrier code depends on if the caller and callee are from the
                // same local area. It is trickier to get that to work correctly than
                // using international format, which is tested to work fine on all
                // carriers.
                // CL fixed line numbers need the national prefix when dialing in the
                // national format, but don't have it when used for display. The
                // reverse is true for mobile numbers. As a result, we output them in
                // the international format to make it work.
                // UZ mobile and fixed-line numbers have to be formatted in
                // international format or prefixed with special codes like 03, 04
                // (for fixed-line) and 05 (for mobile) for dialling successfully
                // from mobile devices. As we do not have complete information on
                // special codes and to be consistent with formatting across all
                // phone types we return the number in international format here.
                ((regionCode == 'MX' ||
                        regionCode == 'CL' ||
                        regionCode == 'UZ') &&
                    isFixedLineOrMobile)) &&
            canBeInternationallyDialled(numberNoExt)) {
          formattedNumber =
              format(numberNoExt, PhoneNumberFormat.international);
        } else {
          formattedNumber = format(numberNoExt, PhoneNumberFormat.national);
        }
      }
    } else if (isValidNumber && canBeInternationallyDialled(numberNoExt)) {
      // We assume that short numbers are not diallable from outside their region,
      // so if a number is not a valid regular length phone number, we treat it as
      // if it cannot be internationally dialled.
      return withFormatting
          ? format(numberNoExt, PhoneNumberFormat.international)
          : format(numberNoExt, PhoneNumberFormat.e164);
    }
    return withFormatting
        ? formattedNumber
        : normalizeDiallableCharsOnly(formattedNumber);
  }

  /// Formats a phone number for out-of-country dialing purposes. If no
  /// regionCallingFrom is supplied, we format the number in its `international`
  /// format. If the country calling code is the same as that of the region where
  /// the number is from, then `national` formatting will be applied.
  ///
  /// <p>If the number itself has a country calling code of zero or an otherwise
  /// invalid country calling code, then we return the number with no formatting
  /// applied.
  ///
  /// <p>Note this function takes care of the case for calling inside of NANPA and
  /// between Russia and Kazakhstan (who share the same country calling code). In
  /// those cases, no international prefix is used. For regions which have multiple
  /// international prefixes, the number in its `international` format will be
  /// returned instead.
  ///
  /// [number] the phone number to be formatted.
  /// [regionCallingFrom] the region where the call is being placed.
  String formatOutOfCountryCallingNumber(
      PhoneNumber number, String regionCallingFrom) {
    if (!_isValidRegionCode(regionCallingFrom)) {
      return format(number, PhoneNumberFormat.international);
    }

    int countryCallingCode = number.countryCode;

    String nationalSignificantNumber = getNationalSignificantNumber(number);
    if (!_hasValidCountryCallingCode(countryCallingCode)) {
      return nationalSignificantNumber;
    }
    if (countryCallingCode == _nanpaCountryCode) {
      if (isNANPACountry(regionCallingFrom)) {
        // For NANPA regions, return the national format for these regions but
        // prefix it with the country calling code.
        return '$countryCallingCode ${format(number, PhoneNumberFormat.national)}';
      }
    } else if (countryCallingCode ==
        _getCountryCodeForValidRegion(regionCallingFrom)) {
      // If regions share a country calling code, the country calling code need
      // not be dialled. This also applies when dialling within a region, so this
      // if clause covers both these cases. Technically this is the case for
      // dialling from La Reunion to other overseas departments of France (French
      // Guiana, Martinique, Guadeloupe), but not vice versa - so we don't cover
      // this edge case for now and for those cases return the version including
      // country calling code. Details here:
      // http://www.petitfute.com/voyage/225-info-pratiques-reunion
      return format(number, PhoneNumberFormat.national);
    }
    // Metadata cannot be null because we checked 'isValidRegionCode()' above.
    PhoneMetadata metadataForRegionCallingFrom =
        getMetadataForRegion(regionCode: regionCallingFrom)!;

    String internationalPrefix =
        metadataForRegionCallingFrom.internationalPrefix;

    // For regions that have multiple international prefixes, the international
    // format of the number is returned, unless there is a preferred international
    // prefix.
    String internationalPrefixForFormatting = '';
    if (metadataForRegionCallingFrom.hasPreferredInternationalPrefix()) {
      internationalPrefixForFormatting =
          metadataForRegionCallingFrom.preferredInternationalPrefix;
    } else if (matchesEntirely(
        _singleInternationalPrefix, internationalPrefix)) {
      internationalPrefixForFormatting = internationalPrefix;
    }

    String regionCode = getRegionCodeForCountryCode(countryCallingCode);
    // Metadata cannot be null because the country calling code is valid.
    PhoneMetadata metadataForRegion =
        _getMetadataForRegionOrCallingCode(countryCallingCode, regionCode)!;

    String formattedNationalNumber = _formatNsn(
      nationalSignificantNumber,
      metadataForRegion,
      PhoneNumberFormat.international,
    );

    String formattedExtension = _maybeGetFormattedExtension(
      number,
      metadataForRegion,
      PhoneNumberFormat.international,
    );

    return internationalPrefixForFormatting.isNotEmpty
        ? '$internationalPrefixForFormatting $countryCallingCode $formattedNationalNumber$formattedExtension'
        : _prefixNumberWithCountryCallingCode(
            countryCallingCode,
            PhoneNumberFormat.international,
            formattedNationalNumber,
            formattedExtension,
          );
  }

  /// Formats a phone number using the original phone number format that the number
  /// is parsed from. The original format is embedded in the `countryCodeSource`
  /// field of the PhoneNumber object passed in. If such information is missing,
  /// the number will be formatted into the `national` format by default. When the
  /// number contains a leading zero and this is unexpected for this country, or
  /// we don't have a formatting pattern for the number, the method returns the
  /// raw input when it is available.
  ///
  /// Note this method guarantees no digit will be inserted, removed or modified as
  /// a result of formatting.
  ///
  /// [number] the phone number that needs to be formatted in its original number format.
  /// [regionCallingFrom] the region whose IDD needs to be prefixed if the original number has one.
  String formatInOriginalFormat(PhoneNumber number, String regionCallingFrom) {
    if (number.hasRawInput() && !_hasFormattingPatternForNumber(number)) {
      // We check if we have the formatting pattern because without that, we might
      // format the number as a group without national prefix.
      return number.rawInput;
    }
    if (!number.hasCountryCodeSource()) {
      return format(number, PhoneNumberFormat.national);
    }

    String formattedNumber;
    switch (number.countryCodeSource) {
      case PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN:
        formattedNumber = format(number, PhoneNumberFormat.international);
        break;
      case PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_IDD:
        formattedNumber =
            formatOutOfCountryCallingNumber(number, regionCallingFrom);
        break;
      case PhoneNumber_CountryCodeSource.FROM_NUMBER_WITHOUT_PLUS_SIGN:
        formattedNumber =
            format(number, PhoneNumberFormat.international).substring(1);
        break;
      case PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY:
      // Fall-through to default case.
      default:
        String regionCode = getRegionCodeForCountryCode(number.countryCode);
        // We strip non-digits from the NDD here, and from the raw input later,
        // so that we can compare them easily.
        String? nationalPrefix = getNddPrefixForRegion(regionCode, true);

        String nationalFormat = format(number, PhoneNumberFormat.national);
        if (nationalPrefix == null || nationalPrefix.isEmpty) {
          // If the region doesn't have a national prefix at all, we can safely
          // return the national format without worrying about a national prefix
          // being added.
          formattedNumber = nationalFormat;
          break;
        }
        // Otherwise, we check if the original number was entered with a national
        // prefix.
        if (_rawInputContainsNationalPrefix(
            number.rawInput, nationalPrefix, regionCode)) {
          // If so, we can safely return the national format.
          formattedNumber = nationalFormat;
          break;
        }
        // Metadata cannot be null here because getNddPrefixForRegion() (above)
        // returns null if there is no metadata for the region.
        PhoneMetadata metadata = getMetadataForRegion(regionCode: regionCode)!;

        String nationalNumber = getNationalSignificantNumber(number);

        NumberFormat? formatRule = chooseFormattingPatternForNumber(
            metadata.numberFormat, nationalNumber);
        // The format rule could still be null here if the national number was 0
        // and there was no raw input (this should not be possible for numbers
        // generated by the phonenumber library as they would also not have a
        // country calling code and we would have exited earlier).
        if (formatRule == null) {
          formattedNumber = nationalFormat;
          break;
        }
        // When the format we apply to this number doesn't contain national
        // prefix, we can just return the national format.
        // TODO: Refactor the code below with the code in
        // isNationalPrefixPresentIfRequired.
        String candidateNationalPrefixRule =
            formatRule.nationalPrefixFormattingRule;
        // We assume that the first-group symbol will never be _before_ the
        // national prefix.
        int indexOfFirstGroup = candidateNationalPrefixRule.indexOf('\$1');
        if (indexOfFirstGroup <= 0) {
          formattedNumber = nationalFormat;
          break;
        }
        candidateNationalPrefixRule =
            candidateNationalPrefixRule.substring(0, indexOfFirstGroup);
        candidateNationalPrefixRule =
            normalizeDigitsOnly(candidateNationalPrefixRule);
        if (candidateNationalPrefixRule.isEmpty) {
          // National prefix not used when formatting this number.
          formattedNumber = nationalFormat;
          break;
        }
        // Otherwise, we need to remove the national prefix from our output.
        NumberFormat numFormatCopy = formatRule.deepCopy();
        numFormatCopy.clearNationalPrefixFormattingRule();
        formattedNumber = formatByPattern(
            number, PhoneNumberFormat.national, [numFormatCopy]);
        break;
    }

    String rawInput = number.rawInput;
    // If no digit is inserted/removed/modified as a result of our formatting, we
    // return the formatted phone number; otherwise we return the raw input the
    // user entered.
    if (formattedNumber.isNotEmpty && rawInput.isNotEmpty) {
      String normalizedFormattedNumber =
          normalizeDiallableCharsOnly(formattedNumber);
      String normalizedRawInput = normalizeDiallableCharsOnly(rawInput);
      if (normalizedFormattedNumber != normalizedRawInput) {
        formattedNumber = rawInput;
      }
    }
    return formattedNumber;
  }

  /// Check if rawInput, which is assumed to be in the national format, has a
  /// national prefix. The national prefix is assumed to be in digits-only form.
  bool _rawInputContainsNationalPrefix(
      String rawInput, String nationalPrefix, String regionCode) {
    String normalizedNationalNumber = normalizeDigitsOnly(rawInput);
    if (normalizedNationalNumber.startsWith(nationalPrefix)) {
      try {
        // Some Japanese numbers (e.g. 00777123) might be mistaken to contain the
        // national prefix when written without it (e.g. 0777123) if we just do
        // prefix matching. To tackle that, we check the validity of the number if
        // the assumed national prefix is removed (777123 won't be valid in
        // Japan).
        return isValidNumber(parse(
            normalizedNationalNumber.substring(nationalPrefix.length),
            regionCode));
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  bool _hasFormattingPatternForNumber(PhoneNumber number) {
    int countryCallingCode = number.countryCode;
    String phoneNumberRegion = getRegionCodeForCountryCode(countryCallingCode);

    PhoneMetadata? metadata = _getMetadataForRegionOrCallingCode(
        countryCallingCode, phoneNumberRegion);
    if (metadata == null) return false;

    String nationalNumber = getNationalSignificantNumber(number);
    NumberFormat? formatRule =
        chooseFormattingPatternForNumber(metadata.numberFormat, nationalNumber);

    return formatRule != null;
  }

  ///  Formats a phone number for out-of-country dialing purposes.
  ///
  /// Note that in this version, if the number was entered originally using alpha
  /// characters and this version of the number is stored in [rawInput], this
  /// representation of the number will be used rather than the digit
  /// representation. Grouping information, as specified by characters such as '-'
  /// and ' ', will be retained.
  ///
  /// <p><b>Caveats:</b></p>
  /// <ul>
  /// <li>This will not produce good results if the country calling code is both
  /// present in the raw input _and_ is the start of the national number. This is
  /// not a problem in the regions which typically use alpha numbers.
  /// <li>This will also not produce good results if the raw input has any grouping
  /// information within the first three digits of the national number, and if the
  /// function needs to strip preceding digits/words in the raw input before these
  /// digits. Normally people group the first three digits together so this is not
  /// a huge problem - and will be fixed if it proves to be so.
  /// </ul>
  ///
  /// [number] the phone number that needs to be formatted.
  /// [regionCallingFrom] the region where the call is being placed.
  String formatOutOfCountryKeepingAlphaChars(
      PhoneNumber number, String regionCallingFrom) {
    String rawInput = number.rawInput;
    // If there is no raw input, then we can't keep alpha characters because there
    // aren't any. In this case, we return formatOutOfCountryCallingNumber.
    if (rawInput.isEmpty) {
      return formatOutOfCountryCallingNumber(number, regionCallingFrom);
    }

    int countryCode = number.countryCode;
    if (!_hasValidCountryCallingCode(countryCode)) {
      return rawInput;
    }
    // Strip any prefix such as country calling code, IDD, that was present. We do
    // this by comparing the number in raw_input with the parsed number. To do
    // this, first we normalize punctuation. We retain number grouping symbols
    // such as ' ' only.
    rawInput = _normalizeHelper(rawInput, _allPlusNumberGroupingSymbols, true);

    // Now we trim everything before the first three digits in the parsed number.
    // We choose three because all valid alpha numbers have 3 digits at the start
    // - if it does not, then we don't trim anything at all. Similarly, if the
    // national number was less than three digits, we don't trim anything at all.
    String nationalNumber = getNationalSignificantNumber(number);
    if (nationalNumber.length > 3) {
      int firstNationalNumberDigit =
          rawInput.indexOf(nationalNumber.substring(0, 3));
      if (firstNationalNumberDigit != -1) {
        rawInput = rawInput.substring(firstNationalNumberDigit);
      }
    }

    PhoneMetadata? metadataForRegionCallingFrom =
        getMetadataForRegion(regionCode: regionCallingFrom);
    if (countryCode == _nanpaCountryCode) {
      if (isNANPACountry(regionCallingFrom)) {
        return '$countryCode $rawInput';
      }
    } else if (metadataForRegionCallingFrom != null &&
        countryCode == _getCountryCodeForValidRegion(regionCallingFrom)) {
      NumberFormat? formattingPattern = chooseFormattingPatternForNumber(
        metadataForRegionCallingFrom.numberFormat,
        nationalNumber,
      );

      if (formattingPattern == null) {
        // If no pattern above is matched, we format the original input.
        return rawInput;
      }

      NumberFormat newFormat = formattingPattern.deepCopy();
      // The first group is the first group of digits that the user wrote
      // together.
      newFormat.pattern = '(\\d+)(.*)';
      // Here we just concatenate them back together after the national prefix
      // has been fixed.
      newFormat.format = '\$1\$2';
      // Now we format using this pattern instead of the default pattern, but
      // with the national prefix prefixed if necessary.
      // This will not work in the cases where the pattern (and not the leading
      // digits) decide whether a national prefix needs to be used, since we have
      // overridden the pattern to match anything, but that is not the case in the
      // metadata to date.
      return formatNsnUsingPattern(
          rawInput, newFormat, PhoneNumberFormat.national);
    }

    String internationalPrefixForFormatting = '';
    // If an unsupported region-calling-from is entered, or a country with
    // multiple international prefixes, the international format of the number is
    // returned, unless there is a preferred international prefix.
    if (metadataForRegionCallingFrom != null) {
      String internationalPrefix =
          metadataForRegionCallingFrom.internationalPrefix;
      internationalPrefixForFormatting =
          matchesEntirely(_singleInternationalPrefix, internationalPrefix)
              ? internationalPrefix
              : metadataForRegionCallingFrom.preferredInternationalPrefix;
    }

    String regionCode = getRegionCodeForCountryCode(countryCode);

    // Metadata cannot be null because the country calling code is valid.
    PhoneMetadata metadataForRegion =
        _getMetadataForRegionOrCallingCode(countryCode, regionCode)!;

    String formattedExtension = _maybeGetFormattedExtension(
      number,
      metadataForRegion,
      PhoneNumberFormat.international,
    );

    if (internationalPrefixForFormatting.isNotEmpty) {
      return '$internationalPrefixForFormatting $countryCode $rawInput$formattedExtension';
    } else {
      // Invalid region entered as country-calling-from (so no metadata was found
      // for it) or the region chosen has multiple international dialling
      // prefixes.
      return _prefixNumberWithCountryCallingCode(
        countryCode,
        PhoneNumberFormat.international,
        rawInput,
        formattedExtension,
      );
    }
  }

  /// Gets the national significant number of a phone number. Note a national
  /// significant number doesn't contain a national prefix or any formatting.
  ///
  /// [number] the phone number for which the national significant number is needed.
  String getNationalSignificantNumber(PhoneNumber number) {
    if (!number.hasNationalNumber()) return '';
    String nationalNumber = '${number.nationalNumber}';
    // If leading zero(s) have been set, we prefix this now. Note that a single
    // leading zero is not the same as a national prefix; leading zeros should be
    // dialled no matter whether you are dialling from within or outside the
    // country, national prefixes are added when formatting nationally if
    // applicable.
    if (number.italianLeadingZero && number.numberOfLeadingZeros > 0) {
      final leadingZeros =
          List.filled((number.numberOfLeadingZeros), '0').join();
      return '$leadingZeros$nationalNumber';
    }
    return nationalNumber;
  }

  /// A helper function that is used by format and formatByPattern.
  String _prefixNumberWithCountryCallingCode(
    int countryCallingCode,
    PhoneNumberFormat numberFormat,
    String formattedNationalNumber,
    String formattedExtension,
  ) {
    switch (numberFormat) {
      case PhoneNumberFormat.e164:
        return '$plusSign$countryCallingCode$formattedNationalNumber$formattedExtension';

      case PhoneNumberFormat.international:
        return '$plusSign$countryCallingCode $formattedNationalNumber$formattedExtension';

      case PhoneNumberFormat.rfc3966:
        return '$_rfc3966Prefix$plusSign$countryCallingCode-$formattedNationalNumber$formattedExtension';

      default:
        return formattedNationalNumber + formattedExtension;
    }
  }

  /// Note in some regions, the national number can be written in two completely
  /// different ways depending on whether it forms part of the NATIONAL format or
  /// INTERNATIONAL format. The numberFormat parameter here is used to specify
  /// which format to use for those cases. If a carrierCode is specified, this will
  /// be inserted into the formatted string to replace $CC.
  /// [number] a string of characters representing a phone number.
  /// [metadata] the metadata for the region that we think this number is from.
  /// [numberFormat] the format the phone number should be formatted into.
  /// [optCarriercode]
  String _formatNsn(
      String number, PhoneMetadata metadata, PhoneNumberFormat numberFormat,
      [String? optCarriercode]) {
    List<NumberFormat> intlNumberFormats = metadata.intlNumberFormat;
    // When the intlNumberFormats exists, we use that to format national number
    // for the INTERNATIONAL format instead of using the numberDesc.numberFormats.

    List<NumberFormat> availableFormats = (intlNumberFormats.isEmpty ||
            numberFormat == PhoneNumberFormat.national)
        ? metadata.numberFormat
        : metadata.intlNumberFormat;

    NumberFormat? formattingPattern =
        chooseFormattingPatternForNumber(availableFormats, number);
    return (formattingPattern == null)
        ? number
        : formatNsnUsingPattern(
            number, formattingPattern, numberFormat, optCarriercode);
  }

  /// [availableFormats] the available formats the phone number could be formatted into.
  /// [nationalNumber] a string of characters representing a phone number.
  NumberFormat? chooseFormattingPatternForNumber(
      List<NumberFormat> availableFormats, String nationalNumber) {
    for (var numFormat in availableFormats) {
      int size = numFormat.leadingDigitsPattern.length;
      if (size == 0 ||
          // We always use the last leading_digits_pattern, as it is the most detailed.
          RegExp(numFormat.leadingDigitsPattern[size - 1])
                  .matchAsPrefix(nationalNumber) !=
              null) {
        if (matchesEntirely(RegExp(numFormat.pattern), nationalNumber)) {
          return numFormat;
        }
      }
    }
    return null;
  }

  /// Note that carrierCode is optional - if null or an empty string, no carrier
  /// code replacement will take place.
  ///
  /// [nationalNumber] a string of characters representing a phone number.
  /// [formattingPattern] the formatting rule the phone number should be formatted into.
  /// [numberFormat] the format the phone number should be formatted into.
  /// [optCarrierCode]
  String formatNsnUsingPattern(String nationalNumber,
      NumberFormat formattingPattern, PhoneNumberFormat numberFormat,
      [String? optCarrierCode]) {
    String numberFormatRule = formattingPattern.format;
    String formattedNationalNumber = '';
    RegExp patternToMatch = RegExp(r'' + formattingPattern.pattern);

    if (numberFormat == PhoneNumberFormat.national &&
        optCarrierCode != null &&
        optCarrierCode.isNotEmpty &&
        formattingPattern.domesticCarrierCodeFormattingRule.isNotEmpty) {
      // Replace the $CC in the formatting rule with the desired carrier code.
      String carrierCodeFormattingRule =
          formattingPattern.domesticCarrierCodeFormattingRule;
      carrierCodeFormattingRule =
          carrierCodeFormattingRule.replaceAll(_ccString, optCarrierCode);
      // Now replace the $FG in the formatting rule with the first group and the
      // carrier code
      // combined in the appropriate way.
      numberFormatRule = numberFormatRule.replaceFirst(
          firstGroupPattern, carrierCodeFormattingRule);
      formattedNationalNumber =
          replaceAllAndFormat(nationalNumber, patternToMatch, numberFormatRule);
    } else {
      // Use the national prefix formatting rule instead.
      String nationalPrefixFormattingRule =
          formattingPattern.nationalPrefixFormattingRule;
      if (numberFormat == PhoneNumberFormat.national &&
          nationalPrefixFormattingRule.isNotEmpty) {
        String format = numberFormatRule.replaceFirst(
            firstGroupPattern, nationalPrefixFormattingRule);
        formattedNationalNumber =
            replaceAllAndFormat(nationalNumber, patternToMatch, format);
      } else {
        formattedNationalNumber = replaceAllAndFormat(
            nationalNumber, patternToMatch, numberFormatRule);
      }
    }
    if (numberFormat == PhoneNumberFormat.rfc3966) {
      // Strip any leading punctuation.
      RegExp separatorPattern = RegExp(r'^' + _separatorPattern);
      if (separatorPattern.matchAsPrefix(formattedNationalNumber) != null) {
        formattedNationalNumber =
            replaceAllAndFormat(formattedNationalNumber, separatorPattern, '');
      }
      // Replace the rest with a dash between each number group.
      formattedNationalNumber = replaceAllAndFormat(
          formattedNationalNumber, RegExp(_separatorPattern), '-');
    }
    return formattedNationalNumber;
  }

  String replaceAllAndFormat(String text, RegExp pattern, String format) {
    return text.replaceAllMapped(pattern, (match) {
      return format.replaceAllMapped(firstGroupPattern, (placeholderMatch) {
        final groupNumber = int.parse(placeholderMatch.group(1)!);
        return match.group(groupNumber) ?? '';
      });
    });
  }

  String replaceFirstAndFormat(String text, Pattern pattern, String format) {
    return text.replaceFirstMapped(pattern, (match) {
      return format.replaceFirstMapped(firstGroupPattern, (placeholderMatch) {
        final groupNumber = int.parse(placeholderMatch.group(1)!);
        return match.group(groupNumber) ?? '';
      });
    });
  }

  /// Gets a valid number for the specified region.
  ///
  /// [regionCode] the region for which an example number is needed.
  /// [getExampleNumber] returns a valid fixed-line number for the
  /// specified region. Returns null when the metadata does not contain such
  /// information, or the region 001 is passed in. For 001 (representing non-
  /// geographical numbers), call {@link #getExampleNumberForNonGeoEntity} instead.
  PhoneNumber? getExampleNumber(String regionCode) {
    return getExampleNumberForType(
      regionCode: regionCode,
      type: PhoneNumberType.fixedLine,
    );
  }

  /// Gets a valid number for the specified region and number type.
  ///
  /// [regionCode] the region for which an example number is needed.
  /// [type] the type of number that is needed.
  /// [getExampleNumberForType] returns a valid number for the specified
  /// region and type. Returns null when the metadata does not contain such
  /// information or if an invalid region or region 001 was entered.
  /// For 001 (representing non-geographical numbers), call
  /// [getExampleNumberForNonGeoEntity] instead.
  PhoneNumber? getExampleNumberForType(
      {String? regionCode, required PhoneNumberType type}) {
    if (regionCode != null) {
      // Check the region code is valid.
      if (!_isValidRegionCode(regionCode)) return null;
      PhoneMetadata metadata = getMetadataForRegion(regionCode: regionCode)!;
      PhoneNumberDesc desc = _getNumberDescByType(metadata, type);
      try {
        if (desc.hasExampleNumber()) {
          return parse(desc.exampleNumber, regionCode);
        }
      } catch (_) {}
      return null;
    } //
    else {
      for (String regionCode in supportedRegions) {
        PhoneNumber? exampleNumber =
            getExampleNumberForType(regionCode: regionCode, type: type);
        if (exampleNumber != null) {
          return exampleNumber;
        }
      }

      // If there wasn't an example number for a region,
      // try the non-geographical entities.
      for (int countryCallingCode in supportedGlobalNetworkCallingCodes) {
        PhoneNumberDesc desc = _getNumberDescByType(
            getMetadataForNonGeographicalRegion(countryCallingCode)!, type);
        try {
          if (desc.hasExampleNumber()) {
            return parse(
                "+$countryCallingCode${desc.exampleNumber}", _unknownRegion);
          }
        } catch (_) {}
      }
      // There are no example numbers of this type for any country in the library.
      return null;
    }
  }

  /// Gets a valid number for the specified country calling code for a
  /// non-geographical entity.
  ///
  /// [countryCallingCode] the country calling code for a non-geographical entity.
  /// [getExampleNumberForNonGeoEntity] returns a valid number for the
  /// non-geographical entity. Returns null when the metadata does not contain
  /// such information, or the country calling code passed in does not belong
  /// to a non-geographical entity.
  PhoneNumber? getExampleNumberForNonGeoEntity(int countryCallingCode) {
    PhoneMetadata? metadata =
        getMetadataForNonGeographicalRegion(countryCallingCode);

    if (metadata != null) {
      PhoneNumberDesc? numberTypeWithExampleNumber = [
        metadata.mobile,
        metadata.tollFree,
        metadata.sharedCost,
        metadata.voip,
        metadata.voicemail,
        metadata.uan,
        metadata.premiumRate,
      ].firstWhere(
        (desc) => desc.hasExampleNumber(),
        orElse: () => PhoneNumberDesc(),
      );

      if (numberTypeWithExampleNumber.isInitialized()) {
        try {
          return parse(
              '+$countryCallingCode${numberTypeWithExampleNumber.exampleNumber}',
              'ZZ');
        } catch (e) {
          return null;
        }
      }
    }
    return null;
  }

  ///  Gets the formatted extension of a phone number, if the phone number had an
  /// extension specified. If not, it returns an empty string.
  ///
  /// [number] the PhoneNumber that might have an extension.
  /// [metadata] the metadata for the region that we think this number is from.
  /// [numberFormat] the format the phone number should be formatted into.
  /// [_maybeGetFormattedExtension] returns the formatted extension if any.
  String _maybeGetFormattedExtension(
    PhoneNumber number,
    PhoneMetadata metadata,
    PhoneNumberFormat numberFormat,
  ) {
    if (!number.hasExtension_3() || number.extension_3.isEmpty) {
      return '';
    } else {
      if (numberFormat == PhoneNumberFormat.rfc3966) {
        return '$_rfc3966ExtnPrefix${number.extension_3}';
      } else {
        if (metadata.hasPreferredExtnPrefix()) {
          return metadata.preferredExtnPrefix + number.extension_3;
        } else {
          return '$_defaultExtnPrefix${number.extension_3}';
        }
      }
    }
  }

  PhoneNumberDesc _getNumberDescByType(
      PhoneMetadata metadata, PhoneNumberType type) {
    switch (type) {
      case PhoneNumberType.premiumRate:
        return metadata.premiumRate;
      case PhoneNumberType.tollFree:
        return metadata.tollFree;
      case PhoneNumberType.mobile:
        return metadata.mobile;
      case PhoneNumberType.fixedLine:
      case PhoneNumberType.fixedLineOrMobile:
        return metadata.fixedLine;
      case PhoneNumberType.sharedCost:
        return metadata.sharedCost;
      case PhoneNumberType.voip:
        return metadata.voip;
      case PhoneNumberType.personalNumber:
        return metadata.personalNumber;
      case PhoneNumberType.pager:
        return metadata.pager;
      case PhoneNumberType.uan:
        return metadata.uan;
      case PhoneNumberType.voicemail:
        return metadata.voicemail;
      default:
        return metadata.generalDesc;
    }
  }

  /// Gets the type of a valid phone number.
  ///
  /// [number] the phone number that we want to know the type.
  /// [getNumberType] returns the type of the phone number, or unknown if it is invalid.
  PhoneNumberType getNumberType(PhoneNumber number) {
    String? regionCode = getRegionCodeForNumber(number);

    PhoneMetadata? metadata =
        _getMetadataForRegionOrCallingCode(number.countryCode, regionCode);
    if (metadata == null) return PhoneNumberType.unknown;

    String nationalSignificantNumber = getNationalSignificantNumber(number);
    return _getNumberTypeHelper(nationalSignificantNumber, metadata);
  }

  PhoneNumberType _getNumberTypeHelper(
      String nationalNumber, PhoneMetadata metadata) {
    if (!_isNumberMatchingDesc(nationalNumber, metadata.generalDesc)) {
      return PhoneNumberType.unknown;
    }

    if (_isNumberMatchingDesc(nationalNumber, metadata.premiumRate)) {
      return PhoneNumberType.premiumRate;
    }
    if (_isNumberMatchingDesc(nationalNumber, metadata.tollFree)) {
      return PhoneNumberType.tollFree;
    }
    if (_isNumberMatchingDesc(nationalNumber, metadata.sharedCost)) {
      return PhoneNumberType.sharedCost;
    }
    if (_isNumberMatchingDesc(nationalNumber, metadata.voip)) {
      return PhoneNumberType.voip;
    }
    if (_isNumberMatchingDesc(nationalNumber, metadata.personalNumber)) {
      return PhoneNumberType.personalNumber;
    }
    if (_isNumberMatchingDesc(nationalNumber, metadata.pager)) {
      return PhoneNumberType.pager;
    }
    if (_isNumberMatchingDesc(nationalNumber, metadata.uan)) {
      return PhoneNumberType.uan;
    }
    if (_isNumberMatchingDesc(nationalNumber, metadata.voicemail)) {
      return PhoneNumberType.voicemail;
    }

    bool isFixedLine =
        _isNumberMatchingDesc(nationalNumber, metadata.fixedLine);

    if (isFixedLine) {
      if (metadata.sameMobileAndFixedLinePattern) {
        return PhoneNumberType.fixedLineOrMobile;
      } else if (_isNumberMatchingDesc(nationalNumber, metadata.mobile)) {
        return PhoneNumberType.fixedLineOrMobile;
      }
      return PhoneNumberType.fixedLine;
    }
    // Otherwise, test to see if the number is mobile. Only do this if certain
    // that the patterns for mobile and fixed line aren't the same.
    if (!metadata.sameMobileAndFixedLinePattern &&
        _isNumberMatchingDesc(nationalNumber, metadata.mobile)) {
      return PhoneNumberType.mobile;
    }
    return PhoneNumberType.unknown;
  }

  /// Returns the metadata for the given [regionCode] or null
  /// if the region code is invalid or unknown.
  PhoneMetadata? getMetadataForRegion({String? regionCode, int? countryCode}) {
    if (regionCode != null && _isValidRegionCode(regionCode)) {
      regionToMetadataMap[regionCode] = _getMetadata(regionCode)!;
      return regionToMetadataMap[regionCode];
    } else if (countryCode != null) {
      final metadata = _getMetadata('$countryCode');
      if (metadata != null) {
        regionToMetadataMap['$countryCode'] = metadata;
        return regionToMetadataMap['$countryCode'];
      }
    }
    return null;
  }

  PhoneMetadata? getAlternateFormatsMetadata(int countryCode) {
    Map<String, Object?>? metadata =
        PhoneNumberAltFormatsMetadataMap().getTerritory('$countryCode');
    return PhoneMetadata()..mergeFromProto3Json(metadata);
  }

  PhoneMetadata? _getMetadata(String regionOrCountryCode) {
    PhoneMetadata? metadata = regionToMetadataMap[regionOrCountryCode];
    if (metadata != null) return metadata;
    return _getPhoneNumberMetdata(regionOrCountryCode);
  }

  PhoneMetadata? _getPhoneNumberMetdata(String regionCode) {
    Map<String, Object?>? metadata =
        _metadataMapLoader.getTerritory(regionCode);
    return PhoneMetadata()..mergeFromProto3Json(metadata);
  }

  PhoneMetadata? getMetadataForNonGeographicalRegion(int countryCallingCode) {
    if (!supportedGlobalNetworkCallingCodes.contains(countryCallingCode)) {
      return null;
    }
    return getMetadataForRegion(countryCode: countryCallingCode);
  }

  bool _isNumberMatchingDesc(
      String nationalNumber, PhoneNumberDesc numberDesc) {
    // Check if any possible number lengths are present; if so, we use them to
    // avoid checking the validation pattern if they don't match. If they are
    // absent, this means they match the general description, which we have
    // already checked before a specific number type.
    int actualLength = nationalNumber.length;
    List<int> possibleLengths = numberDesc.possibleLength;

    if (possibleLengths.isNotEmpty && !possibleLengths.contains(actualLength)) {
      return false;
    }

    return matchNationalNumber(nationalNumber, numberDesc, false);
  }

  /// Tests whether a phone number matches a valid pattern. Note this doesn't
  /// verify the number is actually in use, which is impossible to tell by just
  /// looking at a number itself.
  /// It only verifies whether the parsed, canonicalised number is valid: not
  /// whether a particular series of digits entered by the user is diallable from
  /// the region provided when parsing. For example, the number +41 (0) 78 927 2696
  /// can be parsed into a number with country code '41' and national significant
  /// number '789272696'. This is valid, while the original string is not
  /// diallable.
  ///
  /// [number] the phone number that we want to validate.
  /// [isValidNumber] returns a boolean that indicates whether
  /// the number is of a valid pattern.
  bool isValidNumber(PhoneNumber number) {
    String? regionCode = getRegionCodeForNumber(number);
    return isValidNumberForRegion(number, regionCode);
  }

  /// Tests whether a phone number is valid for a certain region. Note this doesn't
  /// verify the number is actually in use, which is impossible to tell by just
  /// looking at a number itself. If the country calling code is not the same as
  /// the country calling code for the region, this immediately exits with false.
  /// After this, the specific number pattern rules for the region are examined.
  /// This is useful for determining for example whether a particular number is
  /// valid for Canada, rather than just a valid NANPA number.
  /// Warning: In most cases, you want to use {@link #isValidNumber} instead. For
  /// example, this method will mark numbers from British Crown dependencies such
  /// as the Isle of Man as invalid for the region 'GB' (United Kingdom), since it
  /// has its own region code, 'IM', which may be undesirable.
  ///
  /// [number] the phone number that we want to validate.
  /// [regionCode] the region that we want to validate the phone number for.
  /// [isValidNumberForRegion] returns a boolean that indicates whether
  /// the number is of a valid pattern.
  bool isValidNumberForRegion(PhoneNumber number, String? regionCode) {
    int countryCode = number.countryCode;
    PhoneMetadata? metadata =
        _getMetadataForRegionOrCallingCode(countryCode, regionCode);
    if (metadata == null ||
        (regionCodeForNonGeoEntity != regionCode &&
            countryCode != _getCountryCodeForValidRegion(regionCode))) {
      // Either the region code was invalid, or the country calling code for this
      // number does not match that of the region code.
      return false;
    }
    String nationalSignificantNumber = getNationalSignificantNumber(number);
    return _getNumberTypeHelper(nationalSignificantNumber, metadata) !=
        PhoneNumberType.unknown;
  }

  /// Returns the region where a phone number is from. This could be used for
  /// geocoding at the region level. Only guarantees correct results for valid,
  /// full numbers (not short-codes, or invalid numbers).
  ///
  /// [number] the phone number whose origin we want to know.
  /// [getRegionCodeForNumber] returns the region where the phone number is from,
  /// or null if no region matches this calling code.
  String? getRegionCodeForNumber(PhoneNumber? number) {
    if (number == null) return null;
    int countryCode = number.countryCode;

    List<String>? regions =
        _metadataMapLoader.countryCodeToRegionCodeMap['$countryCode'];
    if (regions == null || regions.isEmpty) return null;

    if (regions.length == 1) {
      return regions.first;
    } else {
      return _getRegionCodeForNumberFromRegionList(number, regions);
    }
  }

  String? _getRegionCodeForNumberFromRegionList(
      PhoneNumber number, List<String> regionCodes) {
    String nationalNumber = getNationalSignificantNumber(number);

    for (String regionCode in regionCodes) {
      // If leadingDigits is present, use this. Otherwise, do full validation.
      // Metadata cannot be null because the region codes come from the country
      // calling code map.
      PhoneMetadata metadata = getMetadataForRegion(regionCode: regionCode)!;
      if (metadata.hasLeadingDigits()) {
        final pattern = RegExp(metadata.leadingDigits);
        if (pattern.matchAsPrefix(nationalNumber) != null) {
          return regionCode;
        }
      } else if (_getNumberTypeHelper(nationalNumber, metadata) !=
          PhoneNumberType.unknown) {
        return regionCode;
      }
    }
    return null;
  }

  /// Returns the region code that matches the specific country calling code. In
  /// the case of no region code being found, ZZ will be returned. In the case of
  /// multiple regions, the one designated in the metadata as the 'main' region for
  /// this calling code will be returned.
  ///
  /// [countryCallingCode] the country calling code.
  String getRegionCodeForCountryCode(int countryCallingCode) {
    List<String>? regionCodes =
        _metadataMapLoader.countryCodeToRegionCodeMap['$countryCallingCode'];
    return regionCodes == null ? _unknownRegion : regionCodes[0];
  }

  /// Returns a list with the region codes that match the specific country calling
  /// code. For non-geographical country calling codes, the region code 001 is
  /// returned. Also, in the case of no region code being found, an empty list is
  /// returned.
  ///
  /// [countryCallingCode] the country calling code.
  List<String> getRegionCodesForCountryCode(int countryCallingCode) {
    return _metadataMapLoader
            .countryCodeToRegionCodeMap['$countryCallingCode'] ??
        [];
  }

  /// Returns the country calling code for a specific region. For example, this
  /// would be 1 for the United States, and 64 for New Zealand.
  ///
  /// [regionCode] the region that we want to get the country calling code for.
  /// [getCountryCodeForRegion] returns the country calling code for
  /// the region denoted by regionCode.
  int getCountryCodeForRegion(String? regionCode) {
    if (!_isValidRegionCode(regionCode)) return 0;
    return _getCountryCodeForValidRegion(regionCode);
  }

  /// Returns the country calling code for a specific region. For example, this
  /// would be 1 for the United States, and 64 for New Zealand. Assumes the region
  /// is already valid.
  ///
  /// [regionCode] the region that we want to get the country calling code for.
  /// [_getCountryCodeForValidRegion] returns the country calling code
  /// for the region denoted by regionCode.
  /// throws [IllegalArgumentException] if the region is invalid
  int _getCountryCodeForValidRegion(String? regionCode) {
    PhoneMetadata? metadata = getMetadataForRegion(regionCode: regionCode);
    if (metadata == null) {
      throw IllegalArgumentException('Invalid region code: $regionCode');
    }
    return metadata.countryCode;
  }

  /// Returns the national dialling prefix for a specific region. For example, this
  /// would be 1 for the United States, and 0 for New Zealand. Set stripNonDigits
  /// to true to strip symbols like '~' (which indicates a wait for a dialling
  /// tone) from the prefix returned. If no national prefix is present, we return
  /// null.
  ///
  /// <p>Warning: Do not use this method for do-your-own formatting - for some
  /// regions, the national dialling prefix is used only for certain types of
  /// numbers. Use the library's formatting functions to prefix the national prefix
  /// when required.
  ///
  /// [regionCode] the region that we want to get the dialling prefix for.
  /// [stripNonDigits] true to strip non-digits from the national dialling prefix.
  /// [getNddPrefixForRegion] returns the dialling prefix for the region denoted by regionCode.
  String? getNddPrefixForRegion(String? regionCode, bool stripNonDigits) {
    PhoneMetadata? metadata = getMetadataForRegion(regionCode: regionCode);
    if (metadata == null) return null;

    String nationalPrefix = metadata.nationalPrefix;
    // If no national prefix was found, we return null.
    if (nationalPrefix.isEmpty) return null;

    if (stripNonDigits) {
      // Note: if any other non-numeric symbols are ever used in national
      // prefixes, these would have to be removed here as well.
      nationalPrefix = nationalPrefix.replaceFirst('~', '');
    }
    return nationalPrefix;
  }

  /// Checks if this is a region under the North American Numbering Plan
  /// Administration (NANPA).
  ///
  /// [regionCode] the CLDR two-letter region code.
  /// [isNANPACountry] returns true if regionCode is one of the regions under NANPA.
  bool isNANPACountry(String? regionCode) {
    List<String> regions =
        _metadataMapLoader.countryCodeToRegionCodeMap['$_nanpaCountryCode'] ??
            [];
    return regionCode != null && (regions.contains(regionCode.toUpperCase()));
  }

  /// Checks if the number is a valid vanity (alpha) number such as 800 MICROSOFT.
  /// A valid vanity number will start with at least 3 digits and will have three
  /// or more alpha characters. This does not do region-specific checks - to work
  /// out if this number is actually valid for a region, it should be parsed and
  /// methods such as [isPossibleNumberWithReason] and
  /// [isValidNumber] should be used.
  ///
  /// [number] the number that needs to be checked.
  /// [isAlphaNumber] returns true if the number is a valid vanity number.
  bool isAlphaNumber(String number) {
    if (!isViablePhoneNumber(number)) {
      // Number is too short, or doesn't match the basic phone number pattern.
      return false;
    }

    StringBuffer strippedNumber = StringBuffer(number);
    maybeStripExtension(strippedNumber);
    return matchesEntirely(_validAlphaPhonePattern, strippedNumber.toString());
  }

  /// Convenience wrapper around [isPossibleNumberWithReason]. Instead of
  /// returning the reason for failure, this method returns true if the number is
  /// either a possible fully-qualified number (containing the area code and
  /// country code), or if the number could be a possible local number (with a
  /// country code, but missing an area code). Local numbers are considered
  /// possible if they could be possibly dialled in this format: if the area code
  /// is needed for a call to connect, the number is not considered possible
  /// without it.
  ///
  /// [number] the number that needs to be checked
  /// [isPossibleNumber] returns true if the number is possible
  bool isPossibleNumber(PhoneNumber number) {
    ValidationResult result = isPossibleNumberWithReason(number);
    return result == ValidationResult.isPossible ||
        result == ValidationResult.isPossibleLocalOnly;
  }

  /// Convenience wrapper around [isPossibleNumberForTypeWithReason].
  /// Instead of returning the reason for failure, this method returns true if the
  /// number is either a possible fully-qualified number (containing the area code
  /// and country code), or if the number could be a possible local number (with a
  /// country code, but missing an area code). Local numbers are considered
  /// possible if they could be possibly dialled in this format: if the area code
  /// is needed for a call to connect, the number is not considered possible
  /// without it.
  ///
  /// [number] the number that needs to be checked
  /// [type] the type we are interested in
  /// [isPossibleNumberForType] returns true if the number is possible for this particular type
  bool isPossibleNumberForType(PhoneNumber number, PhoneNumberType type) {
    ValidationResult result = isPossibleNumberForTypeWithReason(number, type);
    return result == ValidationResult.isPossible ||
        result == ValidationResult.isPossibleLocalOnly;
  }

  /// Helper method to check a number against possible lengths for this region,
  /// based on the metadata being passed in, and determine whether it matches, or
  /// is too short or too long.
  ValidationResult _testNumberLength(String number, PhoneMetadata metadata,
      [PhoneNumberType type = PhoneNumberType.unknown]) {
    PhoneNumberDesc descForType = _getNumberDescByType(metadata, type);

    // There should always be 'possibleLengths' set for every element. This is
    // declared in the XML
    // schema which is verified by PhoneNumberMetadataSchemaTest.
    // For size efficiency, where a sub-description (e.g. fixed-line) has the same
    // possibleLengths
    // as the parent, this is missing, so we fall back to the general desc (where no
    // numbers of the
    // type exist at all, there is one possible length (-1) which is guaranteed not
    // to match the
    // length of any real phone number).
    List<int> possibleLengths = descForType.possibleLength.isEmpty
        ? metadata.generalDesc.possibleLength
        : descForType.possibleLength;

    List<int> localLengths = descForType.possibleLengthLocalOnly;

    if (type == PhoneNumberType.fixedLineOrMobile) {
      if (!_descHasPossibleNumberData(
          _getNumberDescByType(metadata, PhoneNumberType.fixedLine))) {
        // The rare case has been encountered where no fixedLine data is available (true
        // for some
        // non-geographical entities), so we just check mobile.
        return _testNumberLength(number, metadata, PhoneNumberType.mobile);
      } else {
        PhoneNumberDesc mobileDesc =
            _getNumberDescByType(metadata, PhoneNumberType.mobile);
        if (_descHasPossibleNumberData(mobileDesc)) {
          // Merge the mobile data in if there was any. We have to make a copy to do this.
          possibleLengths = List.from(possibleLengths);
          // Note that when adding the possible lengths from mobile, we have to again
          // check they
          // aren't empty since if they are this indicates they are the same as the
          // general desc and
          // should be obtained from there.
          possibleLengths.addAll(mobileDesc.possibleLength.isEmpty
              ? metadata.generalDesc.possibleLength
              : mobileDesc.possibleLength);
          // The current list is sorted; we need to merge in the new list and re-sort
          // (duplicates
          // are okay). Sorting isn't so expensive because the lists are very small.
          possibleLengths.sort();

          if (localLengths.isEmpty) {
            localLengths = mobileDesc.possibleLengthLocalOnly;
          } else {
            localLengths = List.from(localLengths);
            localLengths.addAll(mobileDesc.possibleLengthLocalOnly);
            localLengths.sort();
          }
        }
      }
    }

    // If the type is not supported at all (indicated by the possible lengths
    // containing -1 at this
    // point) we return invalid length.
    if (possibleLengths.first == -1) {
      return ValidationResult.invalidLength;
    }

    int actualLength = number.length;
    // This is safe because there is never an overlap beween the possible lengths
    // and the local-only
    // lengths; this is checked at build time.
    if (localLengths.contains(actualLength)) {
      return ValidationResult.isPossibleLocalOnly;
    }

    int minimumLength = possibleLengths.first;
    if (minimumLength == actualLength) {
      return ValidationResult.isPossible;
    } else if (minimumLength > actualLength) {
      return ValidationResult.tooShort;
    } else if (possibleLengths[possibleLengths.length - 1] < actualLength) {
      return ValidationResult.tooLong;
    }
    // We skip the first element; we've already checked it.
    return possibleLengths
            .sublist(1, possibleLengths.length)
            .contains(actualLength)
        ? ValidationResult.isPossible
        : ValidationResult.invalidLength;
  }

  /// Check whether a phone number is a possible number. It provides a more lenient
  /// check than [isValidNumber] in the following sense:
  ///
  /// <li>It only checks the length of phone numbers. In particular, it doesn't
  /// check starting digits of the number.
  /// <li>It doesn't attempt to figure out the type of the number, but uses general
  /// rules which applies to all types of phone numbers in a region. Therefore, it
  /// is much faster than isValidNumber.
  /// <li>For some numbers (particularly fixed-line), many regions have the concept
  /// of area code, which together with subscriber number constitute the national
  /// significant number.  It is sometimes okay to dial only the subscriber number
  /// when dialing in the same area. This function will return
  /// [isPossibleLocalOnly] if the subscriber-number-only version is passed in. On
  /// the other hand, because isValidNumber validates using information on both
  /// starting digits (for fixed line numbers, that would most likely be area
  /// codes) and length (obviously includes the length of area codes for fixed line
  /// numbers), it will return false for the subscriber-number-only version.
  /// [number] the number that needs to be checked
  /// [isPossibleNumberWithReason] returns a ValidationResult object which indicates
  ///  whether the number is possible
  ValidationResult isPossibleNumberWithReason(PhoneNumber number) {
    return isPossibleNumberForTypeWithReason(number, PhoneNumberType.unknown);
  }

  /// Check whether a phone number is a possible number. It provides a more lenient
  /// check than  [isValidNumber] in the following sense:
  ///
  /// <li>It only checks the length of phone numbers. In particular, it doesn't
  /// check starting digits of the number.
  /// <li>For some numbers (particularly fixed-line), many regions have the concept
  /// of area code, which together with subscriber number constitute the national
  /// significant number.  It is sometimes okay to dial only the subscriber number
  /// when dialing in the same area. This function will return
  /// [isPossibleLocalOnly] if the subscriber-number-only version is passed in. On
  /// the other hand, because isValidNumber validates using information on both
  /// starting digits (for fixed line numbers, that would most likely be area
  /// codes) and length (obviously includes the length of area codes for fixed line
  /// numbers), it will return false for the subscriber-number-only version.
  ///
  /// [number] the number that needs to be checked
  /// [type] the type we are interested in
  /// [isPossibleNumberForTypeWithReason] returns a ValidationResult object
  /// which indicates whether the number is possible
  ValidationResult isPossibleNumberForTypeWithReason(
      PhoneNumber number, PhoneNumberType type) {
    String nationalNumber = getNationalSignificantNumber(number);
    int countryCode = number.countryCode;

    // Note: For regions that share a country calling code, like NANPA numbers,
    // we just use the rules from the default region (US in this case) since the
    // getRegionCodeForNumber will not work if the number is possible but not
    // valid. There is in fact one country calling code (290) where the possible
    // number pattern differs between various regions (Saint Helena and Tristan
    // da Cunha), but this is handled by putting all possible lengths for any
    // country with this country calling code in the metadata for the default
    // region in this case.
    if (!_hasValidCountryCallingCode(countryCode)) {
      return ValidationResult.invalidCountryCode;
    }

    String regionCode = getRegionCodeForCountryCode(countryCode);
    // Metadata cannot be null because the country calling code is valid.
    PhoneMetadata metadata =
        _getMetadataForRegionOrCallingCode(countryCode, regionCode)!;
    return _testNumberLength(nationalNumber, metadata, type);
  }

  /// Check whether a phone number is a possible number given a number in the form
  /// of a string, and the region where the number could be dialed from. It
  /// provides a more lenient check than [isValidNumber]. See
  /// [isPossibleNumber] for details.
  ///
  /// <p>This method first parses the number, then invokes
  /// [isPossibleNumber] with the resultant PhoneNumber object.
  ///
  /// [number] the number that needs to be checked, in the form of a string.
  /// [regionDialingFrom] the region that we are expecting the number to be dialed from.
  /// Note this is different from the region where the number belongs.
  /// For example, the number +1 650 253 0000 is a number that belongs to US.
  /// When written in this form, it can be dialed from any region. When it is
  /// written as 00 1 650 253 0000, it can be dialed from any region which uses
  /// an international dialling prefix of 00. When it is written as
  /// 650 253 0000, it can only be dialed from within the US, and when written
  /// as 253 0000, it can only be dialed from within a smaller area in the US
  /// (Mountain View, CA, to be more specific).
  /// returns true if the number is possible.
  bool isPossibleNumberString(String number, String regionDialingFrom) {
    try {
      return isPossibleNumber(parse(number, regionDialingFrom));
    } catch (e) {
      return false;
    }
  }

  /// Attempts to extract a valid number from a phone number that is too long to be
  /// valid, and resets the PhoneNumber object passed in to that valid version. If
  /// no valid number could be extracted, the PhoneNumber object passed in will not
  /// be modified.
  /// [number] a PhoneNumber object which contains a number that is too long to be valid.
  /// [truncateTooLongNumber] returns true if a valid phone number can be successfully extracted.
  bool truncateTooLongNumber(PhoneNumber number) {
    if (isValidNumber(number)) return true;

    PhoneNumber numberCopy = number.deepCopy();
    int nationalNumber = number.nationalNumber.toInt();

    do {
      nationalNumber = (nationalNumber / 10).floor();
      numberCopy.nationalNumber = Int64(nationalNumber);
      if (nationalNumber == 0 ||
          isPossibleNumberWithReason(numberCopy) == ValidationResult.tooShort) {
        return false;
      }
    } while (!isValidNumber(numberCopy));

    number.nationalNumber = Int64(nationalNumber);

    return true;
  }

  /// Extracts country calling code from fullNumber, returns it and places the
  /// remaining number in nationalNumber. It assumes that the leading plus sign or
  /// IDD has already been removed. Returns 0 if fullNumber doesn't start with a
  /// valid country calling code, and leaves nationalNumber unmodified.
  int extractCountryCode(StringBuffer fullNumber, StringBuffer nationalNumber) {
    if ((fullNumber.length == 0) || (fullNumber.toString()[0] == '0')) {
      // Country codes do not begin with a '0'.
      return 0;
    }
    int potentialCountryCode;
    int numberLength = fullNumber.length;

    for (int i = 1; i <= maxLengthCountryCode && i <= numberLength; i++) {
      potentialCountryCode =
          int.parse(fullNumber.toString().substring(0, i), radix: 10);
      if (_metadataMapLoader.countryCodeToRegionCodeMap
          .containsKey('$potentialCountryCode')) {
        nationalNumber.write(fullNumber.toString().substring(i));
        return potentialCountryCode;
      }
    }
    return 0;
  }

  /// Tries to extract a country calling code from a number. This method will
  /// return zero if no country calling code is considered to be present. Country
  /// calling codes are extracted in the following ways:
  /// <ul>
  /// <li>by stripping the international dialing prefix of the region the person is
  /// dialing from, if this is present in the number, and looking at the next
  /// digits
  /// <li>by stripping the '+' sign if present and then looking at the next digits
  /// <li>by comparing the start of the number and the country calling code of the
  /// default region. If the number is not considered possible for the numbering
  /// plan of the default region initially, but starts with the country calling
  /// code of this region, validation will be reattempted after stripping this
  /// country calling code. If this number is considered a possible number, then
  /// the first digits will be considered the country calling code and removed as
  /// such.
  /// </ul>
  ///
  /// It will throw a Error if the number starts with a '+' but
  /// the country calling code supplied after this does not match that of any known
  /// region.
  ///
  /// [number] non-normalized telephone number that we wish to
  /// extract a country calling code from - may begin with '+'.
  /// [defaultRegionMetadata] metadata about the region this number may be from.
  /// [nationalNumber] a string buffer to store the national significant number in,
  /// in the case that a country calling code was extracted. The number is appended
  /// to any existing contents. If no country calling code was extracted, this will
  /// be left unchanged. [keepRawInput] true if the country_code_source and preferredCarrierCode
  /// fields of phoneNumber should be populated. [phoneNumber] the PhoneNumber object
  /// where the country_code and country_code_source need to be populated.
  /// Note the country_code is always populated, whereas country_code_source is
  /// only populated when keepCountryCodeSource is true.
  /// [maybeExtractCountryCode] returns the country calling code extracted or 0 if
  /// none could be extracted. Throws [NumberParseException].
  int maybeExtractCountryCode(
    String number,
    PhoneMetadata? defaultRegionMetadata,
    StringBuffer nationalNumber,
    bool keepRawInput,
    PhoneNumber phoneNumber,
  ) {
    if (number.isEmpty) return 0;

    StringBuffer fullNumber = StringBuffer(number);

    // Set the default prefix to be something that will never match.
    String possibleCountryIddPrefix = 'NonMatch';
    if (defaultRegionMetadata != null) {
      possibleCountryIddPrefix = defaultRegionMetadata.internationalPrefix;
    }

    PhoneNumber_CountryCodeSource countryCodeSource =
        maybeStripInternationalPrefixAndNormalize(
            fullNumber, possibleCountryIddPrefix);

    if (keepRawInput) {
      phoneNumber.countryCodeSource = countryCodeSource;
    }
    if (countryCodeSource !=
        PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY) {
      if (fullNumber.length <= _minLengthForNsn) {
        throw NumberParseException(ErrorType.tooShortAfterIdd);
      }

      int potentialCountryCode = extractCountryCode(fullNumber, nationalNumber);
      if (potentialCountryCode != 0) {
        phoneNumber.countryCode = potentialCountryCode;
        return potentialCountryCode;
      }

      // If this fails, they must be using a strange country calling code that we
      // don't recognize, or that doesn't exist.
      throw NumberParseException(ErrorType.invalidCountryCode);
    } else if (defaultRegionMetadata != null) {
      // Check to see if the number starts with the country calling code for the
      // default region. If so, we remove the country calling code, and do some
      // checks on the validity of the number before and after.
      int defaultCountryCode = defaultRegionMetadata.countryCode;

      String defaultCountryCodeString = '$defaultCountryCode';
      String normalizedNumber = fullNumber.toString();

      if (normalizedNumber.startsWith(defaultCountryCodeString)) {
        StringBuffer potentialNationalNumber = StringBuffer(
          normalizedNumber.substring(defaultCountryCodeString.length),
        );

        PhoneNumberDesc generalDesc = defaultRegionMetadata.generalDesc;

        // Passing null since we don't need the carrier code.
        maybeStripNationalPrefixAndCarrierCode(
          potentialNationalNumber,
          defaultRegionMetadata,
          null,
        );

        // If the number was not valid before but is valid now, or if it was too
        // long before, we consider the number with the country calling code
        // stripped to be a better result and keep that instead.
        if ((!matchNationalNumber(fullNumber.toString(), generalDesc, false) &&
                matchNationalNumber(
                    potentialNationalNumber.toString(), generalDesc, false)) ||
            _testNumberLength(fullNumber.toString(), defaultRegionMetadata) ==
                ValidationResult.tooLong) {
          nationalNumber.write(potentialNationalNumber);
          if (keepRawInput) {
            phoneNumber.countryCodeSource =
                (PhoneNumber_CountryCodeSource.FROM_NUMBER_WITHOUT_PLUS_SIGN);
          }
          phoneNumber.countryCode = defaultCountryCode;
          return defaultCountryCode;
        }
      }
    }
    // No country calling code present.
    phoneNumber.countryCode = 0;
    return 0;
  }

  /// Strips the IDD from the start of the number if present. Helper function used
  /// by maybeStripInternationalPrefixAndNormalize.
  ///
  /// [iddPattern] the regular expression for the international prefix.
  /// [number] the phone number that we wish to strip any international dialing prefix from.
  /// returns true if an international prefix was present.
  ///
  bool _parsePrefixAsIdd(RegExp iddPattern, StringBuffer number) {
    Match? m = iddPattern.matchAsPrefix(number.toString());
    if (m != null) {
      int matchEnd = m.end;
      // Only strip this if the first digit after the match is not a 0, since country
      // calling codes
      // cannot begin with 0.
      RegExpMatch? digitMatcher = capturingDigitPattern
          .firstMatch(number.toString().substring(matchEnd));
      if (digitMatcher != null) {
        String normalizedGroup = normalizeDigitsOnly(digitMatcher.group(1)!);
        if (normalizedGroup == '0') return false;
      }
      final remainingNumber = number.toString().replaceRange(0, matchEnd, '');
      number.clear();
      number.write(remainingNumber);
      return true;
    }
    return false;
  }

  /// Strips any international prefix (such as +, 00, 011) present in the number
  /// provided, normalizes the resulting number, and indicates if an international
  /// prefix was present.
  ///
  /// [number] the non-normalized telephone number that we wish to strip any
  /// international dialing prefix from. [possibleIddPrefix] the international direct
  /// dialing prefix from the region we think this number may be dialed in.
  /// returns [PhoneNumber_CountryCodeSource] of the corresponding CountryCodeSource
  /// if an international dialing prefix could be removed from the number, otherwise
  /// `PhoneNumber_CountryCodeSource.fromDefaultCountry` if the number did not seem to
  /// be in international format.
  PhoneNumber_CountryCodeSource maybeStripInternationalPrefixAndNormalize(
    StringBuffer number,
    String possibleIddPrefix,
  ) {
    if (number.toString().isEmpty) {
      return PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY;
    }

    // Check to see if the number begins with one or more plus signs.
    Match? m = _leadingPlusCharsPattern.matchAsPrefix(number.toString());
    if (m != null) {
      final remainingNumber = number.toString().replaceRange(0, m.end, '');
      number.clear();
      number.write(remainingNumber);
      // Can now normalize the rest of the number since we've consumed the '+' sign at
      // the start.
      normalize(number);
      return PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN;
    }

    // Attempt to parse the first digits as an international prefix.
    RegExp iddPattern = RegExp(possibleIddPrefix);
    normalize(number);

    return _parsePrefixAsIdd(iddPattern, number)
        ? PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_IDD
        : PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY;
  }

  /// Strips any national prefix (such as 0, 1) present in the number provided.
  ///
  /// [number] the normalized telephone number that we wish to strip any
  /// national dialing prefix from. [metadata] the metadata for the region
  /// that we think this number is from. [carrierCode] a place to insert the carrier
  /// code if one is extracted. eturns true if a national prefix or
  /// carrier code (or both) could be extracted.
  bool maybeStripNationalPrefixAndCarrierCode(
    StringBuffer number,
    PhoneMetadata metadata,
    StringBuffer? carrierCode,
  ) {
    String possibleNationalPrefix = metadata.nationalPrefixForParsing;
    if (number.length == 0 || possibleNationalPrefix.isEmpty) {
      // Early return for numbers of zero length.
      return false;
    }

    // Attempt to parse the first digits as a national prefix.
    Match? prefixMatcher =
        RegExp(possibleNationalPrefix).matchAsPrefix(number.toString());
    if (prefixMatcher != null) {
      // Check if the original number is viable.
      PhoneNumberDesc generalDesc = metadata.generalDesc;
      bool isViableOriginalNumber =
          matchNationalNumber(number.toString(), generalDesc, false);

      // prefixMatcher.group(numOfGroups) == null implies nothing was captured by the
      // capturing
      // groups in possibleNationalPrefix; therefore, no transformation is necessary,
      // and we just
      // remove the national prefix.
      int numOfGroups = prefixMatcher.groupCount;
      String transformRule = metadata.nationalPrefixTransformRule;

      if (transformRule.isEmpty || prefixMatcher.group(numOfGroups) == null) {
        // If the original number was viable, and the resultant number is not, we
        // return.
        if (isViableOriginalNumber &&
            !matchNationalNumber(number.toString().substring(prefixMatcher.end),
                generalDesc, false)) {
          return false;
        }
        if (carrierCode != null &&
            numOfGroups > 0 &&
            prefixMatcher.group(numOfGroups) != null) {
          carrierCode.write(prefixMatcher.group(1));
        }
        String remainingNumber =
            number.toString().replaceRange(0, prefixMatcher.end, '');
        number.clear();
        number.write(remainingNumber);
        return true;
      } else {
        // Check that the resultant number is still viable. If not, return. Check this
        // by copying
        // the string buffer and making the transformation on the copy first.
        StringBuffer transformedNumber = StringBuffer(number.toString());
        String replacedFirstNumber = replaceFirstAndFormat(
            number.toString(), prefixMatcher.pattern, transformRule);
        transformedNumber.clear();
        transformedNumber.write(replacedFirstNumber);

        if (isViableOriginalNumber &&
            !matchNationalNumber(
                transformedNumber.toString(), generalDesc, false)) {
          return false;
        }
        if (carrierCode != null && numOfGroups > 1) {
          carrierCode.write(prefixMatcher.group(1));
        }
        String remainingNumber = number
            .toString()
            .replaceRange(0, number.length, transformedNumber.toString());
        number.clear();
        number.write(remainingNumber);

        return true;
      }
    }
    return false;
  }

  /// Strips any extension (as in, the part of the number dialled after the call is
  /// connected, usually indicated with extn, ext, x or similar) from the end of
  /// the number, and returns it.
  ///
  /// [number] the non-normalized telephone number that we wish to strip the extension from.
  /// returns the phone extension.
  String maybeStripExtension(StringBuffer number) {
    RegExpMatch? m = _extnPattern.firstMatch(number.toString());
    // If we find a potential extension, and the number preceding this is a viable
    // number, we assume it is an extension.
    if (m != null &&
        isViablePhoneNumber(number.toString().substring(0, m.start))) {
      // The numbers are captured into groups in the regular expression.
      for (int i = 1, length = m.groupCount; i <= length; i++) {
        if (m.group(i) != null) {
          // We go through the capturing groups until we find one that captured some
          // digits. If none
          // did, then we will return the empty string.
          String extension = m.group(i)!;
          String remainder =
              number.toString().replaceRange(m.start, number.length, '');
          number.clear();
          number.write(remainder);
          return extension;
        }
      }
    }
    return '';
  }

  /// Checks to see that the region code used is valid, or if it is not valid, that
  /// the number to parse starts with a + symbol so that we can attempt to infer
  /// the region from the number.
  /// [numberToParse] number that we are attempting to parse.
  /// [defaultRegion] region that we are expecting the number to be from.
  /// returns false if it cannot use the region provided and the region cannot be inferred.
  bool _checkRegionForParsing(String numberToParse, String? defaultRegion) {
    // If the number is null or empty, we can't infer the region.
    return _isValidRegionCode(defaultRegion) ||
        (numberToParse.isNotEmpty &&
            numberToParse.isNotEmpty &&
            _leadingPlusCharsPattern.matchAsPrefix(numberToParse) != null);
  }

  /// Parses a string and returns it as a phone number in proto buffer format. The
  /// method is quite lenient and looks for a number in the input text (raw input)
  /// and does not check whether the string is definitely only a phone number. To
  /// do this, it ignores punctuation and white-space, as well as any text before
  /// the number (e.g. a leading 'Tel: ') and trims the non-number bits. It will
  /// accept a number in any format (E164, national, international etc), assuming
  /// it can be interpreted with the defaultRegion supplied. It also attempts to
  /// convert any alpha characters into digits if it thinks this is a vanity number
  /// of the type '1800 MICROSOFT'.
  ///
  /// Note this method canonicalizes the phone number such that different
  /// representations can be easily compared, no matter what form it was originally
  /// entered in (e.g. national, international). If you want to record context
  /// about the number being parsed, such as the raw input that was entered, how
  /// the country code was derived etc. then call [parseAndKeepRawInput()] instead.
  ///
  /// This method will throw a `phonenumbers.Error` if the number is not
  /// considered to be a possible number. Note that validation of whether the
  /// number is actually a valid number for a particular region is not performed.
  /// This can be done separately with [isValidNumber].
  ///
  /// [numberToParse] number that we are attempting to parse. This
  ///     can contain formatting such as +, ( and -, as well as a phone number
  ///     extension. It can also be provided in RFC3966 format.
  /// [defaultRegion] region that we are expecting the number to be
  ///     from. This is only used if the number being parsed is not written in
  ///     international format. The `countryCode` for the number in this case would
  ///     be stored as that of the default region supplied. If the number is
  ///     guaranteed to start with a '+' followed by the country calling code, then
  ///     'ZZ' or null can be supplied.
  /// returns [PhoneNumber] a phone number proto buffer filled with the parsed number.
  /// Throws [NumberParseException] if the string is not considered to be a viable phone number
  /// (e.g. too few or too many digits) or if no default region was supplied and the
  /// number is not in international format (does not start with +).
  PhoneNumber parse(String? numberToParse, String? defaultRegion) {
    return _parseHelper(numberToParse, defaultRegion, false, true);
  }

  /// Parses a string and returns it in proto buffer format. This method is the
  /// same as the public [parse] method, with the exception that it allows
  /// the default region to be null, for use by [isNumberMatch].
  ///
  /// Note if any new field is added to this method that should always be filled
  /// in, even when keepRawInput is false, it should also be handled in the
  /// copyCoreFieldsOnly method.
  ///
  /// [numberToParse] number that we are attempting to parse. This
  /// can contain formatting such as +, ( and -, as well as a phone number
  /// extension.
  /// [defaultRegion] region that we are expecting the number to be
  /// from. This is only used if the number being parsed is not written in
  /// international format. The country calling code for the number in this
  /// case would be stored as that of the default region supplied.
  /// [keepRawInput] whether to populate the raw_input field of the
  /// phoneNumber with numberToParse.
  /// [checkRegion] should be set to false if it is permitted for
  /// the default coregion to be null or unknown ('ZZ').
  /// returns [PhoneNumber] a phone number proto buffer filled with the parsed number.
  /// Throws [NumberParseException].
  PhoneNumber _parseHelper(
    String? numberToParse,
    String? defaultRegion,
    bool keepRawInput,
    bool checkRegion,
  ) {
    if (numberToParse == null) {
      throw NumberParseException(ErrorType.notANumber);
    } else if (numberToParse.length > _maxInputStringLength) {
      throw NumberParseException(ErrorType.tooLong);
    }

    StringBuffer nationalNumber = StringBuffer();
    _buildNationalNumberForParsing(numberToParse, nationalNumber);

    if (!isViablePhoneNumber(nationalNumber.toString())) {
      throw NumberParseException(ErrorType.notANumber);
    }

    // Check the region supplied is valid, or that the extracted number starts
    // with some sort of + sign so the number's region can be determined.
    if (checkRegion &&
        !_checkRegionForParsing(nationalNumber.toString(), defaultRegion)) {
      throw NumberParseException(ErrorType.invalidCountryCode);
    }

    PhoneNumber phoneNumber = PhoneNumber();
    if (keepRawInput) {
      phoneNumber.rawInput = numberToParse;
    }

    // Attempt to parse extension first, since it doesn't require region-specific
    // data and we want to have the non-normalised number here.
    String extension = maybeStripExtension(nationalNumber);
    if (extension.isNotEmpty) {
      phoneNumber.extension_3 = extension;
    }

    PhoneMetadata? regionMetadata =
        getMetadataForRegion(regionCode: defaultRegion);

    // Check to see if the number is given in international format so we know
    // whether this number is from the default region or not.
    StringBuffer normalizedNationalNumber = StringBuffer();

    int countryCode = 0;
    String nationalNumberStr = nationalNumber.toString();

    try {
      countryCode = maybeExtractCountryCode(
        nationalNumberStr,
        regionMetadata,
        normalizedNationalNumber,
        keepRawInput,
        phoneNumber,
      );
    } on NumberParseException catch (e) {
      if (e.errorType == ErrorType.invalidCountryCode &&
          _leadingPlusCharsPattern.matchAsPrefix(nationalNumberStr) != null) {
        // Strip the plus-char, and try again.
        nationalNumberStr =
            nationalNumberStr.replaceFirst(_leadingPlusCharsPattern, '');

        countryCode = maybeExtractCountryCode(
          nationalNumberStr,
          regionMetadata,
          normalizedNationalNumber,
          keepRawInput,
          phoneNumber,
        );

        if (countryCode == 0) rethrow;
      } else {
        rethrow;
      }
    }
    if (countryCode != 0) {
      String phoneNumberRegion = getRegionCodeForCountryCode(countryCode);
      if (phoneNumberRegion != defaultRegion) {
        // Metadata cannot be null because the country calling code is valid.
        regionMetadata =
            _getMetadataForRegionOrCallingCode(countryCode, phoneNumberRegion);
      }
    } else {
      // If no extracted country calling code, use the region supplied instead.
      // The national number is just the normalized version of the number we were
      // given to parse.
      normalizedNationalNumber.write(normalize(nationalNumber));
      if (defaultRegion != null) {
        countryCode = regionMetadata!.countryCode;
        phoneNumber.countryCode = countryCode;
      } else if (keepRawInput) {
        phoneNumber.clearCountryCodeSource();
      }
    }

    if (normalizedNationalNumber.length < _minLengthForNsn) {
      throw NumberParseException(ErrorType.tooShortNsn);
    }

    if (regionMetadata != null) {
      StringBuffer carrierCode = StringBuffer();
      StringBuffer potentialNationalNumber =
          StringBuffer(normalizedNationalNumber.toString());
      maybeStripNationalPrefixAndCarrierCode(
          potentialNationalNumber, regionMetadata, carrierCode);

      // We require that the NSN remaining after stripping the national prefix and
      // carrier code be long enough to be a possible length for the region.
      // Otherwise, we don't do the stripping, since the original number could be
      // a valid short number.
      var validationResult =
          _testNumberLength(potentialNationalNumber.toString(), regionMetadata);

      if (validationResult != ValidationResult.tooShort &&
          validationResult != ValidationResult.isPossibleLocalOnly &&
          validationResult != ValidationResult.invalidLength) {
        normalizedNationalNumber = potentialNationalNumber;
        if (keepRawInput && carrierCode.toString().isNotEmpty) {
          phoneNumber.preferredDomesticCarrierCode = carrierCode.toString();
        }
      }
    }

    int lengthOfNationalNumber = normalizedNationalNumber.toString().length;
    if (lengthOfNationalNumber < _minLengthForNsn) {
      throw NumberParseException(ErrorType.tooShortNsn);
    }
    if (lengthOfNationalNumber > maxLengthForNsn) {
      throw NumberParseException(ErrorType.tooLong);
    }

    _setItalianLeadingZerosForPhoneNumber(
        normalizedNationalNumber.toString(), phoneNumber);
    phoneNumber.nationalNumber =
        Int64.parseInt(normalizedNationalNumber.toString());
    return phoneNumber;
  }

  /// Parses a string and returns it in proto buffer format. This method differs
  /// from [parse] in that it always populates the rawInput field of the
  /// protocol buffer with numberToParse as well as the countryCodeSource field.
  ///
  /// [numberToParse] number that we are attempting to parse. This
  ///     can contain formatting such as +, ( and -, as well as a phone number
  ///     extension.
  /// [defaultRegion] region that we are expecting the number to be
  ///     from. This is only used if the number being parsed is not written in
  ///     international format. The country calling code for the number in this
  ///     case would be stored as that of the default region supplied.
  /// return [PhoneNumber] a phone number proto buffer filled with the parsed number.
  /// throws [NumberParseException] if the string is not considered to be a
  ///     viable phone number or if no default region was supplied.
  PhoneNumber parseAndKeepRawInput(
      String numberToParse, String? defaultRegion) {
    if (!_isValidRegionCode(defaultRegion)) {
      if (numberToParse.isNotEmpty && numberToParse[0] != plusSign) {
        throw NumberParseException(ErrorType.invalidCountryCode);
      }
    }
    return _parseHelper(numberToParse, defaultRegion, true, true);
  }

  /// A helper function to set the values related to leading zeros in a
  /// PhoneNumber.
  ///
  /// [nationalNumber] the number we are parsing.
  /// [PhoneNumber] phoneNumber a phone number proto buffer to fill in.
  void _setItalianLeadingZerosForPhoneNumber(
      String nationalNumber, PhoneNumber phoneNumber) {
    if (nationalNumber.length > 1 && nationalNumber[0] == '0') {
      phoneNumber.italianLeadingZero = true;
      int numberOfLeadingZeros = 1;
      // Note that if the national number is all '0's, the last '0' is not counted
      // as a leading zero.
      while (numberOfLeadingZeros < nationalNumber.length - 1 &&
          nationalNumber[numberOfLeadingZeros] == '0') {
        numberOfLeadingZeros++;
      }
      if (numberOfLeadingZeros != 1) {
        phoneNumber.numberOfLeadingZeros = numberOfLeadingZeros;
      }
    }
  }

  /// Extracts the value of the phone-context parameter of numberToExtractFrom,
  /// following the syntax defined in RFC3966.
  /// returns the extracted string (possibly empty), or null if no
  /// phone-context parameter is found.
  String? _extractPhoneContext(String? numberToExtractFrom) {
    int? indexOfPhoneContext =
        numberToExtractFrom?.indexOf(_rfc3966PhoneContext);
    // If no phone-context parameter is present
    if (indexOfPhoneContext == -1) return null;

    int phoneContextStart = indexOfPhoneContext! + _rfc3966PhoneContext.length;
    // If phone-context parameter is empty
    if (phoneContextStart >= (numberToExtractFrom?.length ?? 0)) return '';

    int? phoneContextEnd = numberToExtractFrom?.indexOf(';', phoneContextStart);
    // If phone-context is not the last parameter
    if (phoneContextEnd != -1) {
      return numberToExtractFrom?.substring(phoneContextStart, phoneContextEnd);
    } else {
      return numberToExtractFrom?.substring(phoneContextStart);
    }
  }

  /// Returns whether the value of phoneContext follows the syntax defined in RFC3966.
  bool _isPhoneContextValid(String? phoneContext) {
    if (phoneContext == null) return true;
    if (phoneContext.isEmpty) return false;

    bool globalNumberDigitsMatcher =
        _rfc3966GlobalNumberDigitsPattern.hasMatch(phoneContext);
    bool domainnameMatcher = _rfc3966DomainnamePattern.hasMatch(phoneContext);
    // Does phone-context value match pattern of global-number-digits or
    // domainname
    return globalNumberDigitsMatcher || domainnameMatcher;
  }

  /// Converts numberToParse to a form that we can parse and write it to
  /// nationalNumber if it is written in RFC3966; otherwise extract a possible
  /// number out of it and write to nationalNumber.
  ///
  /// [numberToParse] number that we are attempting to parse. This
  /// can contain formatting such as +, ( and -, as well as a phone number extension.
  /// [nationalNumber] a string buffer for storing the national significant number.
  /// Throws [NumberParseException]
  void _buildNationalNumberForParsing(
      String? numberToParse, StringBuffer nationalNumber) {
    String? phoneContext = _extractPhoneContext(numberToParse);

    if (!_isPhoneContextValid(phoneContext)) {
      throw NumberParseException(ErrorType.notANumber);
    }

    if (phoneContext != null) {
      // If the phone context contains a phone number prefix, we need to capture
      // it, whereas domains will be ignored.
      if (phoneContext[0] == plusSign) {
        nationalNumber.write(phoneContext);
      }

      // Now append everything between the 'tel:' prefix and the phone-context.
      // This should include the national number, an optional extension or
      // isdn-subaddress component. Note we also handle the case when 'tel:' is
      // missing, as we have seen in some of the phone number inputs.
      // In that case, we append everything from the beginning.
      int indexOfRfc3966Prefix = numberToParse?.indexOf(_rfc3966Prefix) ?? -1;
      int indexOfNationalNumber = (indexOfRfc3966Prefix >= 0)
          ? indexOfRfc3966Prefix + _rfc3966Prefix.length
          : 0;
      int? indexOfPhoneContext = numberToParse?.indexOf(_rfc3966PhoneContext);
      nationalNumber.write(
          numberToParse?.substring(indexOfNationalNumber, indexOfPhoneContext));
    } else {
      // Extract a possible number from the string passed in (this strips leading
      // characters that could not be the start of a phone number.)
      nationalNumber.write(extractPossibleNumber(numberToParse ?? ''));
    }

    // Delete the isdn-subaddress and everything after it if it is present.
    // Note extension won't appear at the same time with isdn-subaddress
    // according to paragraph 5.3 of the RFC3966 spec,
    String nationalNumberStr = nationalNumber.toString();
    int indexOfIsdn = nationalNumberStr.indexOf(_rfc3966IsdnSubaddress);
    if (indexOfIsdn > 0) {
      nationalNumber.clear();
      nationalNumber.write(nationalNumberStr.substring(0, indexOfIsdn));
    }
    // If both phone context and isdn-subaddress are absent but other
    // parameters are present, the parameters are left in nationalNumber. This
    // is because we are concerned about deleting content from a potential
    // number string when there is no strong evidence that the number is
    // actually written in RFC3966.
  }

  /// Returns a new phone number containing only the fields needed to uniquely
  /// identify a phone number, rather than any fields that capture the context in
  /// which the phone number was created.
  /// These fields correspond to those set in [parse()] rather than
  /// [parseAndKeepRawInput()].
  ///
  /// [numberIn] number that we want to copy fields from.
  /// returns [PhoneNumber] number with core fields only.
  PhoneNumber _copyCoreFieldsOnly(PhoneNumber numberIn) {
    PhoneNumber phoneNumber = PhoneNumber();
    phoneNumber.countryCode = numberIn.countryCode;
    phoneNumber.nationalNumber = numberIn.nationalNumber;
    if (numberIn.extension_3.isNotEmpty) {
      phoneNumber.extension_3 = (numberIn.extension_3);
    }
    if (numberIn.italianLeadingZero) {
      phoneNumber.italianLeadingZero = true;
      // This field is only relevant if there are leading zeros at all.
      phoneNumber.numberOfLeadingZeros = numberIn.numberOfLeadingZeros;
    }
    return phoneNumber;
  }

  /// Takes two phone numbers and compares them for equality.
  ///
  /// <p>Returns `exactMatch` if the `countryCode`, NSN, presence of a leading zero
  /// for Italian numbers and any extension present are the same. Returns `nsnMatch`
  /// if either or both has no region specified, and the NSNs and extensions are
  /// the same. Returns `shortNsnMatch` if either or both has no region specified,
  /// or the region specified is the same, and one NSN could be a shorter version
  /// of the other number. This includes the case where one has an extension
  /// specified, and the other does not. Returns `noMatch` otherwise. For example,
  /// the numbers +1 345 657 1234 and 657 1234 are a `shortNsnMatch`. The numbers
  /// +1 345 657 1234 and 345 657 are a `noMatch`.
  ///
  /// {PhoneNumber|string} [firstNumberIn] first number to compare. If it is a string
  /// it can contain formatting, and can have country calling code specified with + at the start.
  /// {PhoneNumber|string} [secondNumberIn] second number to compare. If it is a string
  /// it can contain formatting, and can have country calling code specified with + at the start.
  /// returns [MatchType] `notANumber`, `noMatch`, `shortNsnMatch`, `nsnMatch` or `exactMatch`
  /// depending on the level of equality of the two numbers, described in the method definition.
  MatchType isNumberMatch(Object firstNumberIn, Object secondNumberIn) {
    // If the input arguements are strings parse them to a proto buffer format.
    // Else make copies of the phone numbers so that the numbers passed in are not
    // edited.
    PhoneNumber firstNumber;

    PhoneNumber secondNumber;
    if (firstNumberIn is String) {
      // First see if the first number has an implicit country calling code, by
      // attempting to parse it.
      try {
        firstNumber = parse(firstNumberIn, _unknownRegion);
      } on NumberParseException catch (e) {
        if (e.errorType != ErrorType.invalidCountryCode) {
          return MatchType.notANumber;
        }
        // The first number has no country calling code. exactMatch is no longer
        // possible. We parse it as if the region was the same as that for the
        // second number, and if exactMatch is returned, we replace this with
        // nsnMatch.
        if (secondNumberIn is PhoneNumber) {
          String secondNumberRegion =
              getRegionCodeForCountryCode(secondNumberIn.countryCode);
          if (secondNumberRegion != _unknownRegion) {
            try {
              firstNumber = parse(firstNumberIn, secondNumberRegion);
            } catch (e2) {
              return MatchType.notANumber;
            }

            MatchType match = isNumberMatch(firstNumber, secondNumberIn);
            if (match == MatchType.exactMatch) {
              return MatchType.nsnMatch;
            }
            return match;
          }
        }
        // If the second number is a string or doesn't have a valid country
        // calling code, we parse the first number without country calling code.
        try {
          firstNumber = _parseHelper(firstNumberIn, null, false, false);
        } catch (e2) {
          return MatchType.notANumber;
        }
      }
    } else {
      firstNumber = (firstNumberIn as PhoneNumber).deepCopy();
    }

    if (secondNumberIn is String) {
      try {
        secondNumber = parse(secondNumberIn, _unknownRegion);
        return isNumberMatch(firstNumberIn, secondNumber);
      } on NumberParseException catch (e) {
        if (e.errorType != ErrorType.invalidCountryCode) {
          return MatchType.notANumber;
        }
        return isNumberMatch(secondNumberIn, firstNumber);
      }
    } else {
      secondNumber = (secondNumberIn as PhoneNumber).deepCopy();
    }

    PhoneNumber firstNumberToCompare = _copyCoreFieldsOnly(firstNumber);
    PhoneNumber secondNumberToCompare = _copyCoreFieldsOnly(secondNumber);

    // Early exit if both had extensions and these are different.
    if (firstNumberToCompare.hasExtension_3() &&
        secondNumberToCompare.hasExtension_3() &&
        firstNumberToCompare.extension_3 != secondNumberToCompare.extension_3) {
      return MatchType.noMatch;
    }

    int firstNumberCountryCode = firstNumberToCompare.countryCode;

    int secondNumberCountryCode = secondNumberToCompare.countryCode;
    // Both had country_code specified.
    if (firstNumberCountryCode != 0 && secondNumberCountryCode != 0) {
      if (firstNumberToCompare == secondNumberToCompare) {
        return MatchType.exactMatch;
      } else if (firstNumberCountryCode == secondNumberCountryCode &&
          _isNationalNumberSuffixOfTheOther(
              firstNumberToCompare, secondNumberToCompare)) {
        // A SHORT_NSN_MATCH occurs if there is a difference because of the
        // presence or absence of an 'Italian leading zero', the presence or
        // absence of an extension, or one NSN being a shorter variant of the
        // other.
        return MatchType.shortNsnMatch;
      }
      // This is not a match.
      return MatchType.noMatch;
    }
    // Checks cases where one or both country_code fields were not specified. To
    // make equality checks easier, we first set the country_code fields to be
    // equal.
    firstNumberToCompare.countryCode = 0;
    secondNumberToCompare.countryCode = 0;
    // If all else was the same, then this is an NSN_MATCH.
    if (firstNumberToCompare == secondNumberToCompare) {
      return MatchType.nsnMatch;
    }
    if (_isNationalNumberSuffixOfTheOther(
        firstNumberToCompare, secondNumberToCompare)) {
      return MatchType.shortNsnMatch;
    }
    return MatchType.noMatch;
  }

  /// Returns true when one national number is the suffix of the other or both are the same.
  ///
  /// [firstNumber] the first PhoneNumber object.
  /// [secondNumber] the second PhoneNumber object.
  /// returns true if one PhoneNumber is the suffix of the other one.
  bool _isNationalNumberSuffixOfTheOther(
      PhoneNumber firstNumber, PhoneNumber secondNumber) {
    String firstNumberNationalNumber = '${firstNumber.nationalNumber}';
    String secondNumberNationalNumber = '${secondNumber.nationalNumber}';
    // Note that endsWith returns true if the numbers are equal.
    return firstNumberNationalNumber.endsWith(secondNumberNationalNumber) ||
        secondNumberNationalNumber.endsWith(firstNumberNationalNumber);
  }

  /// Returns true if the number can be dialled from outside the region, or
  /// unknown. If the number can only be dialled from within the region, returns
  /// false. Does not check the number is a valid number. Note that, at the
  /// moment, this method does not handle short numbers (which are currently
  /// all presumed to not be diallable from outside their country).
  ///
  /// [number] the phone-number for which we want to know whether it is
  /// diallable from outside the region. returns true if the number can only
  /// be dialled from within the country.
  bool canBeInternationallyDialled(PhoneNumber number) {
    String? regionCode = getRegionCodeForNumber(number);
    PhoneMetadata? metadata = getMetadataForRegion(regionCode: regionCode);
    if (metadata == null) {
      // Note numbers belonging to non-geographical entities (e.g. +800 numbers)
      // are always internationally diallable, and will be caught here.
      return true;
    }

    String nationalSignificantNumber = getNationalSignificantNumber(number);
    return !_isNumberMatchingDesc(
        nationalSignificantNumber, metadata.noInternationalDialling);
  }

  /// Check whether the entire input sequence can be
  /// matched against the regular expression.
  /// [regex] is the regular expression to match against.
  /// [str] is the string to test.
  /// returns true if str can be matched entirely against regex.
  bool matchesEntirely(Pattern regex, String str) {
    RegExp pattern = (regex is String) ? RegExp(regex) : regex as RegExp;
    Match? match = pattern.firstMatch(str);
    if (match == null) return false;
    return match.group(0) == str;
  }

  /// Returns whether the given national number (a string containing only decimal digits)
  /// matches the national number pattern defined in the given PhoneNumberDesc message.
  static bool matchNationalNumber(
      String number, PhoneNumberDesc numberDesc, bool allowPrefixMatch) {
    String nationalNumberPattern = numberDesc.nationalNumberPattern;
    // We don't want to consider it a prefix match when
    // matching non-empty input against an empty pattern.
    if (nationalNumberPattern.isEmpty) return false;

    RegExp pattern = RegExp(nationalNumberPattern);
    if (pattern.matchAsPrefix(number) == null) return false;

    pattern = RegExp("^($nationalNumberPattern)\$");
    return pattern.firstMatch(number)?.group(0) == number || allowPrefixMatch;
  }

  /// Returns true if the supplied region supports mobile number portability.
  /// Returns false for invalid, unknown or regions that don't support
  /// mobile number portability.
  ///
  /// [regionCode] the region for which we want to know whether it supports
  /// mobile number portability or not
  bool isMobileNumberPortableRegion(String? regionCode) {
    PhoneMetadata? metadata = getMetadataForRegion(regionCode: regionCode);
    if (metadata == null) {
      return false;
    }
    return metadata.mobileNumberPortableRegion;
  }

  /// Gets an invalid number for the specified region. This is useful for
  /// unit-testing purposes, where you want to test what will happen with an
  /// invalid number. Note that the number that is returned will always be able
  /// to be parsed and will have the correct country code. It may also
  /// be a valid *short* number/code for this region. Validity checking such
  /// numbers is handled with [ShortNumberInfo].
  ///
  /// [regionCode] the region for which an example number is needed
  /// returns an invalid number for the specified region. Returns null when an
  /// unsupported region or the region 001 (Earth) is passed in.
  PhoneNumber? getInvalidExampleNumber(String regionCode) {
    if (!_isValidRegionCode(regionCode)) {
      return null;
    }
    // We start off with a valid fixed-line number since every country supports
    // this. Alternatively
    // we could start with a different number type, since fixed-line numbers
    // typically have a wide
    // breadth of valid number lengths and we may have to make it very short before
    // we get an
    // invalid number.
    PhoneNumberDesc desc = _getNumberDescByType(
      getMetadataForRegion(regionCode: regionCode)!,
      PhoneNumberType.fixedLine,
    );
    if (!desc.hasExampleNumber()) {
      // This shouldn't happen; we have a test for this.
      return null;
    }

    String exampleNumber = desc.exampleNumber;
    // Try and make the number invalid. We do this by changing the length. We try
    // reducing the length of the number, since currently no region has a number that is the same
    // length as minLengthForNsn. This is probably quicker than making the number longer,
    // which is another alternative. We could also use the possible number pattern to extract the
    // possible lengths of the number to make this faster, but this method is only for unit-testing so
    // simplicity is preferred to performance. We don't want to return a number that can't be
    // parsed, so we check the number is long enough. We try all possible lengths because phone number
    // plans often have overlapping prefixes so the number 123456 might be valid as a fixed-line
    // number, and 12345 as a mobile number. It would be faster to loop in a different order, but we
    // prefer numbers that look closer to real numbers (and it gives us a variety of different lengths
    // for the resulting phone numbers - otherwise they would all be MIN_LENGTH_FOR_NSN digits long.)
    for (int phoneNumberLength = exampleNumber.length - 1;
        phoneNumberLength >= _minLengthForNsn;
        phoneNumberLength--) {
      String numberToTry = exampleNumber.substring(0, phoneNumberLength);
      try {
        PhoneNumber possiblyValidNumber = parse(numberToTry, regionCode);
        if (!isValidNumber(possiblyValidNumber)) {
          return possiblyValidNumber;
        }
      } catch (_) {
        // Shouldn't happen: we have already checked the length, we know example numbers
        // have
        // only valid digits, and we know the region code is fine.
      }
    }
    // We have a test to check that this doesn't happen for any of our supported
    // regions.
    return null;
  }

  /// Returns an iterable over all [PhoneNumberMatch] PhoneNumberMatches in [text].
  ///
  /// [text] the text to search for phone numbers, null for no text
  /// [defaultRegion] region that we are expecting the number to be from. This is only used if
  /// the number being parsed is not written in international format. The country_code for the
  /// number in this case would be stored as that of the default region supplied. May be null if
  /// only international numbers are expected.
  /// [leniency] the leniency to use when evaluating candidate phone numbers
  /// [maxTries] the maximum number of invalid numbers to try before giving up on the text.
  /// This is to cover degenerate cases where the text has a lot of false positives in it.
  /// Must be `(code >= 0)`.
  Iterable<PhoneNumberMatch> findNumbers(
    String text,
    String defaultRegion, [
    Leniency leniency = Leniency.valid,
    Int64 maxTries = Int64.MAX_VALUE,
  ]) {
    return PhoneNumberMatcher(this, text, defaultRegion, leniency, maxTries);
  }
}
