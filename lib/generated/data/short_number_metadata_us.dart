/// This is auto generated from ShortNumberMetadata.xml. Do not modify.
library;

Map<String, Object?> get shortNumberMetadataUS {
  return {
    "id": "US",
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
      "national_number_pattern": "[1-9]\\d{2,5}",
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
      "national_number_pattern": "112|611|9(?:11|33|88)",
      "possible_length": [3],
      "possible_length_local_only": [-1],
      "example_number": "112"
    },
    "premium_rate": {
      "national_number_pattern":
          "24280|(?:381|968)35|4(?:3355|7553|8221)|5(?:(?:489|934)2|5928)|72078|(?:323|960)40|(?:276|414)63|(?:2(?:520|744)|7390|9968)9|(?:693|732|976)88|(?:3(?:556|825)|5294|8623|9729)4|(?:3378|4136|7642|8961|9979)6|(?:4(?:6(?:15|32)|827)|(?:591|720)8|9529)7",
      "possible_length": [5],
      "possible_length_local_only": [-1],
      "example_number": "24280"
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
      "national_number_pattern": "112|911",
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
          "11(?:2|5[1-47]|[68]\\d|7[0-57]|98)|[2-9]\\d{3,5}|[2-8]11|9(?:11|33|88)",
      "possible_length": [3, 4, 5, 6],
      "possible_length_local_only": [-1],
      "example_number": "112"
    },
    "standard_rate": {
      "national_number_pattern":
          "2(?:3333|(?:4224|7562|900)2|56447|6688)|3(?:1010|2665|7404)|40404|560560|6(?:0060|22639|5246|7622)|7(?:0701|3822|4666)|8(?:(?:3825|7226)5|4816)|99099",
      "possible_length": [5, 6],
      "possible_length_local_only": [-1],
      "example_number": "23333"
    },
    "carrier_specific": {
      "national_number_pattern": "336\\d\\d|[2-9]\\d{3}|[2356]11",
      "possible_length": [3, 4, 5],
      "possible_length_local_only": [-1],
      "example_number": "211"
    },
    "sms_services": {
      "national_number_pattern": "[2-9]\\d{4,5}",
      "possible_length": [5, 6],
      "possible_length_local_only": [-1],
      "example_number": "20000"
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
