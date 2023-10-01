/// This is auto generated from PhoneNumberMetadata.xml. Do not modify.

Map<String, List<Object>> get phoneNumberMetadataJE {
  return {
    "metadata": [
      {
        "id": "JE",
        "country_code": 44,
        "international_prefix": "00",
        "preferred_international_prefix": null,
        "national_prefix": "0",
        "preferred_extn_prefix": null,
        "national_prefix_for_parsing": "([0-24-8]\\d{5})\$|0",
        "national_prefix_transform_rule": "1534\$1",
        "same_mobile_and_fixed_line_pattern": false,
        "main_country_for_code": false,
        "leading_digits": null,
        "mobile_number_portable_region": false,
        "general_desc": {
          "national_number_pattern": "1534\\d{6}|(?:[3578]\\d|90)\\d{8}",
          "possible_length": [10],
          "possible_length_local_only": [6],
          "example_number": null
        },
        "fixed_line": {
          "national_number_pattern": "1534[0-24-8]\\d{5}",
          "possible_length": [10],
          "possible_length_local_only": [6],
          "example_number": "1534456789"
        },
        "mobile": {
          "national_number_pattern":
              "7(?:(?:(?:50|82)9|937)\\d|7(?:00[378]|97[7-9]))\\d{5}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "7797712345"
        },
        "toll_free": {
          "national_number_pattern": "80(?:07(?:35|81)|8901)\\d{4}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "8007354567"
        },
        "premium_rate": {
          "national_number_pattern":
              "(?:8(?:4(?:4(?:4(?:05|42|69)|703)|5(?:041|800))|7(?:0002|1206))|90(?:066[59]|1810|71(?:07|55)))\\d{4}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "9018105678"
        },
        "shared_cost": {
          "national_number_pattern": null,
          "possible_length": [-1],
          "possible_length_local_only": [-1],
          "example_number": null
        },
        "personal_number": {
          "national_number_pattern": "701511\\d{4}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "7015115678"
        },
        "voip": {
          "national_number_pattern": "56\\d{8}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "5612345678"
        },
        "pager": {
          "national_number_pattern":
              "76(?:464|652)\\d{5}|76(?:0[0-28]|2[356]|34|4[01347]|5[49]|6[0-369]|77|8[14]|9[139])\\d{6}",
          "possible_length": [10],
          "possible_length_local_only": [-1],
          "example_number": "7640123456"
        },
        "uan": {
          "national_number_pattern":
              "(?:3(?:0(?:07(?:35|81)|8901)|3\\d{4}|4(?:4(?:4(?:05|42|69)|703)|5(?:041|800))|7(?:0002|1206))|55\\d{4})\\d{4}",
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
