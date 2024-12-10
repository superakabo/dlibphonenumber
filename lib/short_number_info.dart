// Based on the original Java code: .../phonenumbers/ShortNumberInfo.java
// Copyright (C) 2013 The Libphonenumber Authors
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

import 'package:meta/meta.dart';

import 'enums/short_number_cost.dart';
import 'generated/classes/phone_metadata/phonemetadata.pb.dart';
import 'generated/classes/phone_number/phonenumber.pb.dart';
import 'generated/metadata/short_number_metadata_map.dart';
import 'metadata_map_loader.dart';
import 'phone_number_util.dart';

/// Methods for getting information about short phone numbers,
/// such as short codes and emergency numbers.
///
/// Note that most commercial short numbers are not handled here,
/// but by the [PhoneNumberUtil].
class ShortNumberInfo {
  /// Returns the singleton instance of the ShortNumberInfo.
  static ShortNumberInfo get instance => _instance;
  static final ShortNumberInfo _instance =
      ShortNumberInfo(const ShortNumberMetadataMap());

  // In these countries, if extra digits are added to an emergency number, it no longer connects
  // to the emergency service.
  static final Set<String> _regionsWhereEmergencyNumbersMustBeExact = {
    'BR',
    'CL',
    'NI'
  };

  final Map<String, PhoneMetadata?> _phoneMetadataCache = {};

  final MetadataMapLoader _metadataMapLoader;

  @internal
  ShortNumberInfo(
    this._metadataMapLoader,
  );

  /// Returns a list with the region codes that match the specific country calling code. For
  /// non-geographical country calling codes, the region code 001 is returned. Also, in the case
  /// of no region code being found, an empty list is returned.
  List<String> _getRegionCodesForCountryCode(int countryCallingCode) {
    List<String>? regionCodes =
        _metadataMapLoader.countryCodeToRegionCodeMap['$countryCallingCode'];
    return (regionCodes == null) ? [] : regionCodes;
  }

  /// Helper method to check that the country calling code of the number matches the region it's
  /// being dialed from.
  bool _regionDialingFromMatchesNumber(
      PhoneNumber number, String? regionDialingFrom) {
    List<String> regionCodes =
        _getRegionCodesForCountryCode(number.countryCode);
    return regionCodes.contains(regionDialingFrom);
  }

  /// A thin wrapper around {@code shortNumberMetadataSource} which catches {@link
  /// IllegalArgumentException} for invalid region code and instead returns {@code null}
  PhoneMetadata? _getShortNumberMetadataForRegion(String? regionCode) {
    PhoneMetadata? metadata = _phoneMetadataCache[regionCode];

    if (metadata == null && regionCode != null) {
      metadata = _getShortNumberMetdata(regionCode);
      _phoneMetadataCache[regionCode] = metadata;
    }

    return metadata;
  }

  PhoneMetadata? _getShortNumberMetdata(String regionCode) {
    Map<String, Object?>? territory =
        _metadataMapLoader.getTerritory(regionCode);
    if (territory != null) {
      return PhoneMetadata()..mergeFromProto3Json(territory);
    }
    return null;
  }

  /// Check whether a short number is a possible number when dialed from the given region. This
  /// provides a more lenient check than [isValidShortNumberForRegion].
  ///
  /// [number] the short number to check
  /// [regionDialingFrom] the region from which the number is dialed
  /// returns whether the number is a possible short number
  bool isPossibleShortNumberForRegion(
      PhoneNumber number, String regionDialingFrom) {
    if (!_regionDialingFromMatchesNumber(number, regionDialingFrom)) {
      return false;
    }
    PhoneMetadata? phoneMetadata =
        _getShortNumberMetadataForRegion(regionDialingFrom);
    if (phoneMetadata == null) {
      return false;
    }
    int numberLength = _getNationalSignificantNumber(number).length;
    return phoneMetadata.generalDesc.possibleLength.contains(numberLength);
  }

  /// Check whether a short number is a possible number. If a country calling code is shared by
  /// multiple regions, this returns true if it's possible in any of them. This provides a more
  /// lenient check than [isValidShortNumber].
  /// See [isPossibleShortNumberForRegion(PhoneNumber, String)] for details.
  ///
  /// [number] the short number to check
  /// returns whether the number is a possible short number
  bool isPossibleShortNumber(PhoneNumber number) {
    List<String> regionCodes =
        _getRegionCodesForCountryCode(number.countryCode);
    int shortNumberLength = _getNationalSignificantNumber(number).length;
    for (String region in regionCodes) {
      PhoneMetadata? phoneMetadata = _getShortNumberMetadataForRegion(region);
      if (phoneMetadata == null) {
        continue;
      }
      if (phoneMetadata.generalDesc.possibleLength
          .contains(shortNumberLength)) {
        return true;
      }
    }
    return false;
  }

  /// Tests whether a short number matches a valid pattern in a region. Note that this doesn't verify
  /// the number is actually in use, which is impossible to tell by just looking at the number itself.
  ///
  /// [number] the short number for which we want to test the validity
  /// [regionDialingFrom] the region from which the number is dialed
  /// returns whether the short number matches a valid pattern
  bool isValidShortNumberForRegion(
      PhoneNumber number, String? regionDialingFrom) {
    if (!_regionDialingFromMatchesNumber(number, regionDialingFrom)) {
      return false;
    }

    PhoneMetadata? phoneMetadata =
        _getShortNumberMetadataForRegion(regionDialingFrom!);
    if (phoneMetadata == null) {
      return false;
    }

    String shortNumber = _getNationalSignificantNumber(number);
    PhoneNumberDesc generalDesc = phoneMetadata.generalDesc;
    if (!_matchesPossibleNumberAndNationalNumber(shortNumber, generalDesc)) {
      return false;
    }

    PhoneNumberDesc shortNumberDesc = phoneMetadata.shortCode;
    return _matchesPossibleNumberAndNationalNumber(
        shortNumber, shortNumberDesc);
  }

  /// Tests whether a short number matches a valid pattern. If a country calling code is shared by
  /// multiple regions, this returns true if it's valid in any of them. Note that this doesn't verify
  /// the number is actually in use, which is impossible to tell by just looking at the number
  /// itself. See [isValidShortNumberForRegion(PhoneNumber, String)] for details.
  ///
  /// [number] the short number for which we want to test the validity
  /// returns whether the short number matches a valid pattern
  bool isValidShortNumber(PhoneNumber number) {
    List<String> regionCodes =
        _getRegionCodesForCountryCode(number.countryCode);
    String? regionCode =
        _getRegionCodeForShortNumberFromRegionList(number, regionCodes);
    if (regionCodes.length > 1 && regionCode != null) {
      // If a matching region had been found for the phone number from among two or more regions,
      // then we have already implicitly verified its validity for that region.
      return true;
    }
    return isValidShortNumberForRegion(number, regionCode);
  }

  /// Gets the expected cost category of a short number when dialed from a region (however, nothing
  /// is implied about its validity). If it is important that the number is valid, then its validity
  /// must first be checked using [isValidShortNumberForRegion]. Note that emergency numbers
  /// are always considered toll-free. Example usage:
  /// <pre>
  /// // The region for which the number was parsed and the region we subsequently check against
  /// // need not be the same. Here we parse the number in the US and check it for Canada.
  /// PhoneNumber number = phoneUtil.parse("110", "US");
  /// ...
  /// String regionCode = "CA";
  /// ShortNumberInfo shortInfo = ShortNumberInfo.instance;
  /// if (shortInfo.isValidShortNumberForRegion(shortNumber, regionCode)) {
  ///   ShortNumberCost cost = shortInfo.getExpectedCostForRegion(number, regionCode);
  ///   // Do something with the cost information here.
  /// </pre>
  ///
  /// [number] the short number for which we want to know the expected cost category
  /// [regionDialingFrom] the region from which the number is dialed
  /// returns the expected cost category for that region of the short number.
  /// Returns [ShortNumberCost.unknownCost] if the number does not match a cost category.
  /// Note that an invalid number may match any cost category.
  ShortNumberCost getExpectedCostForRegion(
      PhoneNumber number, String regionDialingFrom) {
    if (!_regionDialingFromMatchesNumber(number, regionDialingFrom)) {
      return ShortNumberCost.unknownCost;
    }
    // Note that regionDialingFrom may be null, in which case phoneMetadata will also be null.
    PhoneMetadata? phoneMetadata =
        _getShortNumberMetadataForRegion(regionDialingFrom);
    if (phoneMetadata == null) {
      return ShortNumberCost.unknownCost;
    }

    String shortNumber = _getNationalSignificantNumber(number);

    // The possible lengths are not present for a particular sub-type if they match the general
    // description; for this reason, we check the possible lengths against the general description
    // first to allow an early exit if possible.
    if (!phoneMetadata.generalDesc.possibleLength
        .contains(shortNumber.length)) {
      return ShortNumberCost.unknownCost;
    }

    // The cost categories are tested in order of decreasing expense, since if for some reason the
    // patterns overlap the most expensive matching cost category should be returned.
    if (_matchesPossibleNumberAndNationalNumber(
        shortNumber, phoneMetadata.premiumRate)) {
      return ShortNumberCost.premiumRate;
    }
    if (_matchesPossibleNumberAndNationalNumber(
        shortNumber, phoneMetadata.standardRate)) {
      return ShortNumberCost.standardRate;
    }
    if (_matchesPossibleNumberAndNationalNumber(
        shortNumber, phoneMetadata.tollFree)) {
      return ShortNumberCost.tollFree;
    }
    if (isEmergencyNumber(shortNumber, regionDialingFrom)) {
      // Emergency numbers are implicitly toll-free.
      return ShortNumberCost.tollFree;
    }
    return ShortNumberCost.unknownCost;
  }

  /// Gets the expected cost category of a short number (however, nothing is implied about its
  /// validity). If the country calling code is unique to a region, this method behaves exactly the
  /// same as [getExpectedCostForRegion(PhoneNumber, String)]. However, if the country
  /// calling code is shared by multiple regions, then it returns the highest cost in the sequence
  /// [ShortNumberCost.premiumRate], [ShortNumberCost.unknownCost], [ShortNumberCost.standardRate],
  /// [ShortNumberCost.tollFree]. The reason for the position of unknownCost in this order is that
  /// if a number is unknownCost in one region but standardRate or tollFree in another, its expected
  /// cost cannot be estimated as one of the latter since it might be a premiumRate number.
  /// <p>
  /// For example, if a number is standardRate in the US, but tollFree in Canada, the expected
  /// cost returned by this method will be standardRate, since the NANPA countries share the same
  /// country calling code.
  /// <p>
  /// Note: If the region from which the number is dialed is known, it is highly preferable to call
  /// [getExpectedCostForRegion(PhoneNumber, String)] instead.
  ///
  /// [number] the short number for which we want to know the expected cost category
  /// returns the highest expected cost category of the short number in the region(s)
  /// with the given country calling code.
  ShortNumberCost getExpectedCost(PhoneNumber number) {
    List<String> regionCodes =
        _getRegionCodesForCountryCode(number.countryCode);
    if (regionCodes.isEmpty) {
      return ShortNumberCost.unknownCost;
    }
    if (regionCodes.length == 1) {
      return getExpectedCostForRegion(number, regionCodes[0]);
    }
    ShortNumberCost cost = ShortNumberCost.tollFree;
    for (String regionCode in regionCodes) {
      ShortNumberCost costForRegion =
          getExpectedCostForRegion(number, regionCode);
      switch (costForRegion) {
        case ShortNumberCost.premiumRate:
          return ShortNumberCost.premiumRate;
        case ShortNumberCost.unknownCost:
          cost = ShortNumberCost.unknownCost;
          break;
        case ShortNumberCost.standardRate:
          if (cost != ShortNumberCost.unknownCost) {
            cost = ShortNumberCost.standardRate;
          }
          break;
        case ShortNumberCost.tollFree:
          // Do nothing.
          break;
      }
    }
    return cost;
  }

  // Helper method to get the region code for a given phone number,
  // from a list of possible region codes. If the list contains more
  // than one region, the first region for which the number is valid is returned.
  String? _getRegionCodeForShortNumberFromRegionList(
      PhoneNumber number, List<String> regionCodes) {
    if (regionCodes.isEmpty) {
      return null;
    } else if (regionCodes.length == 1) {
      return regionCodes[0];
    }
    String nationalNumber = _getNationalSignificantNumber(number);
    for (String regionCode in regionCodes) {
      PhoneMetadata? phoneMetadata =
          _getShortNumberMetadataForRegion(regionCode);
      if (phoneMetadata != null &&
          _matchesPossibleNumberAndNationalNumber(
              nationalNumber, phoneMetadata.shortCode)) {
        // The number is valid for this region.
        return regionCode;
      }
    }
    return null;
  }

  /// Gets a valid short number for the specified region.
  ///
  /// [regionCode] the region for which an example short number is needed
  /// returns a valid short number for the specified region.
  /// Returns an empty string when the metadata does not contain such information.
  @visibleForTesting
  String getExampleShortNumber(String? regionCode) {
    PhoneMetadata? phoneMetadata = _getShortNumberMetadataForRegion(regionCode);
    if (phoneMetadata == null) {
      return "";
    }

    PhoneNumberDesc desc = phoneMetadata.shortCode;
    if (desc.hasExampleNumber()) {
      return desc.exampleNumber;
    }

    return "";
  }

  /// Gets a valid short number for the specified cost category.
  ///
  /// [regionCode] the region for which an example short number is needed
  /// [cost] the cost category of number that is needed
  /// returns a valid short number for the specified region and cost category.
  /// Returns an empty string when the metadata does not contain such information,
  /// or the cost is [ShortNumberCost.unknownCost].
  @visibleForTesting
  String getExampleShortNumberForCost(String regionCode, ShortNumberCost cost) {
    PhoneMetadata? phoneMetadata = _getShortNumberMetadataForRegion(regionCode);
    if (phoneMetadata == null) {
      return "";
    }
    PhoneNumberDesc? desc;
    switch (cost) {
      case ShortNumberCost.tollFree:
        desc = phoneMetadata.tollFree;
        break;
      case ShortNumberCost.standardRate:
        desc = phoneMetadata.standardRate;
        break;
      case ShortNumberCost.premiumRate:
        desc = phoneMetadata.premiumRate;
        break;
      default:
      // UNKNOWN_COST numbers are computed by the process of elimination from the other cost
      // categories.
    }
    if (desc != null && desc.hasExampleNumber()) {
      return desc.exampleNumber;
    }
    return "";
  }

  /// Returns true if the given number, exactly as dialed, might be used to connect to an emergency
  /// service in the given region.
  /// <p>
  /// This method accepts a string, rather than a PhoneNumber, because it needs to distinguish
  /// cases such as "+1 911" and "911", where the former may not connect to an emergency service in
  /// all cases but the latter would. This method takes into account cases where the number might
  /// contain formatting, or might have additional digits appended (when it is okay to do that in
  /// the specified region).
  ///
  /// [number] the phone number to test
  /// [regionCode] the region where the phone number is being dialed
  /// returns whether the number might be used to connect to an emergency service in the given region
  bool connectsToEmergencyNumber(String number, String regionCode) {
    return _matchesEmergencyNumberHelper(
        number, regionCode, true /* allows prefix match */);
  }

  /// Returns true if the given number exactly matches an emergency service number in the given
  /// region.
  /// <p>
  /// This method takes into account cases where the number might contain formatting, but doesn't
  /// allow additional digits to be appended. Note that [isEmergencyNumber(number, region)]
  /// implies [connectsToEmergencyNumber(number, region)].
  ///
  /// [number] the phone number to test
  /// [regionCode] the region where the phone number is being dialed
  /// returns whether the number exactly matches an emergency services number in the given region
  bool isEmergencyNumber(String number, String regionCode) {
    return _matchesEmergencyNumberHelper(
        number, regionCode, false /* doesn't allow prefix match */);
  }

  bool _matchesEmergencyNumberHelper(
      String number, String regionCode, bool allowPrefixMatch) {
    String possibleNumber = PhoneNumberUtil.extractPossibleNumber(number);
    if (PhoneNumberUtil.plusCharsPattern.hasMatch(possibleNumber)) {
      // Returns false if the number starts with a plus sign. We don't believe dialing the country
      // code before emergency numbers (e.g. +1911) works, but later, if that proves to work, we can
      // add additional logic here to handle it.
      return false;
    }

    PhoneMetadata? metadata = _getShortNumberMetadataForRegion(regionCode);
    if (metadata == null || !metadata.hasEmergency()) {
      return false;
    }

    String normalizedNumber =
        PhoneNumberUtil.normalizeDigitsOnly(possibleNumber);
    bool allowPrefixMatchForRegion = allowPrefixMatch &&
        !_regionsWhereEmergencyNumbersMustBeExact.contains(regionCode);

    return PhoneNumberUtil.matchNationalNumber(
      normalizedNumber,
      metadata.emergency,
      allowPrefixMatchForRegion,
    );
  }

  /// Given a valid short number, determines whether it is carrier-specific (however, nothing is
  /// implied about its validity). Carrier-specific numbers may connect to a different end-point, or
  /// not connect at all, depending on the user's carrier. If it is important that the number is
  /// valid, then its validity must first be checked using [isValidShortNumber] or
  /// [isValidShortNumberForRegion].
  ///
  /// [number] the valid short number to check
  /// returns whether the short number is carrier-specific,
  /// assuming the input was a valid short number
  bool isCarrierSpecific(PhoneNumber number) {
    List<String> regionCodes =
        _getRegionCodesForCountryCode(number.countryCode);
    String? regionCode =
        _getRegionCodeForShortNumberFromRegionList(number, regionCodes);
    String nationalNumber = _getNationalSignificantNumber(number);
    PhoneMetadata? phoneMetadata = _getShortNumberMetadataForRegion(regionCode);
    return (phoneMetadata != null) &&
        (_matchesPossibleNumberAndNationalNumber(
            nationalNumber, phoneMetadata.carrierSpecific));
  }

  /// Given a valid short number, determines whether it is carrier-specific when dialed from the
  /// given region (however, nothing is implied about its validity). Carrier-specific numbers may
  /// connect to a different end-point, or not connect at all, depending on the user's carrier. If
  /// it is important that the number is valid, then its validity must first be checked using
  /// [isValidShortNumber] or [isValidShortNumberForRegion]. Returns false if the
  /// number doesn't match the region provided.
  ///
  /// [number] the valid short number to check
  /// [regionDialingFrom]  the region from which the number is dialed
  /// returns whether the short number is carrier-specific in the provided region,
  /// assuming the input was a valid short number
  bool isCarrierSpecificForRegion(
      PhoneNumber number, String regionDialingFrom) {
    if (!_regionDialingFromMatchesNumber(number, regionDialingFrom)) {
      return false;
    }
    String nationalNumber = _getNationalSignificantNumber(number);
    PhoneMetadata? phoneMetadata =
        _getShortNumberMetadataForRegion(regionDialingFrom);
    return (phoneMetadata != null) &&
        (_matchesPossibleNumberAndNationalNumber(
            nationalNumber, phoneMetadata.carrierSpecific));
  }

  /// Given a valid short number, determines whether it is an SMS service (however, nothing is
  /// implied about its validity). An SMS service is where the primary or only intended usage is to
  /// receive and/or send text messages (SMSs). This includes MMS as MMS numbers downgrade to SMS if
  /// the other party isn't MMS-capable. If it is important that the number is valid, then its
  /// validity must first be checked using [isValidShortNumber] or
  /// [isValidShortNumberForRegion]. Returns false if the number doesn't match the region provided.
  ///
  /// [number]  the valid short number to check
  /// [regionDialingFrom]  the region from which the number is dialed
  /// returns whether the short number is an SMS service in the provided region,
  /// assuming the input was a valid short number
  bool isSmsServiceForRegion(PhoneNumber number, String regionDialingFrom) {
    if (!_regionDialingFromMatchesNumber(number, regionDialingFrom)) {
      return false;
    }
    PhoneMetadata? phoneMetadata =
        _getShortNumberMetadataForRegion(regionDialingFrom);
    return phoneMetadata != null &&
        _matchesPossibleNumberAndNationalNumber(
            _getNationalSignificantNumber(number), phoneMetadata.smsServices);
  }

  /// Gets the national significant number of the a phone number. Note a national significant number
  /// doesn't contain a national prefix or any formatting.
  /// <p>
  /// This is a temporary duplicate of the [getNationalSignificantNumber] method from
  /// [PhoneNumberUtil]. Ultimately a canonical static version should exist in a separate
  /// utility class (to prevent [ShortNumberInfo] needing to depend on PhoneNumberUtil).
  ///
  /// [number] the phone number for which the national significant number is needed
  /// returns the national significant number of the PhoneNumber object passed in
  static String _getNationalSignificantNumber(PhoneNumber number) {
    // If leading zero(s) have been set, we prefix this now. Note this is not a national prefix.
    StringBuffer nationalNumber = StringBuffer();
    if (number.italianLeadingZero) {
      List<String> zeros = List.filled(number.numberOfLeadingZeros, '0');
      nationalNumber.writeAll(zeros);
    }
    nationalNumber.write(number.nationalNumber);
    return nationalNumber.toString();
  }

  // TODO: Once we have benchmarked ShortNumberInfo, consider
  // if it is worth keeping this performance optimization.
  bool _matchesPossibleNumberAndNationalNumber(
      String number, PhoneNumberDesc numberDesc) {
    if (numberDesc.possibleLength.isNotEmpty &&
        !numberDesc.possibleLength.contains(number.length)) {
      return false;
    }
    return PhoneNumberUtil.matchNationalNumber(number, numberDesc, false);
  }
}
