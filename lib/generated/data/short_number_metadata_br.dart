/// This is auto generated from ShortNumberMetadata.xml. Do not modify.
library;

Map<String, Object?> get shortNumberMetadataBR {
  return {
    "id": "BR",
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
      "national_number_pattern": "[1-69]\\d{2,5}",
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
          "1(?:00|12|28|8[015]|9[0-47-9])|4(?:57|82\\d)|911",
      "possible_length": [3, 4],
      "possible_length_local_only": [-1],
      "example_number": "100"
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
      "national_number_pattern": "1(?:12|28|9[023])|911",
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
          "1(?:0(?:[02]|3(?:1[2-579]|2[13-9]|3[124-9]|4[1-3578]|5[1-468]|6[139]|8[149]|9[168])|5[0-35-9]|6(?:0|1[0-35-8]?|2[0145]|3[0137]?|4[37-9]?|5[0-35]|6[016]?|7[137]?|8[5-8]|9[1359]))|1[25-8]|2[357-9]|3[024-68]|4[12568]|5\\d|6[0-8]|8[015]|9[0-47-9])|2(?:7(?:330|878)|85959?)|(?:32|91)1|4(?:0404?|57|828)|55555|6(?:0\\d{4}|10000)|(?:133|411)[12]",
      "possible_length": [3, 4, 5, 6],
      "possible_length_local_only": [-1],
      "example_number": "100"
    },
    "standard_rate": {
      "national_number_pattern": "102|273\\d\\d|321",
      "possible_length": [3, 5],
      "possible_length_local_only": [-1],
      "example_number": "102"
    },
    "carrier_specific": {
      "national_number_pattern":
          "151|(?:278|555)\\d\\d|4(?:04\\d\\d?|11\\d|57)",
      "possible_length": [3, 4, 5],
      "possible_length_local_only": [-1],
      "example_number": "151"
    },
    "sms_services": {
      "national_number_pattern":
          "285\\d{2,3}|321|40404|(?:27[38]\\d|482)\\d|6(?:0\\d|10)\\d{3}",
      "possible_length": [3, 4, 5, 6],
      "possible_length_local_only": [-1],
      "example_number": "321"
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
