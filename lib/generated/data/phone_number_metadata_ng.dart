/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataNG {
  return {
    "metadata": [
      {
        "id": "NG",
        "country_code": 234,
        "international_prefix": "009",
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
              "2[0-24-9]\\d{8}|[78]\\d{10,13}|[7-9]\\d{9}|[1-9]\\d{7}|[124-7]\\d{6}",
          "possible_length": [7, 8, 10, 11, 12, 13, 14],
          "possible_length_local_only": [5, 6],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "20(?:[1259]\\d|3[013-9]|4[1-8]|6[024-689]|7[1-79]|8[2-9])\\d{6}|(?:(?:[1-356]\\d|4[02-8]|8[2-9])\\d|9(?:0[3-9]|[1-9]\\d))\\d{5}|7(?:0(?:[013-689]\\d|2[0-24-9])\\d{3,4}|[1-79]\\d{6})|(?:[12]\\d|4[147]|5[14579]|6[1578]|7[1-3578])\\d{5}",
          "possible_length": [7, 8, 10],
          "possible_length_local_only": [5, 6],
          "example_number": "18040123"
        },
        "mobile": {
          "national_number_pattern":
              "(?:702[0-24-9]|819[01])\\d{6}|(?:7(?:0[13-9]|[12]\\d)|8(?:0[1-9]|1[0-8])|9(?:0[1-9]|1[1-6]))\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "8021234567"
        },
        "toll_free": {
          "national_number_pattern": "800\\d{7,11}",
          "possible_length": [10, 11, 12, 13, 14],
          "possible_length_local_only": [-1],
          "example_number": "80017591759"
        },
        "premium_rate": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
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
          "national_number_pattern": "700\\d{7,11}",
          "possible_length": [10, 11, 12, 13, 14],
          "possible_length_local_only": [-1],
          "example_number": "7001234567"
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
            "pattern": "(\\d{2})(\\d{2})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["78"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d)(\\d{3})(\\d{3,4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[12]|9(?:0[3-9]|[1-9])"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{2,3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[3-6]|7(?:0[0-689]|[1-79])|8[2-9]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{3,4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[7-9]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["20[129]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{4})(\\d{2})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["2"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{4})(\\d{4,5})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[78]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{5})(\\d{5,6})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[78]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["78"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d)(\\d{3})(\\d{3,4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[12]|9(?:0[3-9]|[1-9])"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{2,3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[3-6]|7(?:0[0-689]|[1-79])|8[2-9]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{3,4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[7-9]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["20[129]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{4})(\\d{2})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["2"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{4})(\\d{4,5})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[78]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{5})(\\d{5,6})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[78]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
