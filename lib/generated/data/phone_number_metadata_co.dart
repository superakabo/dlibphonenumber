/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.

Map<String, List<Object>> get phoneNumberMetadataCO {
  return {
    "metadata": [
      {
        "id": "CO",
        "country_code": 57,
        "international_prefix": "00(?:4(?:[14]4|56)|[579])",
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
          "national_number_pattern": "(?:60\\d\\d|9101)\\d{6}|(?:1\\d|3)\\d{9}",
          "possible_length": [10, 11],
          "possible_length_local_only": [7],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "601055(?:[0-4]\\d|50)\\d\\d|6010(?:[0-4]\\d|5[0-4])\\d{4}|60[124-8][2-9]\\d{6}",
          "possible_length": [10],
          "possible_length_local_only": [7],
          "example_number": "6012345678"
        },
        "mobile": {
          "national_number_pattern":
              "3333(?:0(?:0\\d|1[0-5])|[4-9]\\d\\d)\\d{3}|(?:3(?:24[1-9]|3(?:00|3[0-24-9]))|9101)\\d{6}|3(?:0[0-5]|1\\d|2[0-3]|5[01]|70)\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "3211234567"
        },
        "toll_free": {
          "national_number_pattern": "1800\\d{7}",
          "possible_length": [11],
          "possible_length_local_only": [-1],
          "example_number": "18001234567"
        },
        "premium_rate": {
          "national_number_pattern": "19(?:0[01]|4[78])\\d{7}",
          "possible_length": [11],
          "possible_length_local_only": [-1],
          "example_number": "19001234567"
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
            "leading_digits_pattern": ["3[0-357]|91"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "0\$CC \$1"
          },
          {
            "pattern": "(\\d)(\\d{3})(\\d{7})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["1"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
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
            "leading_digits_pattern": ["3[0-357]|91"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "0\$CC \$1",
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d)(\\d{3})(\\d{7})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["1"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
