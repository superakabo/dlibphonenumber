/// This is auto generated from ShortNumberMetadata.xml. Do not modify.
library;

Map<String, Object?> get shortNumberMetadataSN {
  return {
    "id": "SN",
    "country_code": 0,
    "international_prefix": null,
    "preferred_international_prefix": null,
    "national_prefix": null,
    "preferred_extn_prefix": null,
    "national_prefix_for_parsing": null,
    "national_prefix_transform_rule": null,
    "same_mobile_and_fixed_line_pattern": false,
    "main_country_for_code": false,
    "leading_digits": null,
    "mobile_number_portable_region": false,
    "general_desc": {
      "national_number_pattern": "[12]\\d{1,5}",
      "possible_length": [2, 3, 4, 5, 6],
      "possible_length_local_only": [],
      "example_number": null
    },
    "fixed_line": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "mobile": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "toll_free": {
      "national_number_pattern": "1(?:515|[78])|2(?:00|1)\\d{3}",
      "possible_length": [2, 4, 5, 6],
      "possible_length_local_only": [-1],
      "example_number": "17"
    },
    "premium_rate": {
      "national_number_pattern": "2(?:0[246]|[468])\\d{3}",
      "possible_length": [5, 6],
      "possible_length_local_only": [-1],
      "example_number": "24000"
    },
    "shared_cost": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "personal_number": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "voip": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "pager": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "uan": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "emergency": {
      "national_number_pattern": "1[78]",
      "possible_length": [2],
      "possible_length_local_only": [-1],
      "example_number": "17"
    },
    "voicemail": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "short_code": {
      "national_number_pattern":
          "1(?:1[69]|(?:[246]\\d|51)\\d)|2(?:0[0-246]|[12468])\\d{3}|1[278]",
      "possible_length": [2, 3, 4, 5, 6],
      "possible_length_local_only": [-1],
      "example_number": "12"
    },
    "standard_rate": {
      "national_number_pattern": "2(?:01|2)\\d{3}",
      "possible_length": [5, 6],
      "possible_length_local_only": [-1],
      "example_number": "22000"
    },
    "carrier_specific": {
      "national_number_pattern": "1[46]\\d\\d",
      "possible_length": [4],
      "possible_length_local_only": [-1],
      "example_number": "1400"
    },
    "sms_services": {
      "national_number_pattern": "2[468]\\d{3}",
      "possible_length": [5],
      "possible_length_local_only": [-1],
      "example_number": "24000"
    },
    "no_international_dialling": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "number_format": [],
    "intl_number_format": []
  };
}
