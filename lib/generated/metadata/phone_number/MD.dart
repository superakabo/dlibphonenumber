// ignore_for_file: file_names

// This file is automatically generated from [resources/PhoneNumberMetadata.xml].

/// Phone Number JSON data for MD
Map<String, Object?> getMD() {
  return {
    "generalDesc": {
      "nationalNumberPattern": "(?:[235-7]\\d|[89]0)\\d{6}",
      "possibleLength": [8]
    },
    "fixedLine": {
      "nationalNumberPattern": "(?:(?:2[1-9]|3[1-79])\\d|5(?:33|5[257]))\\d{5}",
      "exampleNumber": "22212345",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "mobile": {
      "nationalNumberPattern": "562\\d{5}|(?:6\\d|7[16-9])\\d{6}",
      "exampleNumber": "62112345",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "tollFree": {
      "nationalNumberPattern": "800\\d{5}",
      "exampleNumber": "80012345",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "premiumRate": {
      "nationalNumberPattern": "90[056]\\d{5}",
      "exampleNumber": "90012345",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "sharedCost": {
      "nationalNumberPattern": "808\\d{5}",
      "exampleNumber": "80812345",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "personalNumber": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "voip": {
      "nationalNumberPattern": "3[08]\\d{6}",
      "exampleNumber": "30123456",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "id": "MD",
    "countryCode": 373,
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
        "leadingDigitsPattern": ["22|3"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{2})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["[25-7]"],
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
        "leadingDigitsPattern": ["22|3"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{2})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["[25-7]"],
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
      "nationalNumberPattern": "803\\d{5}",
      "exampleNumber": "80312345",
      "possibleLength": [8],
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
