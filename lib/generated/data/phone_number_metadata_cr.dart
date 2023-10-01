/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.

Map<String, List<Object>> get phoneNumberMetadataCR {
  return {
    "metadata": [
      {
        "id": "CR",
        "country_code": 506,
        "international_prefix": "00",
        "preferred_international_prefix": null,
        "national_prefix": null,
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "(19(?:0[0-2468]|1[09]|20|66|77|99))",
        "national_prefix_transform_rule": null,
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": false,
        "general_desc": {
          "national_number_pattern":
              "(?:8\\d|90)\\d{8}|(?:[24-8]\\d{3}|3005)\\d{4}",
          "possible_length": [8, 10],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "210[7-9]\\d{4}|2(?:[024-7]\\d|1[1-9])\\d{5}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "22123456"
        },
        "mobile": {
          "national_number_pattern":
              "(?:3005\\d|6500[01])\\d{3}|(?:5[07]|6[0-4]|7[0-3]|8[3-9])\\d{6}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "83123456"
        },
        "toll_free": {
          "national_number_pattern": "800\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "8001234567"
        },
        "premium_rate": {
          "national_number_pattern": "90[059]\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "9001234567"
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
          "national_number_pattern": "(?:210[0-6]|4\\d{3}|5100)\\d{4}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "40001234"
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
            "pattern": "(\\d{4})(\\d{4})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["[2-7]|8[3-9]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1"
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["[89]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1"
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{4})(\\d{4})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["[2-7]|8[3-9]"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{4})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["[89]"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1",
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
