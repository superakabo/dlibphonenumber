import 'package:args/command_runner.dart';
import '../metadata_command.dart';

void main(List<String> args) async {
  final runner = CommandRunner<String>(
    'dlibphonenumber',
    'A command-line utility to generate metadata files for dlibphonenumber',
  )..addCommand(MetadataCommand());

  final String? output = await runner.run(args);
  print(output);
}
