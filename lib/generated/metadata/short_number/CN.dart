// ignore_for_file: file_names

// This file is automatically generated from [resources/ShortNumberMetadata.xml].

/// Short Number JSON data for CN
Map<String, Object?> getCN() {
  return {
    "generalDesc": {
      "nationalNumberPattern": "[19]\\d{2,5}",
      "possibleLength": [3, 4, 5, 6]
    },
    "fixedLine": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "mobile": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "tollFree": {
      "nationalNumberPattern": "1(?:1[09]|2(?:[02]|1\\d\\d|395))",
      "exampleNumber": "110",
      "possibleLength": [3, 5],
      "possibleLengthLocalOnly": [-1]
    },
    "premiumRate": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "sharedCost": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "personalNumber": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "voip": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "id": "CN",
    "countryCode": 0,
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
      "nationalNumberPattern": "1(?:1[09]|20)",
      "exampleNumber": "110",
      "possibleLength": [3],
      "possibleLengthLocalOnly": [-1]
    },
    "voicemail": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "shortCode": {
      "nationalNumberPattern":
          "1(?:00|1[0249]|2395|6[08])|9[56]\\d{3,4}|12[023]|1(?:0(?:[0-26]\\d|8)|21\\d)\\d",
      "exampleNumber": "100",
      "possibleLength": [3, 4, 5, 6],
      "possibleLengthLocalOnly": [-1]
    },
    "standardRate": {
      "nationalNumberPattern":
          "1(?:0(?:[0-26]\\d|8)\\d|1[24]|23|6[08])|9[56]\\d{3,4}|100",
      "exampleNumber": "100",
      "possibleLength": [3, 4, 5, 6],
      "possibleLengthLocalOnly": [-1]
    },
    "carrierSpecific": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "mobileNumberPortableRegion": false,
    "smsServices": {
      "nationalNumberPattern": "12110",
      "exampleNumber": "12110",
      "possibleLength": [5],
      "possibleLengthLocalOnly": [-1]
    }
  };
}
