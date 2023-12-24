/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataJO {
  return {
    "metadata": [
      {
        "id": "JO",
        "country_code": 962,
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
          "national_number_pattern": "(?:(?:[2689]|7\\d)\\d|32|53)\\d{6}",
          "possible_length": [8, 9],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "87(?:000|90[01])\\d{3}|(?:2(?:6(?:2[0-35-9]|3[0-578]|4[24-7]|5[0-24-8]|[6-8][023]|9[0-3])|7(?:0[1-79]|10|2[014-7]|3[0-689]|4[019]|5[0-3578]))|32(?:0[1-69]|1[1-35-7]|2[024-7]|3\\d|4[0-3]|[5-7][023])|53(?:0[0-3]|[13][023]|2[0-59]|49|5[0-35-9]|6[15]|7[45]|8[1-6]|9[0-36-9])|6(?:2(?:[05]0|22)|3(?:00|33)|4(?:0[0-25]|1[2-7]|2[0569]|[38][07-9]|4[025689]|6[0-589]|7\\d|9[0-2])|5(?:[01][056]|2[034]|3[0-57-9]|4[178]|5[0-69]|6[0-35-9]|7[1-379]|8[0-68]|9[0239]))|87(?:20|7[078]|99))\\d{4}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "62001234"
        },
        "mobile": {
          "national_number_pattern": "7(?:[78][0-25-9]|9\\d)\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "790123456"
        },
        "toll_free": {
          "national_number_pattern": "80\\d{6}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "80012345"
        },
        "premium_rate": {
          "national_number_pattern": "9\\d{7}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "90012345"
        },
        "shared_cost": {
          "national_number_pattern": "85\\d{6}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "85012345"
        },
        "personal_number": {
          "national_number_pattern": "70\\d{7}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "700123456"
        },
        "voip": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "pager": {
          "national_number_pattern": "74(?:66|77)\\d{5}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "746612345"
        },
        "uan": {
          "national_number_pattern": "8(?:10|8\\d)\\d{5}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "88101234"
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
            "pattern": "(\\d)(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[2356]|87"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "(0\$1)",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{5,6})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["[89]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{7})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["70"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d)(\\d{4})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["7"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d)(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[2356]|87"],
            "national_prefix_formatting_rule": "(0\$1)",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{5,6})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["[89]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{7})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["70"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d)(\\d{4})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["7"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
