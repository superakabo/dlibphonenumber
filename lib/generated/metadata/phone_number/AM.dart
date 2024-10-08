// ignore_for_file: file_names

// This file is automatically generated from [resources/PhoneNumberMetadata.xml].

/// Phone Number JSON data for AM
Map<String, Object?> getAM() {
  return {
    "generalDesc": {
      "nationalNumberPattern": "(?:[1-489]\\d|55|60|77)\\d{6}",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [5, 6]
    },
    "fixedLine": {
      "nationalNumberPattern":
          "(?:(?:1[0-25]|47)\\d|2(?:2[2-46]|3[1-8]|4[2-69]|5[2-7]|6[1-9]|8[1-7])|3[12]2)\\d{5}",
      "exampleNumber": "10123456",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [5, 6]
    },
    "mobile": {
      "nationalNumberPattern": "(?:33|4[1349]|55|77|88|9[13-9])\\d{6}",
      "exampleNumber": "77123456",
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
      "nationalNumberPattern": "90[016]\\d{5}",
      "exampleNumber": "90012345",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "sharedCost": {
      "nationalNumberPattern": "80[1-4]\\d{5}",
      "exampleNumber": "80112345",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "personalNumber": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "voip": {
      "nationalNumberPattern":
          "60(?:2[78]|3[5-9]|4[02-9]|5[0-46-9]|[6-8]\\d|9[0-2])\\d{4}",
      "exampleNumber": "60271234",
      "possibleLength": [8],
      "possibleLengthLocalOnly": [-1]
    },
    "id": "AM",
    "countryCode": 374,
    "internationalPrefix": "00",
    "nationalPrefix": "0",
    "nationalPrefixForParsing": "0",
    "sameMobileAndFixedLinePattern": false,
    "numberFormat": [
      {
        "pattern": "(\\d{3})(\\d{2})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["[89]0"],
        "nationalPrefixFormattingRule": "0 \$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{5})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["2|3[12]"],
        "nationalPrefixFormattingRule": "(0\$1)",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{6})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["1|47"],
        "nationalPrefixFormattingRule": "(0\$1)",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{6})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["[3-9]"],
        "nationalPrefixFormattingRule": "0\$1",
        "nationalPrefixOptionalWhenFormatting": false
      }
    ],
    "intlNumberFormat": [
      {
        "pattern": "(\\d{3})(\\d{2})(\\d{3})",
        "format": "\$1 \$2 \$3",
        "leadingDigitsPattern": ["[89]0"],
        "nationalPrefixFormattingRule": "0 \$1",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{3})(\\d{5})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["2|3[12]"],
        "nationalPrefixFormattingRule": "(0\$1)",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{6})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["1|47"],
        "nationalPrefixFormattingRule": "(0\$1)",
        "nationalPrefixOptionalWhenFormatting": false
      },
      {
        "pattern": "(\\d{2})(\\d{6})",
        "format": "\$1 \$2",
        "leadingDigitsPattern": ["[3-9]"],
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
    "mobileNumberPortableRegion": true,
    "smsServices": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    }
  };
}
