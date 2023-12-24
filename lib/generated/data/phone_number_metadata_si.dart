/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.

Map<String, List<Object>> get phoneNumberMetadataSI {
  return {
    "metadata": [
      {
        "id": "SI",
        "country_code": 386,
        "international_prefix": "00|10(?:22|66|88|99)",
        "preferred_international_prefix": "00",
        "national_prefix": "0",
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "0",
        "national_prefix_transform_rule": null,
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": true,
        "general_desc": {
          "national_number_pattern": "[1-7]\\d{7}|8\\d{4,7}|90\\d{4,6}",
          "possible_length": [8, 6, 7, 5],
          "possible_length_local_only": [7],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern": "(?:[1-357][2-8]|4[24-8])\\d{6}",
          "possible_length": [8],
          "possible_length_local_only": [7],
          "example_number": "12345678"
        },
        "mobile": {
          "national_number_pattern":
              "65(?:[178]\\d|5[56]|6[01])\\d{4}|(?:[37][01]|4[0139]|51|6[489])\\d{6}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "31234567"
        },
        "toll_free": {
          "national_number_pattern": "80\\d{4,6}",
          "possible_length": [6, 7, 8],
          "possible_length_local_only": [-1],
          "example_number": "80123456"
        },
        "premium_rate": {
          "national_number_pattern": "89[1-3]\\d{2,5}|90\\d{4,6}",
          "possible_length": [5, 6, 7, 8],
          "possible_length_local_only": [-1],
          "example_number": "90123456"
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
          "national_number_pattern":
              "(?:59\\d\\d|8(?:1(?:[67]\\d|8[0-589])|2(?:0\\d|2[0-37-9]|8[0-2489])|3[389]\\d))\\d{4}",
          "possible_length": [8],
          "possible_length_local_only": [-1],
          "example_number": "59012345"
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
            "pattern": "(\\d{2})(\\d{3,6})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["8[09]|9"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{3})(\\d{5})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["59|8"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[37][01]|4[0139]|51|6"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null
          },
          {
            "pattern": "(\\d)(\\d{3})(\\d{2})(\\d{2})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["[1-57]"],
            "national_prefix_optional_when_formatting": false,
            "national_prefix_formatting_rule": "(0\$1)",
            "domestic_carrier_code_formatting_rule": null
          }
        ],
        "intl_number_format": [
          {
            "pattern": "(\\d{2})(\\d{3,6})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["8[09]|9"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{3})(\\d{5})",
            "format": "\$1 \$2",
            "leading_digits_pattern": ["59|8"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d{2})(\\d{3})(\\d{3})",
            "format": "\$1 \$2 \$3",
            "leading_digits_pattern": ["[37][01]|4[0139]|51|6"],
            "national_prefix_formatting_rule": "0\$1",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          },
          {
            "pattern": "(\\d)(\\d{3})(\\d{2})(\\d{2})",
            "format": "\$1 \$2 \$3 \$4",
            "leading_digits_pattern": ["[1-57]"],
            "national_prefix_formatting_rule": "(0\$1)",
            "domestic_carrier_code_formatting_rule": null,
            "national_prefix_optional_when_formatting": false
          }
        ]
      }
    ]
  };
}
