/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.
library;

Map<String, List<Object>> get phoneNumberMetadataID {
  return {
    "metadata": [
      {
        "id": "ID",
        "country_code": 62,
        "international_prefix": "00[89]",
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
          "national_number_pattern":
              "(?:(?:00[1-9]|8\\d)\\d{4}|[1-36])\\d{6}|00\\d{10}|[1-9]\\d{8,10}|[2-9]\\d{7}",
          "possible_length": [7, 8, 9, 10, 11, 12, 13],
          "possible_length_local_only": [5, 6],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern":
              "2[124]\\d{7,8}|619\\d{8}|2(?:1(?:14|500)|2\\d{3})\\d{3}|61\\d{5,8}|(?:2(?:[35][1-4]|6[0-8]|7[1-6]|8\\d|9[1-8])|3(?:1|[25][1-8]|3[1-68]|4[1-3]|6[1-3568]|7[0-469]|8\\d)|4(?:0[1-589]|1[01347-9]|2[0-36-8]|3[0-24-68]|43|5[1-378]|6[1-5]|7[134]|8[1245])|5(?:1[1-35-9]|2[25-8]|3[124-9]|4[1-3589]|5[1-46]|6[1-8])|6(?:[25]\\d|3[1-69]|4[1-6])|7(?:02|[125][1-9]|[36]\\d|4[1-8]|7[0-36-9])|9(?:0[12]|1[013-8]|2[0-479]|5[125-8]|6[23679]|7[159]|8[01346]))\\d{5,8}",
          "possible_length": [7, 8, 9, 10, 11],
          "possible_length_local_only": [5, 6],
          "example_number": "218350123"
        },
        "mobile": {
          "national_number_pattern": "8[1-35-9]\\d{7,10}",
          "possible_length": [9, 10, 11, 12],
          "possible_length_local_only": [-1],
          "example_number": "812345678"
        },
        "toll_free": {
          "national_number_pattern":
              "00[17]803\\d{7}|(?:177\\d|800)\\d{5,7}|001803\\d{6}",
          "possible_length": [8, 9, 10, 11, 12, 13],
          "possible_length_local_only": [-1],
          "example_number": "8001234567"
        },
        "premium_rate": {
          "national_number_pattern": "809\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "8091234567"
        },
        "shared_cost": {
          "national_number_pattern": "804\\d{7}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "8041234567"
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
          "national_number_pattern": "(?:1500|8071\\d{3})\\d{3}",
          "possible_length": [7, 10],
          "possible_length_local_only": [-1],
          "example_number": "8071123456"
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
          "national_number_pattern": "001803\\d{6,7}|(?:007803\\d|8071)\\d{6}",
          "possible_length": [10, 12, 13],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "number_format": [
          {
            "pattern": "(\\d)(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["15"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{5,9})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["2[124]|[36]1"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "(0\$1)",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{5,7})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["800"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{5,8})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["[2-79]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "(0\$1)",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{3,4})(\\d{3})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["8[1-35-9]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{6,8})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["1"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["804"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d)(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["80"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{4})(\\d{4,5})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["8"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["001"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{4})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["0"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d)(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["15"],
            "national_prefix_formatting_rule": null,
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{5,9})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["2[124]|[36]1"],
            "national_prefix_formatting_rule": "(0\$1)",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{5,7})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["800"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{5,8})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["[2-79]"],
            "national_prefix_formatting_rule": "(0\$1)",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{3,4})(\\d{3})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["8[1-35-9]"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{6,8})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["1"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{3})(\\d{4})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["804"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d)(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["80"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{4})(\\d{4,5})",
            "format": "\$1-\$2-\$3",
            "leading_digits_pattern": ["8"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
