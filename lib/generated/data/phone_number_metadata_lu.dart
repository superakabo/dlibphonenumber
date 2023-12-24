/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataLU {
  return {
    "metadata": [
      {
        "id": "LU",
        "country_code": 352,
        "international_prefix": "00",
        "preferred_international_prefix": null,
        "national_prefix": null,
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing":
            "(15(?:0[06]|1[12]|[35]5|4[04]|6[26]|77|88|99)\\d)",
        "national_prefix_transform_rule": null,
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": true,
        "general_desc": {
          "national_number_pattern":
              "35[013-9]\\d{4,8}|6\\d{8}|35\\d{2,4}|(?:[2457-9]\\d|3[0-46-9])\\d{2,9}",
          "possible_length": [4, 5, 6, 7, 8, 9, 10, 11],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "(?:35[013-9]|80[2-9]|90[89])\\d{1,8}|(?:2[2-9]|3[0-46-9]|[457]\\d|8[13-9]|9[2-579])\\d{2,9}",
          "possible_length": [4, 5, 6, 7, 8, 9, 10, 11],
          "possible_length_local_only": [-1],
          "example_number": "27123456"
        },
        "mobile": {
          "national_number_pattern": "6(?:[269][18]|5[1568]|7[189]|81)\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "628123456"
        },
        "toll_free": {
          "national_number_pattern": "800\\d{5}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "80012345"
        },
        "premium_rate": {
          "national_number_pattern": "90[015]\\d{5}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "90012345"
        },
        "shared_cost": {
          "national_number_pattern": "801\\d{5}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "80112345"
        },
        "personal_number": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "voip": {
          "national_number_pattern": "20(?:1\\d{5}|[2-689]\\d{1,7})",
          "possible_length": [4, 5, 6, 7, 8, 9, 10],
          "possible_length_local_only": [-1],
          "example_number": "20201234"
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
            "format": "\$1 \$2",
            "leading_digits_pattern": [
              "2(?:0[2-689]|[2-9])|[3-57]|8(?:0[2-9]|[13-9])|9(?:0[89]|[2-579])"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1"
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{2})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": [
              "2(?:0[2-689]|[2-9])|[3-57]|8(?:0[2-9]|[13-9])|9(?:0[89]|[2-579])"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1"
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["20[2-689]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1"
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{1,2})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["2(?:[0367]|4[3-8])"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1"
          },
          {
            "pattern": "(\\d{3})(\\d{2})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["80[01]|90[015]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1"
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{3})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["20"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1"
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["6"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1"
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{2})(\\d{1,2})",
            "format": "\$1 \$2 \$3 \$4 \$5",
            "leading_digits_pattern": ["2(?:[0367]|4[3-8])"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1"
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{1,5})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": [
              "[3-57]|8[13-9]|9(?:0[89]|[2-579])|(?:2|80)[2-9]"
            ],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1"
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{2})(\\d{3})",
            "format": "\$1 \$2",
            "leading_digits_pattern": [
              "2(?:0[2-689]|[2-9])|[3-57]|8(?:0[2-9]|[13-9])|9(?:0[89]|[2-579])"
            ],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{2})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": [
              "2(?:0[2-689]|[2-9])|[3-57]|8(?:0[2-9]|[13-9])|9(?:0[89]|[2-579])"
            ],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["20[2-689]"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{1,2})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["2(?:[0367]|4[3-8])"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{2})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["80[01]|90[015]"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{3})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["20"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["6"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{2})(\\d{1,2})",
            "format": "\$1 \$2 \$3 \$4 \$5",
            "leading_digits_pattern": ["2(?:[0367]|4[3-8])"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{1,5})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": [
              "[3-57]|8[13-9]|9(?:0[89]|[2-579])|(?:2|80)[2-9]"
            ],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1",
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
