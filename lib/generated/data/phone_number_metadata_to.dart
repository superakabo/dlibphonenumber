/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataTO {
  return {
    "metadata": [
      {
        "id": "TO",
        "country_code": 676,
        "international_prefix": "00",
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
          "national_number_pattern":
              "(?:0800|(?:[5-8]\\d\\d|999)\\d)\\d{3}|[2-8]\\d{4}",
          "possible_length": [5, 7],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "(?:2\\d|3[0-8]|4[0-4]|50|6[09]|7[0-24-69]|8[05])\\d{3}",
          "possible_length": [5],
          "possible_length_local_only": [-1],
          "example_number": "20123"
        },
        "mobile": {
          "national_number_pattern":
              "(?:55[4-6]|6(?:[09]\\d|3[02]|8[15-9])|(?:7\\d|8[46-9])\\d|999)\\d{4}",
          "possible_length": [7],
          "possible_length_local_only": [-1],
          "example_number": "7715123"
        },
        "toll_free": {
          "national_number_pattern": "0800\\d{3}",
          "possible_length": [7],
          "possible_length_local_only": [-1],
          "example_number": "0800222"
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
          "national_number_pattern": "55[0-37-9]\\d{4}",
          "possible_length": [7],
          "possible_length_local_only": [-1],
          "example_number": "5510123"
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
            "pattern": "(\\d{2})(\\d{3})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["[2-4]|50|6[09]|7[0-24-69]|8[05]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{4})(\\d{3})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["0"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{4})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["[5-9]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{2})(\\d{3})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["[2-4]|50|6[09]|7[0-24-69]|8[05]"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{4})(\\d{3})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["0"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{4})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["[5-9]"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
