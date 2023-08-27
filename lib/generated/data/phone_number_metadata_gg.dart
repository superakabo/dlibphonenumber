/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.

Map<String, List<Object>> get phoneNumberMetadataGG {
  return {
    "metadata": [
      {
        "id": "GG",
        "country_code": 44,
        "international_prefix": "00",
        "preferred_international_prefix": null,
        "national_prefix": "0",
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "([25-9]\\d{5})\$|0",
        "national_prefix_transform_rule": "1481\$1",
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": false,
        "general_desc": {
          "national_number_pattern":
              "(?:1481|[357-9]\\d{3})\\d{6}|8\\d{6}(?:\\d{2})?",
          "possible_length": [10, 7, 9],
          "possible_length_local_only": [6],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern": "1481[25-9]\\d{5}",
          "possible_length": [10],
          "possible_length_local_only": [6],
          "example_number": "1481256789"
        },
        "mobile": {
          "national_number_pattern": "7(?:(?:781|839)\\d|911[17])\\d{5}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "7781123456"
        },
        "toll_free": {
          "national_number_pattern": "80[08]\\d{7}|800\\d{6}|8001111",
          "possible_length": [7, 9, 10],
          "possible_length_local_only": [-1],
          "example_number": "8001234567"
        },
        "premium_rate": {
          "national_number_pattern":
              "(?:8(?:4[2-5]|7[0-3])|9(?:[01]\\d|8[0-3]))\\d{7}|845464\\d",
          "possible_length": [7, 10],
          "possible_length_local_only": [-1],
          "example_number": "9012345678"
        },
        "shared_cost": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "personal_number": {
          "national_number_pattern": "70\\d{8}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "7012345678"
        },
        "voip": {
          "national_number_pattern": "56\\d{8}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "5612345678"
        },
        "pager": {
          "national_number_pattern":
              "76(?:464|652)\\d{5}|76(?:0[0-28]|2[356]|34|4[01347]|5[49]|6[0-369]|77|8[14]|9[139])\\d{6}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "7640123456"
        },
        "uan": {
          "national_number_pattern": "(?:3[0347]|55)\\d{8}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "5512345678"
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
