// ignore_for_file: file_names
// This file is automatically generated from [resources/PhoneNumberMetadata.xml].
/// Phone Number JSON data for LT
Map<String, Object?> getLT() {
  return {
    "generalDesc": {
      "nationalNumberPattern": "(?:[3469]\\d|52|[78]0)\\d{6}",
      "possibleLength": [8]
    },
    "fixedLine": {
      "nationalNumberPattern": "(?:3[1478]|4[124-6]|52)\\d{6}",
      "exampleNumber": "31234567",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "mobile": {
      "nationalNumberPattern": "6\\d{7}",
      "exampleNumber": "61234567",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "tollFree": {
      "nationalNumberPattern": "80[02]\\d{5}",
      "exampleNumber": "80012345",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "premiumRate": {
      "nationalNumberPattern": "9(?:0[0239]|10)\\d{5}",
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
      "nationalNumberPattern": "70[05]\\d{5}",
      "exampleNumber": "70012345",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "voip": {
      "nationalNumberPattern": "[89]01\\d{5}",
      "exampleNumber": "80123456",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "id": "LT",
    "countryCode": 370,
    "internationalPrefix": "00",
    "nationalPrefix": "0",
    "nationalPrefixForParsing": "[08]",
    "sameMobileAndFixedLinePattern": false,
    "numberFormat": [
      {
        "pattern": "(\\d)(\\d{3})(\\d{4})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["52[0-7]"],
        "nationalPrefixFormattingRule": "(0-\$1)",
        "nationalPrefixOptionalWhenFormatting": true
      },
      {
        "pattern": "(\\d{3})(\\d{2})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["[7-9]"],
        "nationalPrefixFormattingRule": "0 \$1",
        "nationalPrefixOptionalWhenFormatting": true
      },
      {
        "pattern": "(\\d{2})(\\d{6})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["37|4(?:[15]|6[1-8])"],
        "nationalPrefixFormattingRule": "(0-\$1)",
        "nationalPrefixOptionalWhenFormatting": true
      },
      {
        "pattern": "(\\d{3})(\\d{5})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["[3-6]"],
        "nationalPrefixFormattingRule": "(0-\$1)",
        "nationalPrefixOptionalWhenFormatting": true
      }
    ],
    "intlNumberFormat": [
      {
        "pattern": "(\\d)(\\d{3})(\\d{4})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["52[0-7]"],
        "nationalPrefixFormattingRule": "(0-\$1)",
        "nationalPrefixOptionalWhenFormatting": true
      },
      {
        "pattern": "(\\d{3})(\\d{2})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["[7-9]"],
        "nationalPrefixFormattingRule": "0 \$1",
        "nationalPrefixOptionalWhenFormatting": true
      },
      {
        "pattern": "(\\d{2})(\\d{6})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["37|4(?:[15]|6[1-8])"],
        "nationalPrefixFormattingRule": "(0-\$1)",
        "nationalPrefixOptionalWhenFormatting": true
      },
      {
        "pattern": "(\\d{3})(\\d{5})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["[3-6]"],
        "nationalPrefixFormattingRule": "(0-\$1)",
        "nationalPrefixOptionalWhenFormatting": true
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
      "nationalNumberPattern": "70[67]\\d{5}",
      "exampleNumber": "70712345",
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