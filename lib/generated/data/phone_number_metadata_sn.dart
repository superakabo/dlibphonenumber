/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataSN {
  return {
    "metadata": [
      {
        "id": "SN",
        "country_code": 221,
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
          "national_number_pattern": "(?:[378]\\d|93)\\d{7}",
          "possible_length": [9],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "3(?:0(?:1[0-2]|80)|282|3(?:8[1-9]|9[3-9])|611)\\d{5}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "301012345"
        },
        "mobile": {
          "national_number_pattern":
              "7(?:(?:[06-8]\\d|21|90)\\d|5(?:01|[19]0|25|[38]3|[4-7]\\d))\\d{5}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "701234567"
        },
        "toll_free": {
          "national_number_pattern": "800\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "800123456"
        },
        "premium_rate": {
          "national_number_pattern": "88[4689]\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "884123456"
        },
        "shared_cost": {
          "national_number_pattern": "81[02468]\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "810123456"
        },
        "personal_number": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "voip": {
          "national_number_pattern":
              "(?:3(?:392|9[01]\\d)\\d|93(?:3[13]0|929))\\d{4}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "933301234"
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
            "pattern": "(\\d{3})(\\d{2})(\\d{2})(\\d{2})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["8"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{2})(\\d{2})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["[379]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{3})(\\d{2})(\\d{2})(\\d{2})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["8"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{2})(\\d{2})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["[379]"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
