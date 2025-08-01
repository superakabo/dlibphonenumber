// ignore_for_file: file_names

// This file is automatically generated from [resources/PhoneNumberMetadata.xml].

/// Phone Number JSON data for UG
Map<String, Object?> getUG() {
  return {
    "generalDesc": {
      "nationalNumberPattern": "800\\d{6}|(?:[29]0|[347]\\d)\\d{7}",
      "possibleLength": [9],
      "possibleLengthLocalOnly": [5, 6, 7]
    },
    "fixedLine": {
      "nationalNumberPattern":
          "20(?:(?:240|30[67])\\d|6(?:00[0-2]|30[0-4]))\\d{3}|(?:20(?:[017]\\d|2[5-9]|3[1-4]|5[0-4]|6[15-9])|[34]\\d{3})\\d{5}",
      "exampleNumber": "312345678",
      "possibleLength": [9],
      "possibleLengthLocalOnly": [5, 6, 7]
    },
    "mobile": {
      "nationalNumberPattern":
          "72[48]0\\d{5}|7(?:[014-8]\\d|2[067]|36|9[0189])\\d{6}",
      "exampleNumber": "712345678",
      "possibleLength": [9],
      "possibleLengthLocalOnly": [-1]
    },
    "tollFree": {
      "nationalNumberPattern": "800[1-3]\\d{5}",
      "exampleNumber": "800123456",
      "possibleLength": [9],
      "possibleLengthLocalOnly": [-1]
    },
    "premiumRate": {
      "nationalNumberPattern": "90[1-3]\\d{6}",
      "exampleNumber": "901123456",
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
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "id": "UG",
    "countryCode": 256,
    "internationalPrefix": "00[057]",
    "nationalPrefix": "0",
    "nationalPrefixForParsing": "0",
    "sameMobileAndFixedLinePattern": false,
    "numberFormat": [
      {
        "pattern": "(\\d{4})(\\d{5})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["202", "2024"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{6})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["[27-9]|4(?:6[45]|[7-9])"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{7})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["[34]"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      }
    ],
    "intlNumberFormat": [
      {
        "pattern": "(\\d{4})(\\d{5})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["202", "2024"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{6})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["[27-9]|4(?:6[45]|[7-9])"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{7})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["[34]"],
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
