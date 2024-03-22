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

# Generate class from the .proto files found in the resources
# folder using protocol buffers (protobuf, protoc_plugin)
# -----------------------------------------------------------
# Install the latest version of protoc plugin for dart
dart pub global activate protoc_plugin

# Create directories for the classes to be generated if they are missing
mkdir -pv ./lib/generated/phone_metadata
mkdir -pv ./lib/generated/phone_number

# Generate the Phone Number class from resources/phonenumber.proto
protoc --dart_out=./lib/generated/phone_number -I ./resources ./resources/phonenumber.proto

# Generate the Phone Metadata class from resources/phonemetadata.proto
protoc --dart_out=./lib/generated/phone_metadata -I ./resources ./resources/phonemetadata.proto

# Build TypeScript code generator tool used to generate
# the respective Dart files [
#   phone_number_metadata.dart, 
#   country_code_to_region_code_map.dart, 
#   phone_number_alternate_formats
# ]
# ---------------------------------------------------------------------------------------
# Compile the TypeScript project to translate the code to JavaScript
tsc -p ./tool/tsconfig.json

# Generate phone_number_metadata object files
# -------------------------------------------
# (Map<String, Map<String, List<Object>>>)
node ./tool/generate_metadata.js PhoneNumberMetadata.xml false

# Generate test phone_number_metadata object files
# (Map<String, Map<String, List<Object>>>) 
node ./tool/generate_metadata.js PhoneNumberMetadataForTesting.xml true

# Generate alternate_format_phone_number_metadata object files
# -------------------------------------------
# (Map<String, Map<String, Object>>)
node ./tool/generate_metadata.js PhoneNumberAlternateFormats.xml false

# Fix Dart code issues (if any)
dart format ./lib
dart fix --apply

# Run tests
dart test -r expanded ./test/phone_number_util_test.dart
dart test -r expanded ./test/as_you_type_formatter_test.dart
dart test -r expanded ./test/phone_number_match_test.dart
dart test -r expanded ./test/phone_number_matcher_test.dart

# Attempt to publish Dart code to see possible issues.
dart pub publish --dry-run
