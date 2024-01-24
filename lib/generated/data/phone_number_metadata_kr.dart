/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataKR {
  return {
    "metadata": [
      {
        "id": "KR",
        "country_code": 82,
        "international_prefix":
            "00(?:[125689]|3(?:[46]5|91)|7(?:00|27|3|55|6[126]))",
        "preferred_international_prefix": null,
        "national_prefix": "0",
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "0(8(?:[1-46-8]|5\\d\\d))?",
        "national_prefix_transform_rule": null,
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": true,
        "general_desc": {
          "national_number_pattern":
              "00[1-9]\\d{8,11}|(?:[12]|5\\d{3})\\d{7}|[13-6]\\d{9}|(?:[1-6]\\d|80)\\d{7}|[3-6]\\d{4,5}|(?:00|7)0\\d{8}",
          "possible_length": [5, 6, 8, 9, 10, 11, 12, 13, 14],
          "possible_length_local_only": [3, 4, 7],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "(?:2|3[1-3]|[46][1-4]|5[1-5])[1-9]\\d{6,7}|(?:3[1-3]|[46][1-4]|5[1-5])1\\d{2,3}",
          "possible_length": [5, 6, 8, 9, 10],
          "possible_length_local_only": [3, 4, 7],
          "example_number": "22123456"
        },
        "mobile": {
          "national_number_pattern":
              "1(?:05(?:[0-8]\\d|9[0-6])|22[13]\\d)\\d{4,5}|1(?:0[0-46-9]|[16-9]\\d|2[013-9])\\d{6,7}",
          "possible_length": [9, 10],
          "possible_length_local_only": [-1],
          "example_number": "1020000000"
        },
        "toll_free": {
          "national_number_pattern":
              "00(?:308\\d{6,7}|798\\d{7,9})|(?:00368|80)\\d{7}",
          "possible_length": [9, 11, 12, 13, 14],
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
          "national_number_pattern": "50\\d{8,9}",
          "possible_length": [10, 11],
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
          "national_number_pattern": "15\\d{7,8}",
          "possible_length": [9, 10],
          "possible_length_local_only": [-1],
          "example_number": "1523456789"
        },
        "uan": {
          "national_number_pattern":
              "1(?:5(?:22|33|44|66|77|88|99)|6(?:[07]0|44|6[0168]|88)|8(?:00|33|55|77|99))\\d{4}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "15441234"
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
          "national_number_pattern":
              "00(?:3(?:08\\d{6,7}|68\\d{7})|798\\d{7,9})",
          "possible_length": [11, 12, 13, 14],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "number_format": [
          {
            "pattern": "(\\d{5})",
            "format": "\$1",
            "leading_digits_pattern": [
              "1[016-9]1",
              "1[016-9]11",
              "1[016-9]114"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{3,4})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["(?:3[1-3]|[46][1-4]|5[1-5])1"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": "0\$CC-\$1"
          },
          {
            "pattern": "(\\d{4})(\\d{4})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["1"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d)(\\d{3,4})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["2"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": "0\$CC-\$1"
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["60|8"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": "0\$CC-\$1"
          },
          {
            "pattern": "(\\d{2})(\\d{3,4})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["[1346]|5[1-5]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": "0\$CC-\$1"
          },
          {
            "pattern": "(\\d{2})(\\d{4})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["[57]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": "0\$CC-\$1"
          },
          {
            "pattern": "(\\d{5})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["003", "0030"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{5})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["5"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": "0\$CC-\$1"
          },
          {
            "pattern": "(\\d{5})(\\d{3,4})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["0"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{5})(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["0"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{2})(\\d{3,4})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["(?:3[1-3]|[46][1-4]|5[1-5])1"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": "0\$CC-\$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{4})(\\d{4})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["1"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d)(\\d{3,4})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["2"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": "0\$CC-\$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["60|8"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": "0\$CC-\$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{3,4})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["[1346]|5[1-5]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": "0\$CC-\$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{4})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["[57]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": "0\$CC-\$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{5})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["5"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": "0\$CC-\$1",
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
