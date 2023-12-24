/// This is auto generated from PhoneNumberMetadataForTesting.xml. Do not modify.

Map<String, List<Object>> get phoneNumberMetadataKR {
  return {
    "metadata": [
      {
        "id": "KR",
        "country_code": 82,
        "international_prefix": "00(?:[124-68]|[37]\\d{2})",
        "preferred_international_prefix": null,
        "national_prefix": "0",
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "0(8[1-46-8]|85\\d{2})?",
        "national_prefix_transform_rule": null,
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": false,
        "general_desc": {
          "national_number_pattern": "[1-7]\\d{3,9}|8\\d{8}",
          "possible_length": [4, 5, 6, 7, 8, 9, 10],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "(?:2|[34][1-3]|5[1-5]|6[1-4])(?:1\\d{2,3}|[2-9]\\d{6,7})",
          "possible_length": [4, 5, 6, 7, 8, 9, 10],
          "possible_length_local_only": [-1],
          "example_number": "22123456"
        },
        "mobile": {
          "national_number_pattern": "1[0-25-9]\\d{7,8}",
          "possible_length": [9, 10],
          "possible_length_local_only": [-1],
          "example_number": "1023456789"
        },
        "toll_free": {
          "national_number_pattern": "80\\d{7}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "801234567"
        },
        "premium_rate": {
          "national_number_pattern": "60[2-9]\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "602345678"
        },
        "shared_cost": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "personal_number": {
          "national_number_pattern": "50\\d{8}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "5012345678"
        },
        "voip": {
          "national_number_pattern": "70\\d{8}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "7012345678"
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
        "number_format": [
          {
            "pattern": "(\\d{2})(\\d{4})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": [
              "1(?:0|1[19]|[69]9|5[458])|[57]0",
              "1(?:0|1[19]|[69]9|5(?:44|59|8))|[57]0"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": [
              "1(?:[169][2-8]|[78]|5[1-4])|[68]0|[3-6][1-9][2-9]",
              "1(?:[169][2-8]|[78]|5(?:[1-3]|4[56]))|[68]0|[3-6][1-9][2-9]"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d)(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["131", "1312"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{2})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["131", "131[13-9]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["13[2-9]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3-\$4",
            "leading_digits_pattern": ["30"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d)(\\d{4})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": [
              "2(?:[26]|3[0-467])",
              "2(?:[26]|3(?:01|1[45]|2[17-9]|39|4|6[67]|7[078]))"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d)(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": [
              "2(?:3[0-35-9]|[457-9])",
              "2(?:3(?:0[02-9]|1[0-36-9]|2[02-6]|3[0-8]|6[0-589]|7[1-69]|[589])|[457-9])"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d)(\\d{3})",
            "format": "\$1-\$2",
            "leading_digits_pattern": [
              "21[0-46-9]",
              "21(?:[0-247-9]|3[124]|6[1269])"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d)(\\d{4})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["21[36]", "21(?:3[035-9]|6[03-578])"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{3})",
            "format": "\$1-\$2",
            "leading_digits_pattern": [
              "[3-6][1-9]1",
              "[3-6][1-9]1(?:[0-46-9])",
              "[3-6][1-9]1(?:[0-247-9]|3[124]|6[1269])"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{4})",
            "format": "\$1-\$2",
            "leading_digits_pattern": [
              "[3-6][1-9]1",
              "[3-6][1-9]1[36]",
              "[3-6][1-9]1(?:3[035-9]|6[03-578])"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{2})(\\d{4})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": [
              "1(?:0|1[19]|[69]9|5[458])|[57]0",
              "1(?:0|1[19]|[69]9|5(?:44|59|8))|[57]0"
            ],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": [
              "1(?:[169][2-8]|[78]|5[1-4])|[68]0|[3-6][1-9][2-9]",
              "1(?:[169][2-8]|[78]|5(?:[1-3]|4[56]))|[68]0|[3-6][1-9][2-9]"
            ],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d)(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["131", "1312"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{2})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["131", "131[13-9]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["13[2-9]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3-\$4",
            "leading_digits_pattern": ["30"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d)(\\d{4})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": [
              "2(?:[26]|3[0-467])",
              "2(?:[26]|3(?:01|1[45]|2[17-9]|39|4|6[67]|7[078]))"
            ],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d)(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": [
              "2(?:3[0-35-9]|[457-9])",
              "2(?:3(?:0[02-9]|1[0-36-9]|2[02-6]|3[0-8]|6[0-589]|7[1-69]|[589])|[457-9])"
            ],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d)(\\d{3})",
            "format": "\$1-\$2",
            "leading_digits_pattern": [
              "21[0-46-9]",
              "21(?:[0-247-9]|3[124]|6[1269])"
            ],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d)(\\d{4})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["21[36]", "21(?:3[035-9]|6[03-578])"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{3})",
            "format": "\$1-\$2",
            "leading_digits_pattern": [
              "[3-6][1-9]1",
              "[3-6][1-9]1(?:[0-46-9])",
              "[3-6][1-9]1(?:[0-247-9]|3[124]|6[1269])"
            ],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{4})",
            "format": "\$1-\$2",
            "leading_digits_pattern": [
              "[3-6][1-9]1",
              "[3-6][1-9]1[36]",
              "[3-6][1-9]1(?:3[035-9]|6[03-578])"
            ],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
