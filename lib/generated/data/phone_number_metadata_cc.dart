/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataCC {
  return {
    "metadata": [
      {
        "id": "CC",
        "country_code": 61,
        "international_prefix":
            "001[14-689]|14(?:1[14]|34|4[17]|[56]6|7[47]|88)0011",
        "preferred_international_prefix": "0011",
        "national_prefix": "0",
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "([59]\\d{7})\$|0",
        "national_prefix_transform_rule": "8\$1",
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": false,
        "general_desc": {
          "national_number_pattern":
              "1(?:[0-79]\\d{8}(?:\\d{2})?|8[0-24-9]\\d{7})|[148]\\d{8}|1\\d{5,7}",
          "possible_length": [6, 7, 8, 9, 10, 12],
          "possible_length_local_only": [8],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "8(?:51(?:0(?:02|31|60|89)|1(?:18|76)|223)|91(?:0(?:1[0-2]|29)|1(?:[28]2|50|79)|2(?:10|64)|3(?:[06]8|22)|4[29]8|62\\d|70[23]|959))\\d{3}",
          "possible_length": [9],
          "possible_length_local_only": [8],
          "example_number": "891621234"
        },
        "mobile": {
          "national_number_pattern":
              "4(?:(?:79|94)[01]|83[0-389])\\d{5}|4(?:[0-3]\\d|4[047-9]|5[0-25-9]|6[0-36-9]|7[02-8]|8[0-24-9]|9[0-37-9])\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "412345678"
        },
        "toll_free": {
          "national_number_pattern": "180(?:0\\d{3}|2)\\d{3}",
          "possible_length": [7, 10],
          "possible_length_local_only": [-1],
          "example_number": "1800123456"
        },
        "premium_rate": {
          "national_number_pattern": "190[0-26]\\d{6}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "1900123456"
        },
        "shared_cost": {
          "national_number_pattern":
              "13(?:00\\d{6}(?:\\d{2})?|45[0-4]\\d{3})|13\\d{4}",
          "possible_length": [6, 8, 10, 12],
          "possible_length_local_only": [-1],
          "example_number": "1300123456"
        },
        "personal_number": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "voip": {
          "national_number_pattern": "14(?:5(?:1[0458]|[23][458])|71\\d)\\d{4}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "147101234"
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
