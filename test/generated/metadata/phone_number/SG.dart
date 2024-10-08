// ignore_for_file: file_names

// This file is automatically generated from [resources/PhoneNumberMetadataForTesting.xml].

/// Phone Number JSON data for SG
Map<String, Object?> getSG() {
  return {
    "generalDesc": {
      "nationalNumberPattern": "[13689]\\d{7,10}",
      "possibleLength": [8, 10, 11]
    },
    "fixedLine": {
      "nationalNumberPattern": "[36]\\d{7}",
      "exampleNumber": "31234567",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "mobile": {
      "nationalNumberPattern": "[89]\\d{7}",
      "exampleNumber": "81234567",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "tollFree": {
      "nationalNumberPattern": "1?800\\d{7}",
      "exampleNumber": "8001234567",
      "possibleLength": [10, 11],
      "possibleLengthLocalOnly": [-1]
    },
    "premiumRate": {
      "nationalNumberPattern": "1900\\d{7}",
      "exampleNumber": "19001234567",
      "possibleLength": [11],
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
    "id": "SG",
    "countryCode": 65,
    "internationalPrefix": "0[0-3][0-9]",
    "nationalPrefixForParsing": "777777",
    "sameMobileAndFixedLinePattern": false,
    "numberFormat": [
      {
        "pattern": "(\\d{4})(\\d{4})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["[369]|8[1-9]"],
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{3})(\\d{4})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["1[89]"],
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{4})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["800"],
        "nationalPrefixOptionalWhenFormatting": false
      }
    ],
    "intlNumberFormat": [
      {
        "pattern": "(\\d{4})(\\d{4})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["[369]|8[1-9]"],
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{3})(\\d{4})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["1[89]"],
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{4})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["800"],
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
