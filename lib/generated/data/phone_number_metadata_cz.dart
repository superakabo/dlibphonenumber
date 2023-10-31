/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataCZ {
  return {
    "metadata": [
      {
        "id": "CZ",
        "country_code": 420,
        "international_prefix": "00",
        "preferred_international_prefix": null,
        "national_prefix": null,
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": null,
        "national_prefix_transform_rule": null,
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": true,
        "general_desc": {
          "national_number_pattern": "(?:[2-578]\\d|60)\\d{7}|9\\d{8,11}",
          "possible_length": [9, 10, 11, 12],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern": "(?:2\\d|3[1257-9]|4[16-9]|5[13-9])\\d{7}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "212345678"
        },
        "mobile": {
          "national_number_pattern": "(?:60[1-8]|7(?:0[2-5]|[2379]\\d))\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "601123456"
        },
        "toll_free": {
          "national_number_pattern": "800\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "800123456"
        },
        "premium_rate": {
          "national_number_pattern": "9(?:0[05689]|76)\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "900123456"
        },
        "shared_cost": {
          "national_number_pattern": "8[134]\\d{7}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "811234567"
        },
        "personal_number": {
          "national_number_pattern": "70[01]\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "700123456"
        },
        "voip": {
          "national_number_pattern": "9[17]0\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "910123456"
        },
        "pager": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "uan": {
          "national_number_pattern": "9(?:5\\d|7[2-4])\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "972123456"
        },
        "emergency": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "voicemail": {
          "national_number_pattern": "9(?:3\\d{9}|6\\d{7,10})",
          "possible_length": [9, 10, 11, 12],
          "possible_length_local_only": [-1],
          "example_number": "93123456789"
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
            "pattern": "(\\d{3})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[2-8]|9[015-7]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{3})(\\d{2})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["96"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["9"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["9"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[2-8]|9[015-7]"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{3})(\\d{2})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["96"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["9"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["9"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
