/// This is auto generated from PhoneNumberMetadataForTesting.xml. Do not modify.

Map<String, List<Object>> get phoneNumberMetadataJP {
  return {
    "metadata": [
      {
        "id": "JP",
        "country_code": 81,
        "international_prefix": "010",
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
          "national_number_pattern": "07\\d{5}|[1-357-9]\\d{3,10}",
          "possible_length": [4, 5, 6, 7, 8, 9, 10, 11],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern": "07\\d{5}|[1-357-9]\\d{3,10}",
          "possible_length": [4, 5, 6, 7, 8, 9, 10, 11],
          "possible_length_local_only": [-1],
          "example_number": "0712345"
        },
        "mobile": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "toll_free": {
          "national_number_pattern": "0777[01]\\d{2}",
          "possible_length": [7],
          "possible_length_local_only": [-1],
          "example_number": "0777012"
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
          "national_number_pattern": "[23]\\d{3}",
          "possible_length": [4],
          "possible_length_local_only": [-1],
          "example_number": "2123"
        },
        "number_format": [
          {
            "pattern": "(\\d{2})(\\d{4})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[57-9]0"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["[57-9]0"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": [
              "111|222|333",
              "(?:111|222|333)1",
              "(?:111|222|333)11"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{4})(\\d)(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": [
              "222|333",
              "2221|3332",
              "22212|3332",
              "222120|3332"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{2})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[23]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{4})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["077"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{4})",
            "format": "*\$1",
            "leading_digits_pattern": ["[23]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "\$1",
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{2})(\\d{4})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[57-9]0"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["[57-9]0"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": [
              "111|222|333",
              "(?:111|222|333)1",
              "(?:111|222|333)11"
            ],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{4})(\\d)(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": [
              "222|333",
              "2221|3332",
              "22212|3332",
              "222120|3332"
            ],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{2})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[23]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{4})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["077"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{4})",
            "format": "*\$1",
            "leading_digits_pattern": ["[23]"],
            "national_prefix_formatting_rule": "\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
