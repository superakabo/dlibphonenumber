/// This is auto generated from ShortNumberMetadata.xml. Do not modify.
library;

Map<String, Object?> get shortNumberMetadataBI {
  return {
    "id": "BI",
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
      "national_number_pattern": "[16-9]\\d{2,3}",
      "possible_length": [3, 4],
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
      "national_number_pattern": "11[237]|611",
      "possible_length": [3],
      "possible_length_local_only": [-1],
      "example_number": "112"
    },
    "premium_rate": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
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
      "national_number_pattern": "11[237]",
      "possible_length": [3],
      "possible_length_local_only": [-1],
      "example_number": "112"
    },
    "voicemail": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "short_code": {
      "national_number_pattern":
          "1(?:1\\d|5[2-9]|6[0-256])|611|7(?:10|77|979)|8[28]8|900",
      "possible_length": [3, 4],
      "possible_length_local_only": [-1],
      "example_number": "110"
    },
    "standard_rate": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "carrier_specific": {
      "national_number_pattern": "611|7(?:10|77)|888|900",
      "possible_length": [3],
      "possible_length_local_only": [-1],
      "example_number": "611"
    },
    "sms_services": {
      "national_number_pattern": "(?:71|90)0",
      "possible_length": [3],
      "possible_length_local_only": [-1],
      "example_number": "710"
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
