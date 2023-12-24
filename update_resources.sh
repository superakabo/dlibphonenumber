#!/bin/zsh

# Script to download files from the libphonenumber resources directory using curl.
# To execute this script, run: (in terminal) 
# zsh ./update_resources.sh 

# Download phonenumber.proto
curl --create-dirs -o resources/phonenumber.proto https://raw.githubusercontent.com/google/libphonenumber/master/resources/phonenumber.proto

# Download phonemetadata.proto
curl --create-dirs -o resources/phonemetadata.proto https://raw.githubusercontent.com/google/libphonenumber/master/resources/phonemetadata.proto

# Download PhoneNumberMetadata.xml
curl --create-dirs -o resources/PhoneNumberMetadata.xml https://raw.githubusercontent.com/google/libphonenumber/master/resources/PhoneNumberMetadata.xml

# Download ShortNumberMetadata.xml
curl --create-dirs -o resources/ShortNumberMetadata.xml https://raw.githubusercontent.com/google/libphonenumber/master/resources/ShortNumberMetadata.xml

# Download PhoneNumberMetadataForTesting.xml
curl --create-dirs -o resources/PhoneNumberMetadataForTesting.xml https://raw.githubusercontent.com/google/libphonenumber/master/resources/PhoneNumberMetadataForTesting.xml

# Download PhoneNumberAlternateFormats.xml
curl --create-dirs -o resources/PhoneNumberAlternateFormats.xml https://raw.githubusercontent.com/google/libphonenumber/master/resources/PhoneNumberAlternateFormats.xml


# # Build TypeScript code generator tool used to generate
# # the respective Dart files (phone_number_metadata.dart, countryCodeToRegionCodeMap.dart)

# # Compile the TypeScript project to translate the code to JavaScript
# tsc -p ./tool/tsconfig.json

# # Generate phone_number_metadata object files
# # (Map<String, Map<String, List<Object>>>)
# node ./tool/phone_number_metadata.js

# # Generate test phone_number_metadata object files
# # (Map<String, Map<String, List<Object>>>) 
# node ./tool/phone_number_metadata.js true


# # Check Dart code for issues
# dart format ./lib
# dart fix --dry-run

# # Attempt to publish Dart code to see possible issues.
# dart pub publish --dry-run