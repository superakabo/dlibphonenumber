/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.

Map<String, List<Object>> get phoneNumberMetadataRS {
  return {
    "metadata": [
      {
        "id": "RS",
        "country_code": 381,
        "international_prefix": "00",
        "preferred_international_prefix": null,
        "national_prefix": "0",
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "0",
        "national_prefix_transform_rule": null,
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": true,
        "general_desc": {
          "national_number_pattern":
              "38[02-9]\\d{6,9}|6\\d{7,9}|90\\d{4,8}|38\\d{5,6}|(?:7\\d\\d|800)\\d{3,9}|(?:[12]\\d|3[0-79])\\d{5,10}",
          "possible_length": [7, 8, 9, 10, 11, 12, 6],
          "possible_length_local_only": [4, 5, 6],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "(?:11[1-9]\\d|(?:2[389]|39)(?:0[2-9]|[2-9]\\d))\\d{3,8}|(?:1[02-9]|2[0-24-7]|3[0-8])[2-9]\\d{4,9}",
          "possible_length": [7, 8, 9, 10, 11, 12],
          "possible_length_local_only": [4, 5, 6],
          "example_number": "10234567"
        },
        "mobile": {
          "national_number_pattern": "6(?:[0-689]|7\\d)\\d{6,7}",
          "possible_length": [8, 9, 10],
          "possible_length_local_only": [-1],
          "example_number": "601234567"
        },
        "toll_free": {
          "national_number_pattern": "800\\d{3,9}",
          "possible_length": [6, 7, 8, 9, 10, 11, 12],
          "possible_length_local_only": [-1],
          "example_number": "80012345"
        },
        "premium_rate": {
          "national_number_pattern": "(?:78\\d|90[0169])\\d{3,7}",
          "possible_length": [6, 7, 8, 9, 10],
          "possible_length_local_only": [-1],
          "example_number": "90012345"
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
          "national_number_pattern": "7[06]\\d{4,10}",
          "possible_length": [6, 7, 8, 9, 10, 11, 12],
          "possible_length_local_only": [-1],
          "example_number": "700123456"
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
            "pattern": "(\\d{3})(\\d{3,9})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["(?:2[389]|39)0|[7-9]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{5,10})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["[1-36]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{3})(\\d{3,9})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["(?:2[389]|39)0|[7-9]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{5,10})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["[1-36]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
