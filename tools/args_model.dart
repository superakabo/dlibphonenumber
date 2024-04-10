import 'package:args/args.dart';

class ArgsModel {
  final String inputFilePath;
  final String outputDirectory;
  final String metadataType;
  final String outputFileFormat;

  const ArgsModel({
    required this.inputFilePath,
    required this.outputDirectory,
    required this.metadataType,
    required this.outputFileFormat,
  });

  factory ArgsModel.fromArgResult(ArgResults? args) {
    return ArgsModel(
      inputFilePath: args?['input'] ?? '',
      outputDirectory: args?['output'] ?? '',
      metadataType: args?['type'] ?? '',
      outputFileFormat: args?['format'] ?? '',
    );
  }

  String validate() {
    if (inputFilePath.isEmpty) {
      return '"input" cannot be empty.';
    }
    if (outputDirectory.isEmpty) {
      return '"output" cannot be empty.';
    }
    if (metadataType.isEmpty) {
      return '"type" cannot be empty.';
    }
    return '';
  }
}
