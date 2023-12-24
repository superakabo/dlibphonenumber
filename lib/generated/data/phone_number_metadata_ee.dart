/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataEE {
  return {
    "metadata": [
      {
        "id": "EE",
        "country_code": 372,
        "international_prefix": "00",
        "preferred_international_prefix": null,
        "national_prefix": null,
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": null,
        "national_prefix_transform_rule": null,
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": true,
        "general_desc": {
          "national_number_pattern":
              "8\\d{9}|[4578]\\d{7}|(?:[3-8]\\d|90)\\d{5}",
          "possible_length": [7, 8, 10],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern": "(?:3[23589]|4[3-8]|6\\d|7[1-9]|88)\\d{5}",
          "possible_length": [7],
          "possible_length_local_only": [-1],
          "example_number": "3212345"
        },
        "mobile": {
          "national_number_pattern":
              "(?:5\\d{5}|8(?:1(?:0(?:0(?:00|[178]\\d)|[3-9]\\d\\d)|(?:1(?:0[236]|1\\d)|(?:2[0-59]|[3-79]\\d)\\d)\\d)|2(?:0(?:0(?:00|4\\d)|(?:19|[2-7]\\d)\\d)|(?:(?:[124-6]\\d|3[5-9])\\d|7(?:[0-79]\\d|8[13-9])|8(?:[2-6]\\d|7[01]))\\d)|[349]\\d{4}))\\d\\d|5(?:(?:[02]\\d|5[0-478])\\d|1(?:[0-8]\\d|95)|6(?:4[0-4]|5[1-589]))\\d{3}",
          "possible_length": [7, 8],
          "possible_length_local_only": [-1],
          "example_number": "51234567"
        },
        "toll_free": {
          "national_number_pattern": "800(?:(?:0\\d\\d|1)\\d|[2-9])\\d{3}",
          "possible_length": [7, 8, 10],
          "possible_length_local_only": [-1],
          "example_number": "80012345"
        },
        "premium_rate": {
          "national_number_pattern": "(?:40\\d\\d|900)\\d{4}",
          "possible_length": [7, 8],
          "possible_length_local_only": [-1],
          "example_number": "9001234"
        },
        "shared_cost": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "personal_number": {
          "national_number_pattern": "70[0-2]\\d{5}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "70012345"
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
          "national_number_pattern": "800[2-9]\\d{3}",
          "possible_length": [7],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "number_format": [
          {
            "pattern": "(\\d{3})(\\d{4})",
            "format": "\$1 \$2",
            "leading_digits_pattern": [
              "[369]|4[3-8]|5(?:[0-2]|5[0-478]|6[45])|7[1-9]|88",
              "[369]|4[3-8]|5(?:[02]|1(?:[0-8]|95)|5[0-478]|6(?:4[0-4]|5[1-589]))|7[1-9]|88"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{4})(\\d{3,4})",
            "format": "\$1 \$2",
            "leading_digits_pattern": [
              "[45]|8(?:00|[1-49])",
              "[45]|8(?:00[1-9]|[1-49])"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["7"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{4})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["8"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{3})(\\d{4})",
            "format": "\$1 \$2",
            "leading_digits_pattern": [
              "[369]|4[3-8]|5(?:[0-2]|5[0-478]|6[45])|7[1-9]|88",
              "[369]|4[3-8]|5(?:[02]|1(?:[0-8]|95)|5[0-478]|6(?:4[0-4]|5[1-589]))|7[1-9]|88"
            ],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{4})(\\d{3,4})",
            "format": "\$1 \$2",
            "leading_digits_pattern": [
              "[45]|8(?:00|[1-49])",
              "[45]|8(?:00[1-9]|[1-49])"
            ],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["7"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{4})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["8"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
