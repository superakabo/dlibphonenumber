// Based on the original Java code: .../phonenumbers/PhoneNumberMatcher.java
//
// Copyright (C) 2011 The Libphonenumber Authors
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

import 'phone_number_match.dart';
import 'enums/leniency.dart';
import 'enums/match_type.dart';
import 'enums/phone_number_format.dart';
import 'enums/phone_number_matcher_state.dart';
import 'exceptions/illegal_argument_exception.dart';
import 'generated/classes/phone_metadata/phonemetadata.pb.dart';
import 'generated/classes/phone_number/phonenumber.pb.dart';
import 'phone_number_util.dart';

/// A stateful class that finds and extracts telephone numbers from String [text].
/// Instances can be created using the [PhoneNumberUtil.findNumbers]
/// factory methods in [PhoneNumberUtil].
///
/// <p>Vanity numbers (phone numbers using alphabetic digits such as
/// `<tt>1-800-SIX-FLAGS</tt>` are not found.
final class PhoneNumberMatcher extends Iterable<PhoneNumberMatch> {
  final PhoneNumberUtil util;
  final String text;
  final String country;
  final Leniency leniency;
  final Int64 maxTries;

  const PhoneNumberMatcher(
    this.util,
    this.text,
    this.country,
    this.leniency,
    this.maxTries,
  ) : assert(maxTries >= 0, 'maxTries must be greater than or equal to 0');

  @override
  Iterator<PhoneNumberMatch> get iterator {
    return PhoneNumberMatcherImpl(util, text, country, leniency, maxTries);
  }
}

/// Small helper interface such that the number groups can be checked according to different
/// criteria, both for our default way of performing formatting and for any alternate formats we
/// may want to check.
///
/// Returns true if the groups of digits found in our candidate phone number match our
/// expectations.
///
/// [number] the original number we found when parsing
/// [normalizedCandidate] the candidate number, normalized to only contain ASCII digits,
/// but with non-digits (spaces etc) retained
/// [expectedNumberGroups] the groups of digits that we would expect to see if we
/// formatted this number
typedef NumberGroupingChecker = bool Function(
  PhoneNumberUtil util,
  PhoneNumber number,
  StringBuffer normalizedCandidate,
  List<String> expectedNumberGroups,
);

final class PhoneNumberMatcherImpl implements Iterator<PhoneNumberMatch> {
  PhoneNumberMatcherImpl(
    PhoneNumberUtil util,
    String text,
    String country,
    Leniency leniency,
    Int64 maxTries,
  )   : _phoneUtil = util,
        _text = text,
        _preferredRegion = country,
        _leniency = leniency,
        _maxTries = maxTries;

  @override
  PhoneNumberMatch get current {
    // Check the state and find the next match as a side-effect if necessary.
    if (!moveNext()) {
      throw Exception('No such element');
    }

    // Don't retain that memory any longer than necessary.
    PhoneNumberMatch result = _lastMatch!;
    _lastMatch = null;
    _state = PhoneNumberMatcherState.notReady;
    return result;
  }

  @override
  bool moveNext() {
    if (_state == PhoneNumberMatcherState.notReady) {
      _lastMatch = _find(_searchIndex);

      if (_lastMatch == null) {
        _state = PhoneNumberMatcherState.done;
      } else {
        _searchIndex = _lastMatch!.end;
        _state = PhoneNumberMatcherState.ready;
      }
    }

    return _state == PhoneNumberMatcherState.ready;
  }

  /// The phone number utility.
  final PhoneNumberUtil _phoneUtil;

  /// The text searched for phone numbers.
  final String _text;

  /// The region (country) to assume for phone numbers without
  /// an international prefix, possibly null.
  final String _preferredRegion;

  /// The degree of validation requested.
  final Leniency _leniency;

  /// The maximum number of retries after matching an invalid number.
  Int64 _maxTries;

  /// The iteration tristate.
  PhoneNumberMatcherState _state = PhoneNumberMatcherState.notReady;

  /// The last successful match, null unless in {@link State#READY}.
  PhoneNumberMatch? _lastMatch;

  /// The next index to start searching at. Undefined in {@link State#DONE}.
  int _searchIndex = 0;

  /// Returns a regular expression quantifier with an upper and lower limit.
  static String _limit(int lower, int upper) {
    if ((lower < 0) || (upper <= 0) || (upper < lower)) {
      throw IllegalArgumentException();
    }
    return "{$lower,$upper}";
  }

  static final String _openingParens = "(\\[\uFF08\uFF3B";
  static final String _closingParens = ")\\]\uFF09\uFF3D";
  static final String _leadClassChars =
      _openingParens + PhoneNumberUtil.plusChars;

  // Punctuation that may be at the start of a phone number - brackets and plus signs.
  static final RegExp _leadClass = RegExp("[$_leadClassChars]");

  // Limit on the number of consecutive punctuation characters.
  static String punctuationLimit = _limit(0, 4);

  // Limit on the number of leading (plus) characters.
  static final String _leadLimit = _limit(0, 2);

  // Limit on the number of blocks separated by punctuation. Uses digitBlockLimit since some
  // formats use spaces to separate each digit.
  static final String _blockLimit = _limit(0, _digitBlockLimit);

  // Limit on the number of pairs of brackets in a phone number.
  static final String _bracketPairLimit = _limit(0, 3);

  // The maximum number of digits allowed in a digit-separated block. As we allow all digits in a
  // single block, set high enough to accommodate the entire national number and the international
  // country code.
  static final int _digitBlockLimit =
      PhoneNumberUtil.maxLengthForNsn + PhoneNumberUtil.maxLengthCountryCode;

  // A digits block without punctuation.
  static final String _digitSequence = "\\p{Nd}${_limit(1, _digitBlockLimit)}";
  static final String _punctuation =
      "[${PhoneNumberUtil.validPunctuation}]$punctuationLimit";

  /// The phone number pattern used by [_find], similar to
  /// [PhoneNumberUtil.validPhoneNumber], but with the following differences:
  /// <ul>
  ///   <li>All captures are limited in order to place an upper bound to the text matched by the
  ///       pattern.
  /// <ul>
  ///   <li>Leading punctuation / plus signs are limited.
  ///   <li>Consecutive occurrences of punctuation are limited.
  ///   <li>Number of digits is limited.
  /// </ul>
  ///   <li>No whitespace is allowed at the start or end.
  ///   <li>No alpha digits (vanity numbers such as 1-800-SIX-FLAGS) are currently supported.
  /// </ul>
  ///
  static final RegExp _pattern = RegExp(
    "(?:${_leadClass.pattern}$_punctuation)$_leadLimit$_digitSequence(?:$_punctuation$_digitSequence)$_blockLimit(?:${PhoneNumberUtil.extnPatternsForMatching})?",
    caseSensitive: false,
    unicode: true,
  );

  /// Matches strings that look like publication pages. Example:
  /// <pre>Computing Complete Answers to Queries in the Presence of Limited Access Patterns.
  /// Chen Li. VLDB J. 12(3): 211-227 (2003).</pre>
  ///
  /// The string "211-227 (2003)" is not a telephone number.
  static final RegExp _pubPages = RegExp(r'\d{1,5}-+\d{1,5}\s{0,4}\(\d{1,4}');

  /// Matches strings that look like dates using "/" as a separator.
  /// Examples: 3/10/2011, 31/10/96 or 08/31/95.
  static final RegExp _slashSeparatedDates =
      RegExp(r'(?:(?:[0-3]?\d/[01]?\d)|(?:[01]?\d/[0-3]?\d))/(?:[12]\d)?\d{2}');

  /// Matches timestamps. Examples: "2012-01-02 08:00".
  /// Note that the reg-ex does not include the
  /// trailing ":\d\d" -- that is covered by _timeStampsSuffix.
  static final RegExp _timeStamps =
      RegExp(r'[12]\d{3}[-/]?[01]\d[-/]?[0-3]\d +[0-2]\d$');
  static final RegExp _timeStampsSuffix = RegExp(r':[0-5]\d');

  static final String _nonParens = "[^$_openingParens$_closingParens]";

  /// Pattern to check that brackets match. Opening brackets should be closed within a phone number.
  /// This also checks that there is something inside the brackets. Having no brackets at all is also
  /// fine.
  /// An opening bracket at the beginning may not be closed, but subsequent ones should be.  It's
  /// also possible that the leading bracket was dropped, so we shouldn't be surprised if we see a
  /// closing bracket first. We limit the sets of brackets in a phone number to four.
  static final RegExp _matchingBrackets = RegExp(
      "(?:[$_openingParens])?(?:$_nonParens+[$_closingParens])?$_nonParens+(?:[$_openingParens]$_nonParens+[$_closingParens])$_bracketPairLimit$_nonParens*");

  /// Patterns used to extract phone numbers from a larger phone-number-like pattern. These are
  /// ordered according to specificity. For example, white-space is last since that is frequently
  /// used in numbers, not just to separate two numbers. We have separate patterns since we don't
  /// want to break up the phone-number-like text on more than one different kind of symbol at one
  /// time, although symbols of the same type (e.g. space) can be safely grouped together.
  ///
  /// Note that if there is a match, we will always check any text found up to the first match as
  /// well.
  static final List<RegExp> _innerMatches = [
    // Breaks on the slash - e.g. "651-234-2345/332-445-1234"
    RegExp(r"/+(.*)"),
    // Note that the bracket here is inside the capturing group, since we consider it part of the
    // phone number. Will match a pattern like "(650) 223 3345 (754) 223 3321".
    RegExp(r"(\([^(]*)"),
    // Breaks on a hyphen - e.g. "12345 - 332-445-1234 is my number."
    // We require a space on either side of the hyphen for it to be considered a separator.
    RegExp(r"(?:\p{Z}-|-\p{Z})\p{Z}*(.+)", unicode: true),
    // Various types of wide hyphens. Note we have decided not to enforce a space here, since it's
    // possible that it's supposed to be used to break two numbers without spaces, and we haven't
    // seen many instances of it used within a number.
    RegExp(r"[\u2012-\u2015\uFF0D]\p{Z}*(.+)", unicode: true),
    // Breaks on a full stop - e.g. "12345. 332-445-1234 is my number."
    RegExp(r"\.+\p{Z}*([^.]+)", unicode: true),
    // Breaks on space - e.g. "3324451234 8002341234"
    RegExp(r"\p{Z}+(\P{Z}+)", unicode: true),
  ];

  /// Attempts to find the next subsequence in the searched sequence on or after [searchIndex]
  /// that represents a phone number. Returns the next match, null if none was found.
  ///
  /// [index] the search index to start searching at
  /// returns the phone number match found, null if none can be found
  PhoneNumberMatch? _find(int index) {
    Iterator<RegExpMatch> matches = _pattern.allMatches(_text, index).iterator;

    while (matches.moveNext() && _maxTries > 0) {
      RegExpMatch match = matches.current;

      int start = match.start;
      String candidate = match.group(0)!;
      index = start + candidate.length;

      // Check for extra numbers at the end.
      // TODO: This is the place to start when trying to support extraction of
      // multiple phone number from split notations (+41 79 123 45 67 / 68).
      candidate = _trimAfterFirstMatch(
          PhoneNumberUtil.secondNumberStartPattern, candidate);

      PhoneNumberMatch? numberMatch = _extractMatch(candidate, start);
      if (numberMatch != null) {
        return numberMatch;
      }

      _maxTries--;
    }

    return null;
  }

  /// Trims away any characters after the first match of [pattern] in [candidate],
  /// returning the trimmed version.
  String _trimAfterFirstMatch(RegExp pattern, String candidate) {
    final RegExpMatch? match = pattern.firstMatch(candidate);
    return (match != null) ? candidate.substring(0, match.start) : candidate;
  }

  /// Attempts to extract a match from a [candidate]} character sequence.
  ///
  /// [candidate] the candidate text that might contain a phone number
  /// [offset] the offset of [candidate] within [text]
  /// returns the match found, null if none can be found
  PhoneNumberMatch? _extractMatch(String candidate, int offset) {
    // Skip a match that is more likely to be a date.
    if (_slashSeparatedDates.hasMatch(candidate)) {
      return null;
    }

    // Skip potential time-stamps.
    if (_timeStamps.hasMatch(candidate)) {
      final followingText = _text.substring(offset + candidate.length);
      if (_timeStampsSuffix.hasMatch(followingText)) {
        return null;
      }
    }

    // Try to come up with a valid match given the entire candidate.
    PhoneNumberMatch? match = _parseAndVerify(candidate, offset);
    if (match != null) {
      return match;
    }

    // If that failed, try to find an "inner match" - there might be
    // a phone number within this candidate.
    return _extractInnerMatch(candidate, offset);
  }

  /// Parses a phone number from the [candidate] using [PhoneNumberUtil.parse] and
  /// verifies it matches the requested [leniency]. If parsing and verification succeed, a
  /// corresponding [PhoneNumberMatch] is returned, otherwise this method returns null.
  ///
  /// [candidate] the candidate match
  /// [offset] the offset of [candidate] within [text]
  /// returns the parsed and validated phone number match, or null
  PhoneNumberMatch? _parseAndVerify(String candidate, int offset) {
    try {
      // Check the candidate doesn't contain any formatting which would indicate that it really
      // isn't a phone number.
      if (_matchingBrackets.firstMatch(candidate)?.group(0) != candidate ||
          _pubPages.hasMatch(candidate)) {
        return null;
      }

      // If leniency is set to [Leniency.valid] or stricter, we also want to skip numbers that are surrounded
      // by Latin alphabetic characters, to skip cases like abc8005001234 or 8005001234def.
      if (_leniency.index.compareTo(Leniency.valid.index) >= 0) {
        // If the candidate is not at the start of the text, and does not start with phone-number
        // punctuation, check the previous character.
        if (offset > 0 && !_leadClass.hasMatch(candidate)) {
          String previousChar = _text[offset - 1];
          // We return null if it is a latin letter or an invalid punctuation symbol.
          if (_isInvalidPunctuationSymbol(previousChar) ||
              isLatinLetter(previousChar)) {
            return null;
          }
        }

        int lastCharIndex = offset + candidate.length;
        if (lastCharIndex < _text.length) {
          String nextChar = _text[lastCharIndex];
          if (_isInvalidPunctuationSymbol(nextChar) ||
              isLatinLetter(nextChar)) {
            return null;
          }
        }
      }

      PhoneNumber number =
          _phoneUtil.parseAndKeepRawInput(candidate, _preferredRegion);

      if (_leniency.verify(number, candidate, _phoneUtil, this)) {
        // We used parseAndKeepRawInput to create this number, but for now we don't
        // return the extra
        // values parsed.
        // TODO: stop clearing all values here and switch all users over
        // to using rawInput() rather than the rawString() of PhoneNumberMatch.
        number
          ..clearCountryCodeSource()
          ..clearRawInput()
          ..clearPreferredDomesticCarrierCode();

        return PhoneNumberMatch(offset, candidate, number);
      }
    } catch (e) {
      // ignore and continue
    }

    return null;
  }

  /// Attempts to extract a match from [candidate] if the whole candidate
  /// does not qualify as a match.
  ///
  /// [candidate] the candidate text that might contain a phone number
  /// [offset] the current offset of [candidate] within [text]
  /// returns the match found, null if none can be found
  PhoneNumberMatch? _extractInnerMatch(String candidate, int offset) {
    for (RegExp possibleInnerMatch in _innerMatches) {
      Iterator<RegExpMatch> matches =
          possibleInnerMatch.allMatches(candidate).iterator;
      bool isFirstMatch = true;

      while (matches.moveNext() && _maxTries > 0) {
        RegExpMatch match = matches.current;

        if (isFirstMatch) {
          // We should handle any group before this one too.
          String group = _trimAfterFirstMatch(
            PhoneNumberUtil.unwantedEndCharPattern,
            candidate.substring(0, match.start),
          );

          PhoneNumberMatch? phoneNumberMatch = _parseAndVerify(group, offset);
          if (phoneNumberMatch != null) {
            return phoneNumberMatch;
          }

          isFirstMatch = false;
          _maxTries--;
        }

        String group = _trimAfterFirstMatch(
          PhoneNumberUtil.unwantedEndCharPattern,
          match.group(1)!,
        );

        PhoneNumberMatch? phoneNumberMatch = _parseAndVerify(
          group,
          offset + candidate.indexOf(match.group(1)!),
        );

        if (phoneNumberMatch != null) {
          return phoneNumberMatch;
        }

        _maxTries--;
      }
    }

    return null;
  }

  static bool _isInvalidPunctuationSymbol(String character) {
    return character == '%' || _isCurrency(character);
  }

  static bool _isCurrency(String symbol) {
    final RegExp pattern = RegExp(r'\p{Sc}', unicode: true);
    return pattern.hasMatch(symbol[0]);
  }

  static bool isLatinLetter(String character) {
    final RegExp latinLettersPattern =
        RegExp(r'\p{Script=Latin}', unicode: true);
    final bool isLatinScript = latinLettersPattern.hasMatch(character);

    final RegExp nonSpacingMarkRegex = RegExp(r'\p{Mn}', unicode: true);
    final bool isNonSpacingMark = nonSpacingMarkRegex.hasMatch(character);

    return isLatinScript || isNonSpacingMark;
  }

  static bool _isDigit(String character) {
    final RegExp pattern = RegExp(r'\p{Nd}', unicode: true);
    return pattern.hasMatch(character);
  }

  static bool allNumberGroupsRemainGrouped(
    PhoneNumberUtil util,
    PhoneNumber number,
    StringBuffer normalizedCandidate,
    List<String> formattedNumberGroups,
  ) {
    int fromIndex = 0;

    if (number.countryCodeSource !=
        PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY) {
      // First skip the country code if the normalized candidate contained it.
      String countryCode = '${number.countryCode}';
      fromIndex = normalizedCandidate.toString().indexOf(countryCode) +
          countryCode.length;
    }

    /// Check each group of consecutive digits are not broken into separate groupings in the
    /// [normalizedCandidate] string.
    for (int i = 0; i < formattedNumberGroups.length; i++) {
      // Fails if the substring of [normalizedCandidate] starting from [fromIndex]
      // doesn't contain the consecutive digits in formattedNumberGroups[i].
      fromIndex = normalizedCandidate
          .toString()
          .indexOf(formattedNumberGroups[i], fromIndex);
      if (fromIndex < 0) {
        return false;
      }

      // Moves[fromIndex] forward.
      fromIndex += formattedNumberGroups[i].length;

      if (i == 0 && fromIndex < normalizedCandidate.length) {
        // We are at the position right after the NDC. We get the region used for formatting
        // information based on the country code in the phone number, rather than the number itself,
        // as we do not need to distinguish between different countries with the same country
        // calling code and this is faster.
        String region = util.getRegionCodeForCountryCode(number.countryCode);

        if (util.getNddPrefixForRegion(region, true) != null &&
            _isDigit(normalizedCandidate.toString()[fromIndex])) {
          // This means there is no formatting symbol after the NDC. In this case, we only
          // accept the number if there is no formatting symbol at all in the number, except
          // for extensions. This is only important for countries with national prefixes.
          String nationalSignificantNumber =
              util.getNationalSignificantNumber(number);
          return normalizedCandidate
              .toString()
              .substring(fromIndex - formattedNumberGroups[i].length)
              .startsWith(nationalSignificantNumber);
        } else {
          continue;
        }
      }
    }
    // The check here makes sure that we haven't mistakenly already used the extension to
    // match the last group of the subscriber number. Note the extension cannot have
    // formatting in-between digits.
    return normalizedCandidate
        .toString()
        .substring(fromIndex)
        .contains(number.extension_3);
  }

  static bool allNumberGroupsAreExactlyPresent(
    PhoneNumberUtil util,
    PhoneNumber number,
    StringBuffer normalizedCandidate,
    List<String> formattedNumberGroups,
  ) {
    List<String> candidateGroups =
        normalizedCandidate.toString().split(PhoneNumberUtil.nonDigitsPattern);

    // Set this to the last group, skipping it if the number has an extension.
    int candidateNumberGroupIndex = number.hasExtension_3()
        ? candidateGroups.length - 2
        : candidateGroups.length - 1;

    // First we check if the national significant number is formatted as a block.
    // We use contains and not equals, since the national significant number may be present with
    // a prefix such as a national number prefix, or the country code itself.
    if (candidateGroups.length == 1 ||
        candidateGroups[candidateNumberGroupIndex]
            .contains(util.getNationalSignificantNumber(number))) {
      return true;
    }

    // Starting from the end, go through in reverse, excluding the first group, and check the
    // candidate and number groups are the same.
    for (int formattedNumberGroupIndex = (formattedNumberGroups.length - 1);
        formattedNumberGroupIndex > 0 && candidateNumberGroupIndex >= 0;
        formattedNumberGroupIndex--, candidateNumberGroupIndex--) {
      if (candidateGroups[candidateNumberGroupIndex] !=
          formattedNumberGroups[formattedNumberGroupIndex]) {
        return false;
      }
    }

    // Now check the first group. There may be a national prefix at the start, so we only check
    // that the candidate group ends with the formatted number group.
    return (candidateNumberGroupIndex >= 0 &&
        candidateGroups[candidateNumberGroupIndex]
            .endsWith(formattedNumberGroups[0]));
  }

  /// Helper method to get the national-number part of a number, formatted without any national
  /// prefix, and return it as a set of digit blocks that would be formatted together following
  /// standard formatting rules or the formatting pattern passed in.
  static List<String> _getNationalNumberGroups(
    PhoneNumberUtil util,
    PhoneNumber number, [
    NumberFormat? formattingPattern,
  ]) {
    if (formattingPattern != null) {
      // If a format is provided, we format the NSN only, and split that according to the separator.
      String nationalSignificantNumber =
          util.getNationalSignificantNumber(number);
      return util
          .formatNsnUsingPattern(nationalSignificantNumber, formattingPattern,
              PhoneNumberFormat.rfc3966)
          .split("-");
    }

    // This will be in the format +CC-DG1-DG2-DGX;ext=EXT
    // where DG1..DGX represents groups of digits.
    String rfc3966Format = util.format(number, PhoneNumberFormat.rfc3966);
    // We remove the extension part from the formatted string
    // before splitting it into different groups.
    int endIndex = rfc3966Format.indexOf(';');
    if (endIndex < 0) {
      endIndex = rfc3966Format.length;
    }
    // The country-code will have a '-' following it.
    int startIndex = rfc3966Format.indexOf('-') + 1;
    return rfc3966Format.substring(startIndex, endIndex).split("-");
  }

  bool checkNumberGroupingIsValid(PhoneNumber number, String candidate,
      PhoneNumberUtil util, NumberGroupingChecker checker) {
    StringBuffer normalizedCandidate =
        PhoneNumberUtil.normalizeDigits(candidate, true /* keep non-digits */);
    List<String> formattedNumberGroups = _getNationalNumberGroups(util, number);

    if (checker(util, number, normalizedCandidate, formattedNumberGroups)) {
      return true;
    }

    // If this didn't pass, see if there are any alternate formats that match, and try them instead.
    PhoneMetadata? alternateFormats =
        _phoneUtil.getAlternateFormatsMetadata(number.countryCode);
    String nationalSignificantNumber =
        util.getNationalSignificantNumber(number);

    if (alternateFormats != null) {
      for (NumberFormat alternateFormat in alternateFormats.numberFormat) {
        if (alternateFormat.leadingDigitsPattern.isNotEmpty) {
          // There is only one leading digits pattern for alternate formats.
          RegExp pattern = RegExp(alternateFormat.leadingDigitsPattern[0]);

          if (pattern.firstMatch(nationalSignificantNumber)?.start != 0) {
            // Leading digits don't match; try another one.
            continue;
          }
        }

        formattedNumberGroups =
            _getNationalNumberGroups(util, number, alternateFormat);
        if (checker(util, number, normalizedCandidate, formattedNumberGroups)) {
          return true;
        }
      }
    }
    return false;
  }

  static bool containsMoreThanOneSlashInNationalNumber(
      PhoneNumber number, String candidate) {
    int firstSlashInBodyIndex = candidate.indexOf('/');
    if (firstSlashInBodyIndex < 0) {
      // No slashes, this is okay.
      return false;
    }
    // Now look for a second one.
    int secondSlashInBodyIndex =
        candidate.indexOf('/', firstSlashInBodyIndex + 1);
    if (secondSlashInBodyIndex < 0) {
      // Only one slash, this is okay.
      return false;
    }

    // If the first slash is after the country calling code, this is permitted.
    bool candidateHasCountryCode = (number.countryCodeSource ==
            PhoneNumber_CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN ||
        number.countryCodeSource ==
            PhoneNumber_CountryCodeSource.FROM_NUMBER_WITHOUT_PLUS_SIGN);
    if (candidateHasCountryCode &&
        PhoneNumberUtil.normalizeDigitsOnly(
                candidate.substring(0, firstSlashInBodyIndex)) ==
            '${number.countryCode}') {
      // Any more slashes and this is illegal.
      return candidate.substring(secondSlashInBodyIndex + 1).contains("/");
    }
    return true;
  }

  static bool containsOnlyValidXChars(
      PhoneNumber number, String candidate, PhoneNumberUtil util) {
    // The characters 'x' and 'X' can be (1) a carrier code, in which case they always precede the
    // national significant number or (2) an extension sign, in which case they always precede the
    // extension number. We assume a carrier code is more than 1 digit, so the first case has to
    // have more than 1 consecutive 'x' or 'X', whereas the second case can only have exactly 1 'x'
    // or 'X'. We ignore the character if it appears as the last character of the string.
    for (int index = 0; index < candidate.length - 1; index++) {
      String charAtIndex = candidate[index];
      if (charAtIndex == 'x' || charAtIndex == 'X') {
        String charAtNextIndex = candidate[index + 1];
        if (charAtNextIndex == 'x' || charAtNextIndex == 'X') {
          // This is the carrier code case, in which the 'X's always precede the national
          // significant number.
          index++;
          if (util.isNumberMatch(number, candidate.substring(index)) !=
              MatchType.nsnMatch) {
            return false;
          }
          // This is the extension sign case, in which the 'x' or 'X' should always precede the
          // extension number.
        } else if (PhoneNumberUtil.normalizeDigitsOnly(
                candidate.substring(index)) !=
            (number.extension_3)) {
          return false;
        }
      }
    }
    return true;
  }

  static bool isNationalPrefixPresentIfRequired(
      PhoneNumber number, PhoneNumberUtil util) {
    // First, check how we deduced the country code. If it was written in international format, then
    // the national prefix is not required.
    if (number.countryCodeSource !=
        PhoneNumber_CountryCodeSource.FROM_DEFAULT_COUNTRY) {
      return true;
    }
    String phoneNumberRegion =
        util.getRegionCodeForCountryCode(number.countryCode);
    PhoneMetadata? metadata =
        util.getMetadataForRegion(regionCode: phoneNumberRegion);
    if (metadata == null) {
      return true;
    }
    // Check if a national prefix should be present when formatting this number.
    String nationalNumber = util.getNationalSignificantNumber(number);
    NumberFormat? formatRule = util.chooseFormattingPatternForNumber(
        metadata.numberFormat, nationalNumber);
    // To do this, we check that a national prefix formatting rule was present and that it wasn't
    // just the first-group symbol ($1) with punctuation.
    if ((formatRule != null) &&
        formatRule.nationalPrefixFormattingRule.isNotEmpty) {
      if (formatRule.nationalPrefixOptionalWhenFormatting) {
        // The national-prefix is optional in these cases, so we don't need to check if it was
        // present.
        return true;
      }
      if (PhoneNumberUtil.formattingRuleHasFirstGroupOnly(
          formatRule.nationalPrefixFormattingRule)) {
        // National Prefix not needed for this number.
        return true;
      }
      // Normalize the remainder.
      String rawInputCopy =
          PhoneNumberUtil.normalizeDigitsOnly(number.rawInput);
      StringBuffer rawInput = StringBuffer(rawInputCopy);
      // Check if we found a national prefix and/or carrier code at the start of the raw input, and
      // return the result.
      return util.maybeStripNationalPrefixAndCarrierCode(
          rawInput, metadata, null);
    }
    return true;
  }
}
