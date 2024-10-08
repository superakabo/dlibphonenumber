// ignore_for_file: file_names

// This file is automatically generated from [resources/PhoneNumberMetadata.xml].

/// Phone Number JSON data for XK
Map<String, Object?> getXK() {
  return {
    "generalDesc": {
      "nationalNumberPattern": "2\\d{7,8}|3\\d{7,11}|(?:4\\d\\d|[89]00)\\d{5}",
      "possibleLength": [8, 9, 10, 11, 12]
    },
    "fixedLine": {
      "nationalNumberPattern":
          "38\\d{6,10}|(?:2[89]|39)(?:0\\d{5,6}|[1-9]\\d{5})",
      "exampleNumber": "28012345",
      "possibleLength": [8, 9, 10, 11, 12],
      "possibleLengthLocalOnly": [-1]
    },
    "mobile": {
      "nationalNumberPattern": "4[3-9]\\d{6}",
      "exampleNumber": "43201234",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "tollFree": {
      "nationalNumberPattern": "800\\d{5}",
      "exampleNumber": "80001234",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "premiumRate": {
      "nationalNumberPattern": "900\\d{5}",
      "exampleNumber": "90001234",
      "possibleLength": [8],
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
    "id": "XK",
    "countryCode": 383,
    "internationalPrefix": "00",
    "nationalPrefix": "0",
    "nationalPrefixForParsing": "0",
    "sameMobileAndFixedLinePattern": false,
    "numberFormat": [
      {
        "pattern": "(\\d{3})(\\d{5})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["[89]"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{3})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["[2-4]"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["2|39"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{7,10})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["3"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      }
    ],
    "intlNumberFormat": [
      {
        "pattern": "(\\d{3})(\\d{5})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["[89]"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{3})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["[2-4]"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{3})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["2|39"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{7,10})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["3"],
        "nationalPrefixFormattingRule": "0\$1",
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
