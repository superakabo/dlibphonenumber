// ignore_for_file: file_names

// This file is automatically generated from [resources/PhoneNumberMetadata.xml].

/// Phone Number JSON data for MA
Map<String, Object?> getMA() {
  return {
    "generalDesc": {
      "nationalNumberPattern": "[5-8]\\d{8}",
      "possibleLength": [9]
    },
    "fixedLine": {
      "nationalNumberPattern":
          "5(?:2(?:[0-25-79]\\d|3[1-578]|4[02-46-8]|8[0235-7])|3(?:[0-47]\\d|5[02-9]|6[02-8]|8[014-9]|9[3-9])|(?:4[067]|5[03])\\d)\\d{5}",
      "exampleNumber": "520123456",
      "possibleLength": [9],
      "possibleLengthLocalOnly": [-1]
    },
    "mobile": {
      "nationalNumberPattern":
          "(?:6(?:[0-79]\\d|8[0-247-9])|7(?:[0167]\\d|2[0-8]|5[0-3]|8[0-7]))\\d{6}",
      "exampleNumber": "650123456",
      "possibleLength": [9],
      "possibleLengthLocalOnly": [-1]
    },
    "tollFree": {
      "nationalNumberPattern": "80[0-7]\\d{6}",
      "exampleNumber": "801234567",
      "possibleLength": [9],
      "possibleLengthLocalOnly": [-1]
    },
    "premiumRate": {
      "nationalNumberPattern": "89\\d{7}",
      "exampleNumber": "891234567",
      "possibleLength": [9],
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
      "nationalNumberPattern": "(?:592(?:4[0-2]|93)|80[89]\\d\\d)\\d{4}",
      "exampleNumber": "592401234",
      "possibleLength": [9],
      "possibleLengthLocalOnly": [-1]
    },
    "id": "MA",
    "countryCode": 212,
    "internationalPrefix": "00",
    "nationalPrefix": "0",
    "nationalPrefixForParsing": "0",
    "sameMobileAndFixedLinePattern": false,
    "numberFormat": [
      {
        "pattern": "(\\d{3})(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leadingDigitsPattern": ["5[45]"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{5})",
        "format": "\$1-\$2",
        "leadingDigitsPattern": ["5(?:2[2-46-9]|3[3-9]|9)|8(?:0[89]|92)"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{7})",
        "format": "\$1-\$2",
        "leadingDigitsPattern": ["8"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{6})",
        "format": "\$1-\$2",
        "leadingDigitsPattern": ["[5-7]"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      }
    ],
    "intlNumberFormat": [
      {
        "pattern": "(\\d{3})(\\d{2})(\\d{2})(\\d{2})",
        "format": "\$1 \$2 \$3 \$4",
        "leadingDigitsPattern": ["5[45]"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{4})(\\d{5})",
        "format": "\$1-\$2",
        "leadingDigitsPattern": ["5(?:2[2-46-9]|3[3-9]|9)|8(?:0[89]|92)"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{7})",
        "format": "\$1-\$2",
        "leadingDigitsPattern": ["8"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{6})",
        "format": "\$1-\$2",
        "leadingDigitsPattern": ["[5-7]"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      }
    ],
    "pager": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "mainCountryForCode": true,
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
    "mobileNumberPortableRegion": true,
    "smsServices": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    }
  };
}
