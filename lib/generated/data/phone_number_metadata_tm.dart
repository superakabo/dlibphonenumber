/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataTM {
  return {
    "metadata": [
      {
        "id": "TM",
        "country_code": 993,
        "international_prefix": "810",
        "preferred_international_prefix": "8~10",
        "national_prefix": "8",
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "8",
        "national_prefix_transform_rule": null,
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": false,
        "general_desc": {
          "national_number_pattern": "(?:[1-6]\\d|71)\\d{6}",
          "possible_length": [8],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "(?:1(?:2\\d|3[1-9])|2(?:22|4[0-35-8])|3(?:22|4[03-9])|4(?:22|3[128]|4\\d|6[15])|5(?:22|5[7-9]|6[014-689]))\\d{5}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "12345678"
        },
        "mobile": {
          "national_number_pattern": "(?:6\\d|71)\\d{6}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "66123456"
        },
        "toll_free": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
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
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "number_format": [
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{2})",
            "format": "\$1 \$2-\$3-\$4",
            "leading_digits_pattern": ["12"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "(8 \$1)",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d)(\\d{2})(\\d{2})",
            "format": "\$1 \$2-\$3-\$4",
            "leading_digits_pattern": ["[1-5]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "(8 \$1)",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{6})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["[67]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "8 \$1",
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{2})",
            "format": "\$1 \$2-\$3-\$4",
            "leading_digits_pattern": ["12"],
            "national_prefix_formatting_rule": "(8 \$1)",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d)(\\d{2})(\\d{2})",
            "format": "\$1 \$2-\$3-\$4",
            "leading_digits_pattern": ["[1-5]"],
            "national_prefix_formatting_rule": "(8 \$1)",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{6})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["[67]"],
            "national_prefix_formatting_rule": "8 \$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
