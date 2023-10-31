/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataVE {
  return {
    "metadata": [
      {
        "id": "VE",
        "country_code": 58,
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
          "national_number_pattern": "[68]00\\d{7}|(?:[24]\\d|[59]0)\\d{8}",
          "possible_length": [10],
          "possible_length_local_only": [7],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "(?:2(?:12|3[457-9]|[467]\\d|[58][1-9]|9[1-6])|[4-6]00)\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [7],
          "example_number": "2121234567"
        },
        "mobile": {
          "national_number_pattern": "4(?:1[24-8]|2[46])\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "4121234567"
        },
        "toll_free": {
          "national_number_pattern": "800\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "8001234567"
        },
        "premium_rate": {
          "national_number_pattern": "90[01]\\d{7}",
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
          "national_number_pattern": "501\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [7],
          "example_number": "5010123456"
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
            "pattern": "(\\d{3})(\\d{7})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["[24-689]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": "\$CC \$1"
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{3})(\\d{7})",
            "format": "\$1-\$2",
            "leading_digits_pattern": ["[24-689]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": "\$CC \$1",
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
