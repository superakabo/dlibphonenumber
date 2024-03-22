/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataIL {
  return {
    "metadata": [
      {
        "id": "IL",
        "country_code": 972,
        "international_prefix": "0(?:0|1[2-9])",
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
              "1\\d{6}(?:\\d{3,5})?|[57]\\d{8}|[1-489]\\d{7}",
          "possible_length": [7, 8, 9, 10, 11, 12],
          "possible_length_local_only": [7],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "153\\d{8,9}|29[1-9]\\d{5}|(?:2[0-8]|[3489]\\d)\\d{6}",
          "possible_length": [8, 11, 12],
          "possible_length_local_only": [7],
          "example_number": "21234567"
        },
        "mobile": {
          "national_number_pattern":
              "55410\\d{4}|5(?:(?:[02][02-9]|[149][2-9]|[36]\\d|8[3-7])\\d|5(?:01|2\\d|3[0-3]|4[34]|5[0-25689]|6[6-8]|7[0-267]|8[7-9]|9[1-9]))\\d{5}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "502345678"
        },
        "toll_free": {
          "national_number_pattern": "1(?:255|80[019]\\d{3})\\d{3}",
          "possible_length": [7, 10],
          "possible_length_local_only": [-1],
          "example_number": "1800123456"
        },
        "premium_rate": {
          "national_number_pattern": "1212\\d{4}|1(?:200|9(?:0[0-2]|19))\\d{6}",
          "possible_length": [8, 10],
          "possible_length_local_only": [-1],
          "example_number": "1919123456"
        },
        "shared_cost": {
          "national_number_pattern": "1700\\d{6}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "1700123456"
        },
        "personal_number": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "voip": {
          "national_number_pattern":
              "7(?:38(?:0\\d|5[09]|88)|8(?:33|55|77|81)\\d)\\d{4}|7(?:18|2[23]|3[237]|47|6[258]|7\\d|82|9[2-9])\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "771234567"
        },
        "pager": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "uan": {
          "national_number_pattern": "1599\\d{6}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "1599123456"
        },
        "emergency": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "voicemail": {
          "national_number_pattern": "151\\d{8,9}",
          "possible_length": [11, 12],
          "possible_length_local_only": [-1],
          "example_number": "15112340000"
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
          "national_number_pattern": "1700\\d{6}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "number_format": [
          {
            "pattern": "(\\d{4})(\\d{3})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["125"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{4})(\\d{2})(\\d{2})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["121"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d)(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["[2-489]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["[57]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{4})(\\d{3})(\\d{3})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["12"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{4})(\\d{6})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["159"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d)(\\d{3})(\\d{3})(\\d{3})",
            "format": "\$1-\$2-\$3-\$4",
            "leading_digits_pattern": ["1[7-9]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{1,2})(\\d{3})(\\d{4})",
            "format": "\$1-\$2 \$3-\$4",
            "leading_digits_pattern": ["15"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{4})(\\d{3})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["125"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{4})(\\d{2})(\\d{2})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["121"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d)(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["[2-489]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["[57]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{4})(\\d{3})(\\d{3})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["12"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{4})(\\d{6})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["159"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d)(\\d{3})(\\d{3})(\\d{3})",
            "format": "\$1-\$2-\$3-\$4",
            "leading_digits_pattern": ["1[7-9]"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{1,2})(\\d{3})(\\d{4})",
            "format": "\$1-\$2 \$3-\$4",
            "leading_digits_pattern": ["15"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
