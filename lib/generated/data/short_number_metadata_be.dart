/// This is auto generated from ShortNumberMetadata.xml. Do not modify.
library;

Map<String, Object?> get shortNumberMetadataBE {
  return {
    "id": "BE",
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
      "national_number_pattern": "[1-9]\\d\\d(?:\\d(?:\\d{2})?)?",
      "possible_length": [3, 4, 6],
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
      "national_number_pattern":
          "1(?:0[0-35-8]|1[0269]|7(?:12|77)|813)|(?:116|8)\\d{3}",
      "possible_length": [3, 4, 6],
      "possible_length_local_only": [-1],
      "example_number": "100"
    },
    "premium_rate": {
      "national_number_pattern":
          "1(?:2[03]|40)4|(?:1(?:[24]1|3[01])|[2-79]\\d\\d)\\d",
      "possible_length": [4],
      "possible_length_local_only": [-1],
      "example_number": "1204"
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
      "national_number_pattern": "1(?:0[01]|12)",
      "possible_length": [3],
      "possible_length_local_only": [-1],
      "example_number": "100"
    },
    "voicemail": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "short_code": {
      "national_number_pattern":
          "1(?:0[0-8]|16117|2(?:12|3[0-24])|313|414|5(?:1[05]|5[15]|66|95)|6(?:1[167]|36|6[16])|7(?:[07][017]|1[27-9]|22|33|65)|81[39])|[2-9]\\d{3}|11[02679]|1(?:1600|45)0|1(?:[2-4]9|78)9|1[2-4]0[47]",
      "possible_length": [3, 4, 6],
      "possible_length_local_only": [-1],
      "example_number": "100"
    },
    "standard_rate": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "carrier_specific": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "sms_services": {
      "national_number_pattern": "[2-9]\\d{3}",
      "possible_length": [4],
      "possible_length_local_only": [-1],
      "example_number": "2000"
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
