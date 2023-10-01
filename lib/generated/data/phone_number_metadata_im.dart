/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.

Map<String, List<Object>> get phoneNumberMetadataIM {
  return {
    "metadata": [
      {
        "id": "IM",
        "country_code": 44,
        "international_prefix": "00",
        "preferred_international_prefix": null,
        "national_prefix": "0",
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "([25-8]\\d{5})\$|0",
        "national_prefix_transform_rule": "1624\$1",
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": "74576|(?:16|7[56])24",
        "mobile_number_portable_region": false,
        "general_desc": {
          "national_number_pattern": "1624\\d{6}|(?:[3578]\\d|90)\\d{8}",
          "possible_length": [10],
          "possible_length_local_only": [6],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern": "1624(?:230|[5-8]\\d\\d)\\d{3}",
          "possible_length": [10],
          "possible_length_local_only": [6],
          "example_number": "1624756789"
        },
        "mobile": {
          "national_number_pattern":
              "76245[06]\\d{4}|7(?:4576|[59]24\\d|624[0-4689])\\d{5}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "7924123456"
        },
        "toll_free": {
          "national_number_pattern": "808162\\d{4}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "8081624567"
        },
        "premium_rate": {
          "national_number_pattern":
              "8(?:440[49]06|72299\\d)\\d{3}|(?:8(?:45|70)|90[0167])624\\d{4}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "9016247890"
        },
        "shared_cost": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "personal_number": {
          "national_number_pattern": "70\\d{8}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "7012345678"
        },
        "voip": {
          "national_number_pattern": "56\\d{8}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "5612345678"
        },
        "pager": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "uan": {
          "national_number_pattern":
              "3440[49]06\\d{3}|(?:3(?:08162|3\\d{4}|45624|7(?:0624|2299))|55\\d{4})\\d{4}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "5512345678"
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
        "number_format": [],
        "intl_number_format": []
      }
    ]
  };
}
