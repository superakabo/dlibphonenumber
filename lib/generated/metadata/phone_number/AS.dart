// ignore_for_file: file_names

// This file is automatically generated from [resources/PhoneNumberMetadata.xml].

/// Phone Number JSON data for AS
Map<String, Object?> getAS() {
  return {
    "generalDesc": {
      "nationalNumberPattern": "(?:[58]\\d\\d|684|900)\\d{7}",
      "possibleLength": [10],
      "possibleLengthLocalOnly": [7]
    },
    "fixedLine": {
      "nationalNumberPattern": "6846(?:22|33|44|55|77|88|9[19])\\d{4}",
      "exampleNumber": "6846221234",
      "possibleLength": [10],
      "possibleLengthLocalOnly": [7]
    },
    "mobile": {
      "nationalNumberPattern":
          "684(?:2(?:48|5[2468]|7[26])|7(?:3[13]|70|82))\\d{4}",
      "exampleNumber": "6847331234",
      "possibleLength": [10],
      "possibleLengthLocalOnly": [7]
    },
    "tollFree": {
      "nationalNumberPattern": "8(?:00|33|44|55|66|77|88)[2-9]\\d{6}",
      "exampleNumber": "8002123456",
      "possibleLength": [10],
      "possibleLengthLocalOnly": [-1]
    },
    "premiumRate": {
      "nationalNumberPattern": "900[2-9]\\d{6}",
      "exampleNumber": "9002123456",
      "possibleLength": [10],
      "possibleLengthLocalOnly": [-1]
    },
    "sharedCost": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "personalNumber": {
      "nationalNumberPattern":
          "52(?:3(?:[2-46-9][02-9]\\d|5(?:[02-46-9]\\d|5[0-46-9]))|4(?:[2-478][02-9]\\d|5(?:[034]\\d|2[024-9]|5[0-46-9])|6(?:0[1-9]|[2-9]\\d)|9(?:[05-9]\\d|2[0-5]|49)))\\d{4}|52[34][2-9]1[02-9]\\d{4}|5(?:00|2[125-9]|33|44|66|77|88)[2-9]\\d{6}",
      "exampleNumber": "5002345678",
      "possibleLength": [10],
      "possibleLengthLocalOnly": [-1]
    },
    "voip": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "id": "AS",
    "countryCode": 1,
    "internationalPrefix": "011",
    "nationalPrefix": "1",
    "nationalPrefixForParsing": "([267]\\d{6})\$|1",
    "nationalPrefixTransformRule": "684\$1",
    "sameMobileAndFixedLinePattern": false,
    "pager": {
      "possibleLength": [-1],
      "possibleLengthLocalOnly": [-1]
    },
    "mainCountryForCode": false,
    "leadingDigits": "684",
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
