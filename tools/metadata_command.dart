import 'dart:async';
import 'dart:io';
import 'package:args/command_runner.dart';

import 'args_model.dart';
import 'geocoding_metadata_generator.dart';
import 'phone_number_alt_formats_metadata_generator.dart';
import 'phone_number_metadata_generator.dart';
import 'short_number_metadata_generator.dart';
import 'timezone_metadata_generator.dart';

class MetadataCommand extends Command<String> {
  MetadataCommand() {
    argParser
      ..addOption(
        'input',
        help: 'The input file containing metadata in xml or txt format.',
        abbr: 'i',
      )
      ..addOption(
        'output',
        help: 'The output directory to contain the generated metadata.',
        abbr: 'o',
      )
      ..addOption(
        'type',
        help: 'The type of metadata to be generated.',
        abbr: 't',
        allowed: ['short_number', 'phone_number', 'phone_number_alt', 'timezone', 'geocoding', 'carrier'],
      )
      ..addOption(
        'format',
        help: 'The format of the output file in Dart or Protobuf.',
        abbr: 'f',
        defaultsTo: 'dart',
        allowed: ['dart', 'protobuf'],
      );
  }

  @override
  String get description => ''
      'Converts metadata from xml or txt to json or protobuf format.\n'
      'Example command line invocation:\n'
      '\n'
      'Generate Geocoding Test metadata:\n'
      'dart run tools/bin/tools.dart metadata -i resources/test/geocoding -o test/generated/metadata/ -t geocoding\n'
      '\n'
      'Generate Geocoding metadata:\n'
      'dart run tools/bin/tools.dart metadata -i resources/geocoding -o lib/generated/metadata/ -t geocoding\n'
      '\n'
      'Generate Phone Number Test metadata:\n'
      'dart run tools/bin/tools.dart metadata -i resources/PhoneNumberMetadataForTesting.xml -o test/generated/metadata/ -t phone_number\n'
      '\n'
      'Generate Phone Number metadata:\n'
      'dart run tools/bin/tools.dart metadata -i resources/PhoneNumberMetadata.xml -o lib/generated/metadata/ -t phone_number\n'
      '\n'
      'Generate Timezone Test metadata:\n'
      'dart run tools/bin/tools.dart metadata -i resources/test/timezones/map_data.txt -o test/generated/metadata/ -t timezone\n'
      '\n'
      'Generate Timezone metadata:\n'
      'dart run tools/bin/tools.dart metadata -i resources/timezones/map_data.txt -o lib/generated/metadata/ -t timezone\n'
      '\n'
      'Generate Short Number metadata:\n'
      'dart run tools/bin/tools.dart metadata -i resources/ShortNumberMetadata.xml -o lib/generated/metadata/ -t short_number\n'
      '\n'
      'Generate Phone Number Alt Formats metadata:\n'
      'dart run tools/bin/tools.dart metadata -i resources/PhoneNumberAlternateFormats.xml -o lib/generated/metadata/ -t phone_number_alt\n'
      '\n';

  @override
  String get name => 'metadata';

  @override
  List<String> get aliases => ['a'];

  @override
  FutureOr<String>? run() {
    final ArgsModel args = ArgsModel.fromArgResult(argResults);
    final String errorMessage = args.validate();

    if (errorMessage.isNotEmpty) {
      stderr.writeln(errorMessage);
      exit(2);
    }

    switch (args.metadataType) {
      case 'phone_number':
        return PhoneNumberMetadataGenerator(args).start();

      case 'short_number':
        return ShortNumberMetadataGenerator(args).start();

      case 'phone_number_alt':
        return PhoneNumberAltFormatsMetadataGenerator(args).start();

      case 'timezone':
        return TimezoneMetadataGenerator(args).start();

      case 'geocoding':
        return GeocodingMetadataGenerator(args).start();

      case 'carrier':
      default:
        return 'Metadata code successfully created';
    }
  }
}
