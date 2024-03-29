/// This is auto generated from PhoneNumberAlternateFormats.xml. Do not modify.
library;

Map<String, Object?> get alternateNumberFormatMetadata49 {
  return {
    "id": "",
    "country_code": 49,
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
      "national_number_pattern": null,
      "possible_length": [],
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
        "pattern": "(\\d{2})(\\d{3})(\\d{3,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": ["3[02]|40|[68]9"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4 \$5",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:0|3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|4[01]|50|6[09]|7(?:0|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6]|9)|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{2})(\\d{4})(\\d{3,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": ["3[02]|40|[68]9"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{2})(\\d{3})(\\d{2})(\\d{1,2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["3[02]|40|[68]9"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{2})(\\d{3})(\\d{3})(\\d{2,3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["3[02]|40|[68]9"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d)(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4 \$5 \$6",
        "leading_digits_pattern": ["3[02]|40|[68]9"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{2,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": [
          "2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]|[68][1-8])1"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{4})(\\d{3,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": [
          "2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]|[68][1-8])1"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{2})(\\d{2})(\\d{1,2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]|[68][1-8])1"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{2})(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4 \$5",
        "leading_digits_pattern": [
          "2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]|[68][1-8])1"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]|[68][1-8])1"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{2})(\\d{2})(\\d)",
        "format": "\$1 \$2 \$3 \$4 \$5",
        "leading_digits_pattern": [
          "2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]|[68][1-8])1"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{3})(\\d{2,3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]|[68][1-8])1"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{4})(\\d{3})(\\d{1,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|[56]0|7(?:0[2-8]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|66[2-9]|7(?:1[2-9]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|[5-8]0|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{2})(\\d{2})(\\d)(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4 \$5",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|66[2-9]|7(?:1[2-9]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|[5-8]0|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{2})(\\d{2})(\\d)(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4 \$5 \$6",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|[56]0|7(?:0[2-8]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4 \$5 \$6",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|7(?:8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|[5-7]0|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{4})(\\d{4})(\\d{1,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|[56]0|7(?:0[2-8]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{4})(\\d{3})(\\d{3})(\\d{3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|3[1468]|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]|9[1468]))|4(?:1|5[02-6]|9[2-6])|7(?:8[02-5]|9[03-7])|8(?:3[02-46-9]|4[02-6]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|[5-7]0|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{4})(\\d{2})(\\d{3})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "15[1279]|2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|[56]0|7(?:0[2-8]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{4})(\\d{3})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|[56]0|7(?:0[2-8]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{4})(\\d{2})(\\d{2})(\\d{2,3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|[56]0|7(?:0[2-8]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{5})(\\d{3})(\\d{3,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": [
          "3(?:3(?:0[589]|2[03]|3[369]|4[357]|6[0357]|7[0346]|8[347]|9[236-8])|4(?:4[2469]|6[03579]|9[0257])|5(?:0[235]|2[046]|[49][357]|6[09]|7[2579]|8[2479])|6(?:2[05]|3[37]|6[02459]|7[03468]|8[47]|9[246])|7(?:2[09]|4[236]|60|75)|8(?:2[0239]|3[023579]|7[23589]|8[2457])|9(?:0[03568]|3[24689]|4[0258]|60|7[2457]|8[23568]|9[23579]))|3[68]4[2568]|3(?:47|60)[2478]|3[49]2[02469]|3[457]3[2468]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{5})(\\d{4})(\\d{3,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": [
          "3(?:3(?:0[589]|2[03]|3[369]|4[357]|6[0357]|7[0346]|8[347]|9[236-8])|4(?:4[2469]|6[03579]|9[0257])|5(?:0[235]|2[046]|[49][357]|6[09]|7[2579]|8[2479])|6(?:2[05]|3[37]|6[02459]|7[03468]|8[47]|9[246])|7(?:2[09]|4[236]|60|75)|8(?:2[0239]|3[023579]|7[23589]|8[2457])|9(?:0[03568]|3[24689]|4[0258]|60|7[2457]|8[23568]|9[23579]))|3[68]4[2568]|3(?:47|60)[2478]|3[49]2[02469]|3[457]3[2468]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{5})(\\d{3})(\\d{3})(\\d{3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "3(?:3(?:0[589]|2[03]|3[369]|4[357]|6[0357]|7[0346]|8[347]|9[236-8])|4(?:4[2469]|6[03579]|9[0257])|5(?:0[235]|2[046]|[49][357]|6[09]|7[2579]|8[2479])|6(?:2[05]|3[37]|6[02459]|7[03468]|8[47]|9[246])|7(?:2[09]|4[236]|60|75)|8(?:2[0239]|3[023579]|7[23589]|8[2457])|9(?:0[03568]|3[24689]|4[0258]|60|7[2457]|8[23568]|9[23579]))|3[68]4[2568]|3(?:47|60)[2478]|3[49]2[02469]|3[457]3[2468]"
        ],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{4})(\\d{3})(\\d{4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": ["15[1279]"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{4})(\\d{4})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": ["15[1279]"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{8})",
        "format": "\$1 \$2",
        "leading_digits_pattern": ["15[1279]"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{3})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["15[1279]"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{3})(\\d)",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["1[67]|800"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{2,3})(\\d{3})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["1[67]|800"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{4})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": ["800"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{2})(\\d{2,3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["800"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d{6})(\\d{2})(\\d{1,4})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["800"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d)(\\d{3})(\\d{3,4})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["900"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d)(\\d{4})(\\d{3,4})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["900"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{3})(\\d)(\\d{3})(\\d{3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["180"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{4})(\\d{4,6})",
        "format": "\$1 \$2",
        "leading_digits_pattern": ["180"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{4})(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["180"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      },
      {
        "pattern": "(\\d{4})(\\d{4,10})",
        "format": "\$1 \$2",
        "leading_digits_pattern": ["900"],
        "national_prefix_optional_when_formatting": false,
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null
      }
    ],
    "intl_number_format": [
      {
        "pattern": "(\\d{2})(\\d{3})(\\d{3,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": ["3[02]|40|[68]9"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4 \$5",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:0|3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|4[01]|50|6[09]|7(?:0|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6]|9)|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{4})(\\d{3,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": ["3[02]|40|[68]9"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{3})(\\d{2})(\\d{1,2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["3[02]|40|[68]9"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{3})(\\d{3})(\\d{2,3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["3[02]|40|[68]9"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d)(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4 \$5 \$6",
        "leading_digits_pattern": ["3[02]|40|[68]9"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{2,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": [
          "2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]|[68][1-8])1"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{4})(\\d{3,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": [
          "2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]|[68][1-8])1"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{2})(\\d{2})(\\d{1,2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]|[68][1-8])1"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{2})(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4 \$5",
        "leading_digits_pattern": [
          "2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]|[68][1-8])1"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]|[68][1-8])1"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{2})(\\d{2})(\\d)",
        "format": "\$1 \$2 \$3 \$4 \$5",
        "leading_digits_pattern": [
          "2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]|[68][1-8])1"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{3})(\\d{2,3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]|[68][1-8])1"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{3})(\\d{1,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|[56]0|7(?:0[2-8]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|66[2-9]|7(?:1[2-9]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|[5-8]0|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{2})(\\d)(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4 \$5",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|66[2-9]|7(?:1[2-9]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|[5-8]0|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{2})(\\d)(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4 \$5 \$6",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|[56]0|7(?:0[2-8]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{2})(\\d{2})(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4 \$5 \$6",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|7(?:8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|[5-7]0|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{4})(\\d{1,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|[56]0|7(?:0[2-8]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{3})(\\d{3})(\\d{3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|3[1468]|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]|9[1468]))|4(?:1|5[02-6]|9[2-6])|7(?:8[02-5]|9[03-7])|8(?:3[02-46-9]|4[02-6]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|[5-7]0|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{2})(\\d{3})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "15[1279]|2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|[56]0|7(?:0[2-8]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{3})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|[56]0|7(?:0[2-8]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{2})(\\d{2})(\\d{2,3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "2(?:0[4-6]|1(?:[035-9]|29)|3[0235-9]|7[2-7])|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]))|41|[56]0|7(?:0[2-8]|8[02-5]|9[03-7])|8(?:3[02-46-9]|5[03-9]|6[2-8]|8[024-6])|9(?:0[7-9]|7[02-467])|(?:45|84)[02-6]|3(?:83|99)[1468]|3[68]4[1347]|3(?:47|60)[1356]|(?:66|71|80)[2-9]|3(?:3[46]|46|5[49])[1246]|(?:22|47|81)[02-79]|3[4579]3[1357]|(?:28|49|5[79]|7[27]|9[589])[02-7]|(?:2[569]|4[2-48]|5[124-6]|6[1-358]|73|82|9[1-4])[02-9]|(?:24|[49]6|5[38]|6[47]|7[4-6]|87)[02-8]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{5})(\\d{3})(\\d{3,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": [
          "3(?:3(?:0[589]|2[03]|3[369]|4[357]|6[0357]|7[0346]|8[347]|9[236-8])|4(?:4[2469]|6[03579]|9[0257])|5(?:0[235]|2[046]|[49][357]|6[09]|7[2579]|8[2479])|6(?:2[05]|3[37]|6[02459]|7[03468]|8[47]|9[246])|7(?:2[09]|4[236]|60|75)|8(?:2[0239]|3[023579]|7[23589]|8[2457])|9(?:0[03568]|3[24689]|4[0258]|60|7[2457]|8[23568]|9[23579]))|3[68]4[2568]|3(?:47|60)[2478]|3[49]2[02469]|3[457]3[2468]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{5})(\\d{4})(\\d{3,4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": [
          "3(?:3(?:0[589]|2[03]|3[369]|4[357]|6[0357]|7[0346]|8[347]|9[236-8])|4(?:4[2469]|6[03579]|9[0257])|5(?:0[235]|2[046]|[49][357]|6[09]|7[2579]|8[2479])|6(?:2[05]|3[37]|6[02459]|7[03468]|8[47]|9[246])|7(?:2[09]|4[236]|60|75)|8(?:2[0239]|3[023579]|7[23589]|8[2457])|9(?:0[03568]|3[24689]|4[0258]|60|7[2457]|8[23568]|9[23579]))|3[68]4[2568]|3(?:47|60)[2478]|3[49]2[02469]|3[457]3[2468]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{5})(\\d{3})(\\d{3})(\\d{3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": [
          "3(?:3(?:0[589]|2[03]|3[369]|4[357]|6[0357]|7[0346]|8[347]|9[236-8])|4(?:4[2469]|6[03579]|9[0257])|5(?:0[235]|2[046]|[49][357]|6[09]|7[2579]|8[2479])|6(?:2[05]|3[37]|6[02459]|7[03468]|8[47]|9[246])|7(?:2[09]|4[236]|60|75)|8(?:2[0239]|3[023579]|7[23589]|8[2457])|9(?:0[03568]|3[24689]|4[0258]|60|7[2457]|8[23568]|9[23579]))|3[68]4[2568]|3(?:47|60)[2478]|3[49]2[02469]|3[457]3[2468]"
        ],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{3})(\\d{4})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": ["15[1279]"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{4})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": ["15[1279]"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{8})",
        "format": "\$1 \$2",
        "leading_digits_pattern": ["15[1279]"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{3})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["15[1279]"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{3})(\\d)",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["1[67]|800"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{2,3})(\\d{3})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["1[67]|800"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{4})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leading_digits_pattern": ["800"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{2})(\\d{2,3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["800"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{6})(\\d{2})(\\d{1,4})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["800"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d)(\\d{3})(\\d{3,4})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["900"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d)(\\d{4})(\\d{3,4})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["900"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{3})(\\d)(\\d{3})(\\d{3})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["180"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{4,6})",
        "format": "\$1 \$2",
        "leading_digits_pattern": ["180"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leading_digits_pattern": ["180"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{4,10})",
        "format": "\$1 \$2",
        "leading_digits_pattern": ["900"],
        "national_prefix_formatting_rule": null,
        "domestic_carrier_code_formatting_rule": null,
        "national_prefix_optional_when_formatting": false
      }
    ]
  };
}
