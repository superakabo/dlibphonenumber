#!/bin/zsh

# Script to download files from the libphonenumber resources directory.
# To execute this script, run: (in terminal) 
# zsh ./update_resources.sh 


# Fetch just the latest resource directory from the libphonenumber repository
# This command also copies files in the root directories specified
git clone --filter=blob:none --no-checkout https://github.com/google/libphonenumber.git
cd libphonenumber
git sparse-checkout set --cone
git sparse-checkout set \
    resources/carrier \
    resources/geocoding \
    resources/test \
    resources/timezones
git checkout master
#
# Get back to the root working directory
cd ..
#
# Delete the old resources directory 
if [ -d "./resources" ]; then
    rm -rf ./resources
fi
#
# Recreate a new resources directory
mkdir -p ./resources/
#
# Move the latest [libphonenumber/resources] into the new resources directory.
mv -f ./libphonenumber/resources/* ./resources/
#
# Move the latest [libphonenumber/release_notes.txt] into the new resources directory.
mv -f ./libphonenumber/release_notes.txt ./resources/
#
# Delete the empty libphonenumber directory
if [ -d "./libphonenumber" ]; then
    rm -rf ./libphonenumber
fi

# Update the [changelog.md] file with the latest notes from [release_notes.txt] if any.
changelog_output=$(dart run tools/update_changelog.dart);
#
# split the change log output and store them as variables.
version_number="${changelog_output%%|*}"
release_notes="${changelog_output#*|}"
#
# stop the process if change log output is empty.
if [[ -z $changelog_output ]]; then
  echo "No changes detected in the resources directory."
  exit 0
fi

#
# Escape html tags in the comments of resources/phonemetadata.proto file
sed 's/<\([^>]*\)>/`<\1>`/g' resources/phonemetadata.proto > temp && mv temp resources/phonemetadata.proto

# Generate classes from the .proto files found in the resources
# folder using protocol buffers (protobuf, protoc_plugin)
# 
# Install the latest version of protoc plugin for dart
brew install protobuf
dart pub global activate protoc_plugin
#
# Create directories for the proto classes to be generated if they are missing
mkdir -pv ./lib/generated/classes/phone_metadata
mkdir -pv ./lib/generated/classes/phone_number
#
# Generate the Phone Number metadata class from resources/phonenumber.proto
protoc --dart_out=./lib/generated/classes/phone_number -I ./resources ./resources/phonenumber.proto --plugin=$HOME/.pub-cache/bin/protoc-gen-dart
#
# Generate the Phone metadata class from resources/phonemetadata.proto
protoc --dart_out=./lib/generated/classes/phone_metadata -I ./resources ./resources/phonemetadata.proto --plugin=$HOME/.pub-cache/bin/protoc-gen-dart

# Generate metadata files:
#
# 1. Phone Number 
dart run tools/bin/tools.dart metadata -i resources/PhoneNumberMetadata.xml -o lib/generated/metadata/ -t phone_number
#
# 2. Phone Number Test
dart run tools/bin/tools.dart metadata -i resources/PhoneNumberMetadataForTesting.xml -o test/generated/metadata/ -t phone_number
#
# 3. Phone Number Alt Formats
dart run tools/bin/tools.dart metadata -i resources/PhoneNumberAlternateFormats.xml -o lib/generated/metadata/ -t phone_number_alt
#
# 4. Short Number
dart run tools/bin/tools.dart metadata -i resources/ShortNumberMetadata.xml -o lib/generated/metadata/ -t short_number
#
# 5. Timezone
dart run tools/bin/tools.dart metadata -i resources/timezones/map_data.txt -o lib/generated/metadata/ -t timezone
#
# 6. Timezone Test
dart run tools/bin/tools.dart metadata -i resources/test/timezones/map_data.txt -o test/generated/metadata/ -t timezone
#
# 7. Geocoding
dart run tools/bin/tools.dart metadata -i resources/geocoding -o lib/generated/metadata/ -t geocoding
#
# 8. Geocoding Test
dart run tools/bin/tools.dart metadata -i resources/test/geocoding -o test/generated/metadata/ -t geocoding
#
# 9. Carrier
dart run tools/bin/tools.dart metadata -i resources/carrier -o lib/generated/metadata/ -t carrier
#
# 10. Carrier Test
dart run tools/bin/tools.dart metadata -i resources/test/carrier -o test/generated/metadata/ -t carrier

# Fix Dart code issues (if any)
dart format ./lib
dart format ./test
dart fix --apply

# Run tests
dart test -r expanded ./test/phone_number_util_test.dart
dart test -r expanded ./test/as_you_type_formatter_test.dart
dart test -r expanded ./test/phone_number_match_test.dart
dart test -r expanded ./test/phone_number_matcher_test.dart
dart test -r expanded ./test/short_number_info_test.dart
dart test -r expanded ./test/phone_number_offline_geocoder_test.dart
dart test -r expanded ./test/phone_number_to_time_zones_mapper_test.dart
dart test -r expanded ./test/phone_number_to_carrier_mapper_test.dart

# Check if it is running in GitHub Actions and commit changes.
if [ "$GITHUB_ACTIONS" = "true" ]; then
# configure github user properties.
    git config user.name "superakabo"
    git config user.email "superakabo@gmail.com"
#
# Commit the updates to the GitHub repository.
    git add -A
    git commit -m "Metadata updates for release $version_number"
    git push origin main
#
# Create a new release tag.
    git tag -a "v$version_number" -m "Metadata updates" -m "$release_notes"
    git push origin "v$version_number"
else
# Attempt to publish Dart code to see possible issues.
    dart pub publish --dry-run
fi
