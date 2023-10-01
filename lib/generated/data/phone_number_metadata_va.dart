/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.

Map<String, List<Object>> get phoneNumberMetadataVA {
  return {
    "metadata": [
      {
        "id": "VA",
        "country_code": 39,
        "international_prefix": "00",
        "preferred_international_prefix": null,
        "national_prefix": null,
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": null,
        "national_prefix_transform_rule": null,
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": "06698",
        "mobile_number_portable_region": true,
        "general_desc": {
          "national_number_pattern":
              "0\\d{5,10}|3[0-8]\\d{7,10}|55\\d{8}|8\\d{5}(?:\\d{2,4})?|(?:1\\d|39)\\d{7,8}",
          "possible_length": [6, 7, 8, 9, 10, 11, 12],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern": "06698\\d{1,6}",
          "possible_length": [6, 7, 8, 9, 10, 11],
          "possible_length_local_only": [-1],
          "example_number": "0669812345"
        },
        "mobile": {
          "national_number_pattern": "3[1-9]\\d{8}|3[2-9]\\d{7}",
          "possible_length": [9, 10],
          "possible_length_local_only": [-1],
          "example_number": "3123456789"
        },
        "toll_free": {
          "national_number_pattern": "80(?:0\\d{3}|3)\\d{3}",
          "possible_length": [6, 9],
          "possible_length_local_only": [-1],
          "example_number": "800123456"
        },
        "premium_rate": {
          "national_number_pattern":
              "(?:0878\\d{3}|89(?:2\\d|3[04]|4(?:[0-4]|[5-9]\\d\\d)|5[0-4]))\\d\\d|(?:1(?:44|6[346])|89(?:38|5[5-9]|9))\\d{6}",
          "possible_length": [6, 8, 9, 10],
          "possible_length_local_only": [-1],
          "example_number": "899123456"
        },
        "shared_cost": {
          "national_number_pattern": "84(?:[08]\\d{3}|[17])\\d{3}",
          "possible_length": [6, 9],
          "possible_length_local_only": [-1],
          "example_number": "848123456"
        },
        "personal_number": {
          "national_number_pattern": "1(?:78\\d|99)\\d{6}",
          "possible_length": [9, 10],
          "possible_length_local_only": [-1],
          "example_number": "1781234567"
        },
        "voip": {
          "national_number_pattern": "55\\d{8}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "5512345678"
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
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "voicemail": {
          "national_number_pattern": "3[2-8]\\d{9,10}",
          "possible_length": [11, 12],
          "possible_length_local_only": [-1],
          "example_number": "33101234501"
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
