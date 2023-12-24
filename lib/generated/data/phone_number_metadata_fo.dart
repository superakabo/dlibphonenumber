/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataFO {
  return {
    "metadata": [
      {
        "id": "FO",
        "country_code": 298,
        "international_prefix": "00",
        "preferred_international_prefix": null,
        "national_prefix": null,
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "(10(?:01|[12]0|88))",
        "national_prefix_transform_rule": null,
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": false,
        "general_desc": {
          "national_number_pattern": "[2-9]\\d{5}",
          "possible_length": [6],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern": "(?:20|[34]\\d|8[19])\\d{4}",
          "possible_length": [6],
          "possible_length_local_only": [-1],
          "example_number": "201234"
        },
        "mobile": {
          "national_number_pattern": "(?:[27][1-9]|5\\d|9[16])\\d{4}",
          "possible_length": [6],
          "possible_length_local_only": [-1],
          "example_number": "211234"
        },
        "toll_free": {
          "national_number_pattern": "80[257-9]\\d{3}",
          "possible_length": [6],
          "possible_length_local_only": [-1],
          "example_number": "802123"
        },
        "premium_rate": {
          "national_number_pattern": "90(?:[13-5][15-7]|2[125-7]|9\\d)\\d\\d",
          "possible_length": [6],
          "possible_length_local_only": [-1],
          "example_number": "901123"
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
          "national_number_pattern": "(?:6[0-36]|88)\\d{4}",
          "possible_length": [6],
          "possible_length_local_only": [-1],
          "example_number": "601234"
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
            "pattern": "(\\d{6})",
            "format": "\$1",
            "leading_digits_pattern": ["[2-9]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1"
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{6})",
            "format": "\$1",
            "leading_digits_pattern": ["[2-9]"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": "\$CC \$1",
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
