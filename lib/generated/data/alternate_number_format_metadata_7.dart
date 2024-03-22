/// This is auto generated from PhoneNumberAlternateFormats.xml. Do not modify.
library;

Map<String, Object?> get alternateNumberFormatMetadata7 {
  return {
    "id": "",
    "country_code": 7,
    "international_prefix": null,
    "preferred_international_prefix": null,
    "national_prefix": null,
    "preferred_extn_prefix": null,
    "national_prefix_for_parsing": null,
    "national_prefix_transform_rule": null,
    "same_mobile_and_fixed_line_pattern": false,
    "main_country_for_code": false,
    "leading_digits": null,
    "mobile_number_portable_region": false,
    "general_desc": {
      "national_number_pattern": null,
      "possible_length": [],
      "possible_length_local_only": [],
      "example_number": null
    },
    "fixed_line": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "mobile": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
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
        "pattern": "(\\d{4})(\\d{3})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": [
          "[3489]|7(?:1(?:[0-356]2|4[29]|7|8[27])|2(?:1[23]|[2-9]2))"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{5})(\\d{5})",
        "format": "\$1 \$2",
        "leading_digits_pattern": [
          "[3489]|72(?:6|7[457])|7(?:12|2[49])[35]|7(?:1[13-58]|2[1-38])[3-5]|7(?:1[06]|25)[3-6]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["7(?:1|2(?:[1-689]|7[2457]))"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{2})(\\d{2})(\\d{3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "[3489]|7(?:[04-9]|1(?:04|[236]3|4[3-5]|5[34])|2(?:13|34|7[39]))"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d)(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4 \$5",
        "leading_digits_pattern": [
          "[3489]|7(?:[04-9]|1(?:04|[236]3|4[3-5]|5[34])|2(?:13|34|7[39]))"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{4})(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["[3489]"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      }
    ],
    "intl_number_format": [
      {
        "pattern": "(\\d{4})(\\d{3})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": [
          "[3489]|7(?:1(?:[0-356]2|4[29]|7|8[27])|2(?:1[23]|[2-9]2))"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{5})(\\d{5})",
        "format": "\$1 \$2",
        "leading_digits_pattern": [
          "[3489]|72(?:6|7[457])|7(?:12|2[49])[35]|7(?:1[13-58]|2[1-38])[3-5]|7(?:1[06]|25)[3-6]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["7(?:1|2(?:[1-689]|7[2457]))"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{2})(\\d{2})(\\d{3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "[3489]|7(?:[04-9]|1(?:04|[236]3|4[3-5]|5[34])|2(?:13|34|7[39]))"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d)(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4 \$5",
        "leading_digits_pattern": [
          "[3489]|7(?:[04-9]|1(?:04|[236]3|4[3-5]|5[34])|2(?:13|34|7[39]))"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["[3489]"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      }
    ]
  };
}
