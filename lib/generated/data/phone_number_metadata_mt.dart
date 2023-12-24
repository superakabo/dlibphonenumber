/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataMT {
  return {
    "metadata": [
      {
        "id": "MT",
        "country_code": 356,
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
          "national_number_pattern": "3550\\d{4}|(?:[2579]\\d\\d|800)\\d{5}",
          "possible_length": [8],
          "possible_length_local_only": [],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "20(?:3[1-4]|6[059])\\d{4}|2(?:0[19]|[1-357]\\d|60)\\d{5}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "21001234"
        },
        "mobile": {
          "national_number_pattern":
              "(?:7(?:210|[79]\\d\\d)|9(?:[29]\\d\\d|69[67]|8(?:1[1-3]|89|97)))\\d{4}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "96961234"
        },
        "toll_free": {
          "national_number_pattern": "800(?:02|[3467]\\d)\\d{3}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "80071234"
        },
        "premium_rate": {
          "national_number_pattern":
              "5(?:0(?:0(?:37|43)|(?:6\\d|70|9[0168])\\d)|[12]\\d0[1-5])\\d{3}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "50037123"
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
          "national_number_pattern": "3550\\d{4}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "35501234"
        },
        "pager": {
          "national_number_pattern": "7117\\d{4}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "71171234"
        },
        "uan": {
          "national_number_pattern": "501\\d{5}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "50112345"
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
            "leading_digits_pattern": ["[2357-9]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{4})(\\d{4})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["[2357-9]"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
