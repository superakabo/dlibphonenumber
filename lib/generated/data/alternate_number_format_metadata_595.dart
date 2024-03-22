/// This is auto generated from PhoneNumberAlternateFormats.xml. Do not modify.
library;

Map<String, Object?> get alternateNumberFormatMetadata595 {
  return {
    "id": "",
    "country_code": 595,
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
        "pattern": "(\\d{2})(\\d{2})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": ["[26]1|3[289]|4[1246-8]|7[1-3]|8[1-36]"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{2})(\\d{6,7})",
        "format": "\$1 \$2",
        "leading_digits_pattern": [
          "2[14-68]|3[26-9]|4[1246-8]|6(?:1|75)|7[1-35]|8[1-36]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{6})",
        "format": "\$1 \$2",
        "leading_digits_pattern": [
          "2[279]|3[13-5]|4[359]|5[1-5]|6(?:[34]|7[1-46-8])|7[46-8]|85"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      }
    ],
    "intl_number_format": [
      {
        "pattern": "(\\d{2})(\\d{2})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": ["[26]1|3[289]|4[1246-8]|7[1-3]|8[1-36]"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{6,7})",
        "format": "\$1 \$2",
        "leading_digits_pattern": [
          "2[14-68]|3[26-9]|4[1246-8]|6(?:1|75)|7[1-35]|8[1-36]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{6})",
        "format": "\$1 \$2",
        "leading_digits_pattern": [
          "2[279]|3[13-5]|4[359]|5[1-5]|6(?:[34]|7[1-46-8])|7[46-8]|85"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      }
    ]
  };
}
