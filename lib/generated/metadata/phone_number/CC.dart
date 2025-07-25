// ignore_for_file: file_names

// This file is automatically generated from [resources/PhoneNumberMetadata.xml].

/// Phone Number JSON data for CC
Map<String, Object?> getCC() {
  return {
    "generalDesc": {
      "nationalNumberPattern":
          "1(?:[0-79]\\d{8}(?:\\d{2})?|8[0-24-9]\\d{7})|[148]\\d{8}|1\\d{5,7}",
      "possibleLength": [6, 7, 8, 9, 10, 12],
      "possibleLengthLocalOnly": [8]
    },
    "fixedLine": {
      "nationalNumberPattern":
          "8(?:51(?:0(?:02|31|60|89)|1(?:18|76)|223)|91(?:0(?:1[0-2]|29)|1(?:[28]2|50|79)|2(?:10|64)|3(?:[06]8|22)|4[29]8|62\\d|70[23]|959))\\d{3}",
      "exampleNumber": "891621234",
      "possibleLength": [9],
      "possibleLengthLocalOnly": [8]
    },
    "mobile": {
      "nationalNumberPattern":
          "4(?:79[01]|83[0-389]|94[0-478])\\d{5}|4(?:[0-36]\\d|4[047-9]|[58][0-24-9]|7[02-8]|9[0-37-9])\\d{6}",
      "exampleNumber": "412345678",
      "possibleLength": [9],
      "possibleLengthLocalOnly": [-1]
    },
    "tollFree": {
      "nationalNumberPattern": "180(?:0\\d{3}|2)\\d{3}",
      "exampleNumber": "1800123456",
      "possibleLength": [7, 10],
      "possibleLengthLocalOnly": [-1]
    },
    "premiumRate": {
      "nationalNumberPattern": "190[0-26]\\d{6}",
      "exampleNumber": "1900123456",
      "possibleLength": [10],
      "possibleLengthLocalOnly": [-1]
    },
    "sharedCost": {
      "nationalNumberPattern":
          "13(?:00\\d{6}(?:\\d{2})?|45[0-4]\\d{3})|13\\d{4}",
      "exampleNumber": "1300123456",
      "possibleLength": [6, 8, 10, 12],
      "possibleLengthLocalOnly": [-1]
    },
    "personalNumber": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "voip": {
      "nationalNumberPattern": "14(?:5(?:1[0458]|[23][458])|71\\d)\\d{4}",
      "exampleNumber": "147101234",
      "possibleLength": [9],
      "possibleLengthLocalOnly": [-1]
    },
    "id": "CC",
    "countryCode": 61,
    "internationalPrefix":
        "001[14-689]|14(?:1[14]|34|4[17]|[56]6|7[47]|88)0011",
    "nationalPrefix": "0",
    "nationalPrefixForParsing": "([59]\\d{7})\$|0",
    "nationalPrefixTransformRule": "8\$1",
    "preferredInternationalPrefix": "0011",
    "sameMobileAndFixedLinePattern": false,
    "pager": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "mainCountryForCode": false,
    "noInternationalDialling": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "uan": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "emergency": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "voicemail": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "shortCode": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "standardRate": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "carrierSpecific": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "mobileNumberPortableRegion": false,
    "smsServices": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    }
  };
}
