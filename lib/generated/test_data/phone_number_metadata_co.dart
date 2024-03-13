/// This is auto generated from PhoneNumberMetadataForTesting.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataCO {
  return {
    "metadata": [
      {
        "id": "CO",
        "country_code": 57,
        "international_prefix": null,
        "preferred_international_prefix": null,
        "national_prefix": "0",
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "0(4(?:[14]4|56)|[579])?",
        "national_prefix_transform_rule": null,
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": true,
        "general_desc": {
          "national_number_pattern": "(?:60|3\\d)\\d{8}",
          "possible_length": [10],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern": "60\\d{8}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "6012345678"
        },
        "mobile": {
          "national_number_pattern": "3(?:0[0-5]|1\\d|2[0-3]|5[01]|70)\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "3211234567"
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
            "pattern": "(\\d{3})(\\d{7})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["6"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "(\$1)",
            "domestic_carrier_code_formatting_rule": "0\$CC \$1"
          },
          {
            "pattern": "(\\d{3})(\\d{7})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["3"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "0\$CC \$1"
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{3})(\\d{7})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["6"],
            "national_prefix_formatting_rule": "(\$1)",
            "domestic_carrier_code_formatting_rule": "0\$CC \$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{7})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["3"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "0\$CC \$1",
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
