/// This is auto generated from PhoneNumberMetadataForTesting.xml. Do not modify.

Map<String, List<Object>> get phoneNumberMetadataAR {
  return {
    "metadata": [
      {
        "id": "AR",
        "country_code": 54,
        "international_prefix": "00",
        "preferred_international_prefix": null,
        "national_prefix": "0",
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "0(?:(11|343|3715)15)?",
        "national_prefix_transform_rule": "9\$1",
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": false,
        "general_desc": {
          "national_number_pattern": "[1-3689]\\d{9,10}",
          "possible_length": [6, 7, 8, 9, 10, 11],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern": "[1-3]\\d{5,9}",
          "possible_length": [6, 7, 8, 9, 10],
          "possible_length_local_only": [-1],
          "example_number": "1234567890"
        },
        "mobile": {
          "national_number_pattern": "9\\d{10}|[1-3]\\d{9}",
          "possible_length": [10, 11],
          "possible_length_local_only": [-1],
          "example_number": "9234567890"
        },
        "toll_free": {
          "national_number_pattern": "80\\d{8}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "8034567890"
        },
        "premium_rate": {
          "national_number_pattern": "6(0\\d|10)\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "6234567890"
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
            "format": "\$1 \$2-\$3",
            "leading_digits_pattern": ["11"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{4})(\\d{2})(\\d{4})",
            "format": "\$1 \$2-\$3",
            "leading_digits_pattern": ["1[02-9]|[23]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d)(\\d{2})(\\d{4})(\\d{4})",
            "format": "\$2 15 \$3-\$4",
            "leading_digits_pattern": ["911"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$2",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d)(\\d{4})(\\d{2})(\\d{4})",
            "format": "\$2 \$3-\$4",
            "leading_digits_pattern": ["9(?:1[02-9]|[23])"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$2",
            "domestic_carrier_code_formatting_rule": "0\$2 \$CC"
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["[68]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{2})(\\d{4})(\\d{4})",
            "format": "\$1 \$2-\$3",
            "leading_digits_pattern": ["11"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{4})(\\d{2})(\\d{4})",
            "format": "\$1 \$2-\$3",
            "leading_digits_pattern": ["1[02-9]|[23]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d)(\\d{2})(\\d{4})(\\d{4})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["911"],
            "national_prefix_formatting_rule": "0\$2",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d)(\\d{4})(\\d{2})(\\d{4})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["9(?:1[02-9]|[23])"],
            "national_prefix_formatting_rule": "0\$2",
            "domestic_carrier_code_formatting_rule": "0\$2 \$CC",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["[68]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
