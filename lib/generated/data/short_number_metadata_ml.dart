/// This is auto generated from ShortNumberMetadata.xml. Do not modify.
library;

Map<String, Object?> get shortNumberMetadataML {
  return {
    "id": "ML",
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
      "national_number_pattern": "[136-8]\\d{1,4}",
      "possible_length": [2, 3, 4, 5],
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
      "national_number_pattern": "1[578]|(?:352|67)00|7402|(?:677|744|8000)\\d",
      "possible_length": [2, 4, 5],
      "possible_length_local_only": [-1],
      "example_number": "15"
    },
    "premium_rate": {
      "national_number_pattern":
          "(?:12|800)2\\d|3(?:52(?:11|2[02]|3[04-6]|99)|7574)",
      "possible_length": [4, 5],
      "possible_length_local_only": [-1],
      "example_number": "1220"
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
      "national_number_pattern": "1[578]",
      "possible_length": [2],
      "possible_length_local_only": [-1],
      "example_number": "15"
    },
    "voicemail": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "short_code": {
      "national_number_pattern":
          "1(?:1(?:[013-9]\\d|2)|2(?:1[02-469]|2[13])|[578])|350(?:35|57)|67(?:0[09]|[59]9|77|8[89])|74(?:0[02]|44|55)|800[0-2][12]|3(?:52|[67]\\d)\\d\\d",
      "possible_length": [2, 3, 4, 5],
      "possible_length_local_only": [-1],
      "example_number": "15"
    },
    "standard_rate": {
      "national_number_pattern": "37(?:433|575)|7400|8001\\d",
      "possible_length": [4, 5],
      "possible_length_local_only": [-1],
      "example_number": "7400"
    },
    "carrier_specific": {
      "national_number_pattern": "3503\\d|(?:3[67]\\d|800)\\d\\d",
      "possible_length": [5],
      "possible_length_local_only": [-1],
      "example_number": "35030"
    },
    "sms_services": {
      "national_number_pattern":
          "374(?:0[24-9]|[1-9]\\d)|7400|3(?:6\\d|75)\\d\\d",
      "possible_length": [4, 5],
      "possible_length_local_only": [-1],
      "example_number": "7400"
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
