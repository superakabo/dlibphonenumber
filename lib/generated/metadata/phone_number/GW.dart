// ignore_for_file: file_names

// This file is automatically generated from [resources/PhoneNumberMetadata.xml].

/// Phone Number JSON data for GW
Map<String, Object?> getGW() {
  return {
    "generalDesc": {
      "nationalNumberPattern": "[49]\\d{8}|4\\d{6}",
      "possibleLength": [7, 9]
    },
    "fixedLine": {
      "nationalNumberPattern": "443\\d{6}",
      "exampleNumber": "443201234",
      "possibleLength": [9],
      "possibleLengthLocalOnly": [-1]
    },
    "mobile": {
      "nationalNumberPattern": "9(?:5\\d|6[569]|77)\\d{6}",
      "exampleNumber": "955012345",
      "possibleLength": [9],
      "possibleLengthLocalOnly": [-1]
    },
    "tollFree": {
      "possibleLength": [-1],
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
      "nationalNumberPattern": "40\\d{5}",
      "exampleNumber": "4012345",
      "possibleLength": [7],
      "possibleLengthLocalOnly": [-1]
    },
    "id": "GW",
    "countryCode": 245,
    "internationalPrefix": "00",
    "sameMobileAndFixedLinePattern": false,
    "numberFormat": [
      {
        "pattern": "(\\d{3})(\\d{4})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["40"],
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["[49]"],
        "nationalPrefixOptionalWhenFormatting": false
      }
    ],
    "intlNumberFormat": [
      {
        "pattern": "(\\d{3})(\\d{4})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["40"],
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["[49]"],
        "nationalPrefixOptionalWhenFormatting": false
      }
    ],
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
