/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.

Map<String, List<Object>> get phoneNumberMetadataTR {
  return {
    "metadata": [
      {
        "id": "TR",
        "country_code": 90,
        "international_prefix": "00",
        "preferred_international_prefix": null,
        "national_prefix": "0",
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "0",
        "national_prefix_transform_rule": null,
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": true,
        "general_desc": {
          "national_number_pattern":
              "4\\d{6}|8\\d{11,12}|(?:[2-58]\\d\\d|900)\\d{7}",
          "possible_length": [10, 12, 13, 7],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "(?:2(?:[13][26]|[28][2468]|[45][268]|[67][246])|3(?:[13][28]|[24-6][2468]|[78][02468]|92)|4(?:[16][246]|[23578][2468]|4[26]))\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "2123456789"
        },
        "mobile": {
          "national_number_pattern":
              "561(?:011|61\\d)\\d{4}|5(?:0[15-7]|1[06]|24|[34]\\d|5[1-59]|9[46])\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "5012345678"
        },
        "toll_free": {
          "national_number_pattern": "8(?:00\\d{7}(?:\\d{2,3})?|11\\d{7})",
          "possible_length": [10, 12, 13],
          "possible_length_local_only": [-1],
          "example_number": "8001234567"
        },
        "premium_rate": {
          "national_number_pattern": "(?:8[89]8|900)\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "9001234567"
        },
        "shared_cost": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "personal_number": {
          "national_number_pattern": "592(?:21[12]|461)\\d{4}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "5922121234"
        },
        "voip": {
          "national_number_pattern": "850\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "8500123456"
        },
        "pager": {
          "national_number_pattern": "512\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "5123456789"
        },
        "uan": {
          "national_number_pattern": "444\\d{4}",
          "possible_length": [7],
          "possible_length_local_only": [-1],
          "example_number": "4441444"
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
          "national_number_pattern": "(?:444|811\\d{3})\\d{4}",
          "possible_length": [7, 10],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "number_format": [
          {
            "pattern": "(\\d{3})(\\d)(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["444"],
            "national_prefix_optional_when_formatting": true,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["512|8[01589]|90"],
            "national_prefix_optional_when_formatting": true,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{2})(\\d{2})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": [
              "5(?:[0-59]|61)",
              "5(?:[0-59]|61[06])",
              "5(?:[0-59]|61[06]1)"
            ],
            "national_prefix_optional_when_formatting": true,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{2})(\\d{2})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["[24][1-8]|3[1-9]"],
            "national_prefix_optional_when_formatting": true,
            "national_prefix_formatting_rule": "(0\$1)",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{6,7})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["80"],
            "national_prefix_optional_when_formatting": true,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["512|8[01589]|90"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": true
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{2})(\\d{2})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": [
              "5(?:[0-59]|61)",
              "5(?:[0-59]|61[06])",
              "5(?:[0-59]|61[06]1)"
            ],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": true
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{2})(\\d{2})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["[24][1-8]|3[1-9]"],
            "national_prefix_formatting_rule": "(0\$1)",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": true
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{6,7})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["80"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": true
          }
        ]
      }
    ]
  };
}
