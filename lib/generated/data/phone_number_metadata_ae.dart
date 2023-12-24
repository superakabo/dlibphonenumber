/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataAE {
  return {
    "metadata": [
      {
        "id": "AE",
        "country_code": 971,
        "international_prefix": "00",
        "preferred_international_prefix": null,
        "national_prefix": "0",
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "0",
        "national_prefix_transform_rule": null,
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": false,
        "general_desc": {
          "national_number_pattern":
              "(?:[4-7]\\d|9[0-689])\\d{7}|800\\d{2,9}|[2-4679]\\d{7}",
          "possible_length": [8, 9, 5, 6, 7, 10, 11, 12],
          "possible_length_local_only": [7],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern": "[2-4679][2-8]\\d{6}",
          "possible_length": [8],
          "possible_length_local_only": [7],
          "example_number": "22345678"
        },
        "mobile": {
          "national_number_pattern": "5[024-68]\\d{7}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "501234567"
        },
        "toll_free": {
          "national_number_pattern": "400\\d{6}|800\\d{2,9}",
          "possible_length": [5, 6, 7, 8, 9, 10, 11, 12],
          "possible_length_local_only": [-1],
          "example_number": "800123456"
        },
        "premium_rate": {
          "national_number_pattern": "900[02]\\d{5}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "900234567"
        },
        "shared_cost": {
          "national_number_pattern": "700[05]\\d{5}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "700012345"
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
          "national_number_pattern": "600[25]\\d{5}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "600212345"
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
            "pattern": "(\\d{3})(\\d{2,9})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["60|8"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d)(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[236]|[479][2-8]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d)(\\d{5})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[479]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["5"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{3})(\\d{2,9})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["60|8"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d)(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[236]|[479][2-8]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d)(\\d{5})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[479]"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["5"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
