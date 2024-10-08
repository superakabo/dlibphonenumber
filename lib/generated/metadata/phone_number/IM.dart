// ignore_for_file: file_names

// This file is automatically generated from [resources/PhoneNumberMetadata.xml].

/// Phone Number JSON data for IM
Map<String, Object?> getIM() {
  return {
    "generalDesc": {
      "nationalNumberPattern": "1624\\d{6}|(?:[3578]\\d|90)\\d{8}",
      "possibleLength": [10],
      "possibleLengthLocalOnly": [6]
    },
    "fixedLine": {
      "nationalNumberPattern": "1624(?:230|[5-8]\\d\\d)\\d{3}",
      "exampleNumber": "1624756789",
      "possibleLength": [10],
      "possibleLengthLocalOnly": [6]
    },
    "mobile": {
      "nationalNumberPattern":
          "76245[06]\\d{4}|7(?:4576|[59]24\\d|624[0-4689])\\d{5}",
      "exampleNumber": "7924123456",
      "possibleLength": [10],
      "possibleLengthLocalOnly": [-1]
    },
    "tollFree": {
      "nationalNumberPattern": "808162\\d{4}",
      "exampleNumber": "8081624567",
      "possibleLength": [10],
      "possibleLengthLocalOnly": [-1]
    },
    "premiumRate": {
      "nationalNumberPattern":
          "8(?:440[49]06|72299\\d)\\d{3}|(?:8(?:45|70)|90[0167])624\\d{4}",
      "exampleNumber": "9016247890",
      "possibleLength": [10],
      "possibleLengthLocalOnly": [-1]
    },
    "sharedCost": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "personalNumber": {
      "nationalNumberPattern": "70\\d{8}",
      "exampleNumber": "7012345678",
      "possibleLength": [10],
      "possibleLengthLocalOnly": [-1]
    },
    "voip": {
      "nationalNumberPattern": "56\\d{8}",
      "exampleNumber": "5612345678",
      "possibleLength": [10],
      "possibleLengthLocalOnly": [-1]
    },
    "id": "IM",
    "countryCode": 44,
    "internationalPrefix": "00",
    "nationalPrefix": "0",
    "nationalPrefixForParsing": "([25-8]\\d{5})\$|0",
    "nationalPrefixTransformRule": "1624\$1",
    "sameMobileAndFixedLinePattern": false,
    "pager": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "mainCountryForCode": false,
    "leadingDigits": "74576|(?:16|7[56])24",
    "noInternationalDialling": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "uan": {
      "nationalNumberPattern":
          "3440[49]06\\d{3}|(?:3(?:08162|3\\d{4}|45624|7(?:0624|2299))|55\\d{4})\\d{4}",
      "exampleNumber": "5512345678",
      "possibleLength": [10],
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
