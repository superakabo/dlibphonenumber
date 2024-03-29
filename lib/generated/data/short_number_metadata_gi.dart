/// This is auto generated from ShortNumberMetadata.xml. Do not modify.
library;

Map<String, Object?> get shortNumberMetadataGI {
  return {
    "id": "GI",
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
      "national_number_pattern": "[158]\\d{2,5}",
      "possible_length": [3, 4, 5, 6],
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
          "1(?:00|1[25]|23|4(?:1|7\\d)|5[15]|9[02-49])|555|(?:116\\d|80)\\d\\d",
      "possible_length": [3, 4, 6],
      "possible_length_local_only": [-1],
      "example_number": "100"
    },
    "premium_rate": {
      "national_number_pattern": "8[1-69]\\d\\d",
      "possible_length": [4],
      "possible_length_local_only": [-1],
      "example_number": "8100"
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
      "national_number_pattern": "1(?:12|9[09])",
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
          "1(?:00|1(?:[25]|6(?:00[06]|1(?:1[17]|23))|8\\d\\d)|23|4(?:1|7[014])|5[015]|9[02-49])|555|8[0-79]\\d\\d|8(?:00|4[0-2]|8[0-589])",
      "possible_length": [3, 4, 5, 6],
      "possible_length_local_only": [-1],
      "example_number": "100"
    },
    "standard_rate": {
      "national_number_pattern": "150|87\\d\\d",
      "possible_length": [3, 4],
      "possible_length_local_only": [-1],
      "example_number": "150"
    },
    "carrier_specific": {
      "national_number_pattern":
          "1(?:00|1(?:5|8\\d\\d)|23|51|9[2-4])|555|8(?:00|4[0-2]|8[0-589])",
      "possible_length": [3, 5],
      "possible_length_local_only": [-1],
      "example_number": "100"
    },
    "sms_services": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
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
