/// This is auto generated from ShortNumberMetadata.xml. Do not modify.
library;

Map<String, Object?> get shortNumberMetadataIE {
  return {
    "id": "IE",
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
      "national_number_pattern": "[159]\\d{2,5}",
      "possible_length": [3, 4, 5, 6],
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
      "national_number_pattern": "11(?:2|6\\d{3})|999",
      "possible_length": [3, 6],
      "possible_length_local_only": [-1],
      "example_number": "112"
    },
    "premium_rate": {
      "national_number_pattern": "5[37]\\d{3}",
      "possible_length": [5],
      "possible_length_local_only": [-1],
      "example_number": "53000"
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
      "national_number_pattern": "112|999",
      "possible_length": [3],
      "possible_length_local_only": [-1],
      "example_number": "112"
    },
    "voicemail": {
      "national_number_pattern": null,
      "possible_length": [-1],
      "possible_length_local_only": [-1],
      "example_number": null
    },
    "short_code": {
      "national_number_pattern":
          "11(?:2|6(?:00[06]|1(?:1[17]|23)))|999|(?:1(?:18|9)|5[0137]\\d)\\d\\d",
      "possible_length": [3, 4, 5, 6],
      "possible_length_local_only": [-1],
      "example_number": "112"
    },
    "standard_rate": {
      "national_number_pattern": "51\\d{3}",
      "possible_length": [5],
      "possible_length_local_only": [-1],
      "example_number": "51000"
    },
    "carrier_specific": {
      "national_number_pattern": "51210",
      "possible_length": [5],
      "possible_length_local_only": [-1],
      "example_number": "51210"
    },
    "sms_services": {
      "national_number_pattern": "51210|(?:118|5[037]\\d)\\d\\d",
      "possible_length": [5],
      "possible_length_local_only": [-1],
      "example_number": "11800"
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
