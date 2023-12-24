/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataBB {
  return {
    "metadata": [
      {
        "id": "BB",
        "country_code": 1,
        "international_prefix": "011",
        "preferred_international_prefix": null,
        "national_prefix": "1",
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "([2-9]\\d{6})\$|1",
        "national_prefix_transform_rule": "246\$1",
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": "246",
        "mobile_number_portable_region": true,
        "general_desc": {
          "national_number_pattern": "(?:246|[58]\\d\\d|900)\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [7],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "246521[0369]\\d{3}|246(?:2(?:2[78]|7[0-4])|4(?:1[024-6]|2\\d|3[2-9])|5(?:20|[34]\\d|54|7[1-3])|6(?:2\\d|38)|7[35]7|9(?:1[89]|63))\\d{4}",
          "possible_length": [10],
          "possible_length_local_only": [7],
          "example_number": "2464123456"
        },
        "mobile": {
          "national_number_pattern":
              "246(?:(?:2(?:[3568]\\d|4[0-57-9])|3(?:5[2-9]|6[0-6])|4(?:46|5\\d)|69[5-7]|8(?:[2-5]\\d|83))\\d|52(?:1[147]|20))\\d{3}",
          "possible_length": [10],
          "possible_length_local_only": [7],
          "example_number": "2462501234"
        },
        "toll_free": {
          "national_number_pattern": "8(?:00|33|44|55|66|77|88)[2-9]\\d{6}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "8002123456"
        },
        "premium_rate": {
          "national_number_pattern": "(?:246976|900[2-9]\\d\\d)\\d{4}",
          "possible_length": [10],
          "possible_length_local_only": [7],
          "example_number": "9002123456"
        },
        "shared_cost": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "personal_number": {
          "national_number_pattern":
              "52(?:3(?:[2-46-9][02-9]\\d|5(?:[02-46-9]\\d|5[0-46-9]))|4(?:[2-478][02-9]\\d|5(?:[034]\\d|2[024-9]|5[0-46-9])|6(?:0[1-9]|[2-9]\\d)|9(?:[05-9]\\d|2[0-5]|49)))\\d{4}|52[34][2-9]1[02-9]\\d{4}|5(?:00|2[125-9]|33|44|66|77|88)[2-9]\\d{6}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "5002345678"
        },
        "voip": {
          "national_number_pattern": "24631\\d{5}",
          "possible_length": [10],
          "possible_length_local_only": [7],
          "example_number": "2463101234"
        },
        "pager": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "uan": {
          "national_number_pattern":
              "246(?:292|367|4(?:1[7-9]|3[01]|4[47-9]|67)|7(?:1[2-9]|2\\d|3[016]|53))\\d{4}",
          "possible_length": [10],
          "possible_length_local_only": [7],
          "example_number": "2464301234"
        },
        "emergency": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "voicemail": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "short_code": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
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
      }
    ]
  };
}
