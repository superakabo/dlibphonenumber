/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.

Map<String, List<Object>> get phoneNumberMetadataPT {
  return {
    "metadata": [
      {
        "id": "PT",
        "country_code": 351,
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
          "national_number_pattern": "1693\\d{5}|(?:[26-9]\\d|30)\\d{7}",
          "possible_length": [9],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "2(?:[12]\\d|3[1-689]|4[1-59]|[57][1-9]|6[1-35689]|8[1-69]|9[1256])\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "212345678"
        },
        "mobile": {
          "national_number_pattern":
              "6(?:[06]92(?:30|9\\d)|[35]92(?:3[03]|9\\d))\\d{3}|(?:(?:16|6[0356])93|9(?:[1-36]\\d\\d|480))\\d{5}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "912345678"
        },
        "toll_free": {
          "national_number_pattern": "80[02]\\d{6}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "800123456"
        },
        "premium_rate": {
          "national_number_pattern":
              "(?:6(?:0[178]|4[68])\\d|76(?:0[1-57]|1[2-47]|2[237]))\\d{5}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "760123456"
        },
        "shared_cost": {
          "national_number_pattern": "80(?:8\\d|9[1579])\\d{5}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "808123456"
        },
        "personal_number": {
          "national_number_pattern": "884[0-4689]\\d{5}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "884123456"
        },
        "voip": {
          "national_number_pattern": "30\\d{7}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "301234567"
        },
        "pager": {
          "national_number_pattern": "6222\\d{5}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "622212345"
        },
        "uan": {
          "national_number_pattern": "70(?:38[01]|596|(?:7\\d|8[17])\\d)\\d{4}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "707123456"
        },
        "emergency": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "voicemail": {
          "national_number_pattern": "600\\d{6}|6[06]9233\\d{3}",
          "possible_length": [9],
          "possible_length_local_only": [-1],
          "example_number": "600110000"
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
            "pattern": "(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["2[12]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["16|[236-9]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["2[12]"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["16|[236-9]"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
