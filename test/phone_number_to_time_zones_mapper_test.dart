import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:test/test.dart';

import 'generated/metadata/timezone_metadata_map.dart';

// Set up some test numbers to re-use.
final PhoneNumber _auNumber = PhoneNumber()
  ..countryCode = (61)
  ..nationalNumber = Int64(236618300);

final PhoneNumber _caNumber = PhoneNumber()
  ..countryCode = (1)
  ..nationalNumber = Int64(6048406565);

final PhoneNumber _koNumber = PhoneNumber()
  ..countryCode = (82)
  ..nationalNumber = Int64(22123456);

final PhoneNumber _koInvalidNumber = PhoneNumber()
  ..countryCode = (82)
  ..nationalNumber = Int64(1234);

final PhoneNumber _usNumber1 = PhoneNumber()
  ..countryCode = (1)
  ..nationalNumber = Int64(6509600000);

final PhoneNumber _usNumber2 = PhoneNumber()
  ..countryCode = (1)
  ..nationalNumber = Int64(2128120000);

final PhoneNumber _usNumber3 = PhoneNumber()
  ..countryCode = (1)
  ..nationalNumber = Int64(6174240000);

final PhoneNumber _usInvalidNumber = PhoneNumber()
  ..countryCode = (1)
  ..nationalNumber = Int64(123456789);

final PhoneNumber _numberWithInvalidCountryCode = PhoneNumber()
  ..countryCode = (999)
  ..nationalNumber = Int64(2423651234);

final PhoneNumber _internationalTollFree = PhoneNumber()
  ..countryCode = (800)
  ..nationalNumber = Int64(12345678);

// NANPA time zones.
final String _chicagoTz = "America/Chicago";
final String _losAngelesTz = "America/Los_Angeles";
final String _newYorkTz = "America/New_York";
final String _winnipegTz = "America/Winnipeg";

// Non NANPA time zones.
final String _seoulTz = "Asia/Seoul";
final String _sydneyTz = "Australia/Sydney";

void main() {
  final prefixTimeZonesMapper = PhoneNumberToTimeZonesMapper(TimezoneMetadataMap.timezones);

  group('PhoneNumberToTimeZonesMapperTest', () {
    test('testGetTimeZonesForNumber', () {
      // Test with invalid numbers even when their country code prefixes exist in the mapper.
      expect(
        prefixTimeZonesMapper.getTimeZonesForNumber(_usInvalidNumber),
        PhoneNumberToTimeZonesMapper.unknownTimeZoneList,
      );
      expect(
        prefixTimeZonesMapper.getTimeZonesForNumber(_koInvalidNumber),
        PhoneNumberToTimeZonesMapper.unknownTimeZoneList,
      );
      // Test with valid prefixes.
      expect(
        prefixTimeZonesMapper.getTimeZonesForNumber(_auNumber),
        _buildListOfTimeZones([_sydneyTz]),
      );
      expect(
        prefixTimeZonesMapper.getTimeZonesForNumber(_koNumber),
        _buildListOfTimeZones([_seoulTz]),
      );
      expect(
        prefixTimeZonesMapper.getTimeZonesForNumber(_caNumber),
        _buildListOfTimeZones([_winnipegTz]),
      );
      expect(
        prefixTimeZonesMapper.getTimeZonesForNumber(_usNumber1),
        _buildListOfTimeZones([_losAngelesTz]),
      );
      expect(
        prefixTimeZonesMapper.getTimeZonesForNumber(_usNumber2),
        _buildListOfTimeZones([_newYorkTz]),
      );
      // Test with an invalid country code.
      expect(
        prefixTimeZonesMapper.getTimeZonesForNumber(_numberWithInvalidCountryCode),
        PhoneNumberToTimeZonesMapper.unknownTimeZoneList,
      );
      // Test with a non geographical phone number.
      expect(
        prefixTimeZonesMapper.getTimeZonesForNumber(_internationalTollFree),
        PhoneNumberToTimeZonesMapper.unknownTimeZoneList,
      );
    });

    test('testGetTimeZonesForValidNumber', () {
      // Test with invalid numbers even when their country code prefixes exist in the
      // mapper.
      expect(
        prefixTimeZonesMapper.getTimeZonesForGeographicalNumber(_usInvalidNumber),
        _getNanpaTimeZonesList(),
      );
      expect(
        prefixTimeZonesMapper.getTimeZonesForGeographicalNumber(_koInvalidNumber),
        _buildListOfTimeZones([_seoulTz]),
      );
      // Test with valid prefixes.
      expect(
        prefixTimeZonesMapper.getTimeZonesForGeographicalNumber(_auNumber),
        _buildListOfTimeZones([_sydneyTz]),
      );
      expect(
        prefixTimeZonesMapper.getTimeZonesForGeographicalNumber(_koNumber),
        _buildListOfTimeZones([_seoulTz]),
      );
      expect(
        prefixTimeZonesMapper.getTimeZonesForGeographicalNumber(_caNumber),
        _buildListOfTimeZones([_winnipegTz]),
      );
      expect(
        prefixTimeZonesMapper.getTimeZonesForGeographicalNumber(_usNumber1),
        _buildListOfTimeZones([_losAngelesTz]),
      );
      expect(
        prefixTimeZonesMapper.getTimeZonesForGeographicalNumber(_usNumber2),
        _buildListOfTimeZones([_newYorkTz]),
      );
      // Test with an invalid country code.
      expect(
        prefixTimeZonesMapper.getTimeZonesForGeographicalNumber(_numberWithInvalidCountryCode),
        PhoneNumberToTimeZonesMapper.unknownTimeZoneList,
      );
      // Test with a non geographical phone number.
      expect(
        prefixTimeZonesMapper.getTimeZonesForGeographicalNumber(_internationalTollFree),
        PhoneNumberToTimeZonesMapper.unknownTimeZoneList,
      );
    });

    test('testGetTimeZonesForValidNumberSearchingAtCountryCodeLevel', () {
      // Test that the country level time zones are returned when the number passed in
      // is valid but not covered by any non-country level prefixes in the mapper.
      expect(
        _getNanpaTimeZonesList(),
        prefixTimeZonesMapper.getTimeZonesForNumber(_usNumber3),
      );
    });
  });
}

List<String> _buildListOfTimeZones(List<String> timezones) {
  List<String> timezonesList = [];
  for (String timezone in timezones) {
    timezonesList.add(timezone);
  }
  return timezonesList;
}

List<String> _getNanpaTimeZonesList() {
  return _buildListOfTimeZones([
    _newYorkTz,
    _chicagoTz,
    _winnipegTz,
    _losAngelesTz,
  ]);
}
