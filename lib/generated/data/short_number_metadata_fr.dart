/// This is auto generated from ShortNumberMetadata.xml. Do not modify.
library;

Map<String, Object?> get shortNumberMetadataFR {
  return {
    "id": "FR",
    "country_code": 0,
    "international_prefix": null,
    "preferred_international_prefix": null,
    "national_prefix": null,
    "preferred_extn_prefix": null,
    "national_prefix_for_parsing": null,
    "national_prefix_transform_rule": null,
    "same_mobile_and_fixed_line_pattern": false,
    "main_country_for_code": false,
    "leading_digits": null,
    "mobile_number_portable_region": false,
    "general_desc": {
      "national_number_pattern": "[1-8]\\d{1,5}",
      "possible_length": [2, 3, 4, 5, 6],
      "possible_length_local_only": [],
      "example_number": null
    },
    "fixed_line": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "mobile": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "toll_free": {
      "national_number_pattern":
          "1(?:0(?:07|[13]3)|1[02459]|[578]|9[167])|224|(?:3370|74)0|(?:116\\d|3[01])\\d\\d",
      "possible_length": [2, 3, 4, 5, 6],
      "possible_length_local_only": [-1],
      "example_number": "15"
    },
    "premium_rate": {
      "national_number_pattern":
          "366\\d\\d|3[2-9]\\d\\d|(?:118|[4-8]\\d)\\d{3}",
      "possible_length": [4, 5, 6],
      "possible_length_local_only": [-1],
      "example_number": "3200"
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
      "national_number_pattern": "1(?:12|[578])",
      "possible_length": [2, 3],
      "possible_length_local_only": [-1],
      "example_number": "15"
    },
    "voicemail": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "short_code": {
      "national_number_pattern":
          "1(?:0\\d\\d|1(?:[02459]|6(?:000|111)|8\\d{3})|[578]|9[167])|2(?:0(?:00|2)0|24)|[3-8]\\d{4}|3\\d{3}|6(?:1[14]|34)|7(?:0[06]|22|40)",
      "possible_length": [2, 3, 4, 5, 6],
      "possible_length_local_only": [-1],
      "example_number": "15"
    },
    "standard_rate": {
      "national_number_pattern":
          "10(?:[134]4|2[23]|5\\d|99)|202\\d|634|70[06]|(?:106|61)[14]",
      "possible_length": [3, 4],
      "possible_length_local_only": [-1],
      "example_number": "611"
    },
    "carrier_specific": {
      "national_number_pattern":
          "118777|224|6(?:1[14]|34)|7(?:0[06]|22|40)|20(?:0\\d|2)\\d",
      "possible_length": [3, 4, 5, 6],
      "possible_length_local_only": [-1],
      "example_number": "224"
    },
    "sms_services": {
      "national_number_pattern": "114|[3-8]\\d{4}",
      "possible_length": [3, 5],
      "possible_length_local_only": [-1],
      "example_number": "114"
    },
    "no_international_dialling": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "number_format": [],
    "intl_number_format": []
  };
}
