/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataLB {
  return {
    "metadata": [
      {
        "id": "LB",
        "country_code": 961,
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
          "national_number_pattern": "[27-9]\\d{7}|[13-9]\\d{6}",
          "possible_length": [7, 8],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "7(?:62|8[0-7]|9[04-9])\\d{4}|(?:[14-69]\\d|2(?:[14-69]\\d|[78][1-9])|7[2-57]|8[02-9])\\d{5}",
          "possible_length": [7, 8],
          "possible_length_local_only": [-1],
          "example_number": "1123456"
        },
        "mobile": {
          "national_number_pattern":
              "793(?:[01]\\d|2[0-4])\\d{3}|(?:(?:3|81)\\d|7(?:[01]\\d|6[013-9]|8[89]|9[12]))\\d{5}",
          "possible_length": [7, 8],
          "possible_length_local_only": [-1],
          "example_number": "71123456"
        },
        "toll_free": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "premium_rate": {
          "national_number_pattern": "9[01]\\d{6}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "90123456"
        },
        "shared_cost": {
          "national_number_pattern": "80\\d{6}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "80123456"
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
            "pattern": "(\\d)(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": [
              "[13-69]|7(?:[2-57]|62|8[0-7]|9[04-9])|8[02-9]"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[27-9]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d)(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": [
              "[13-69]|7(?:[2-57]|62|8[0-7]|9[04-9])|8[02-9]"
            ],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[27-9]"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
