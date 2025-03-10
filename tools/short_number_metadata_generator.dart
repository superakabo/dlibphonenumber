import 'dart:convert';
import 'dart:io';

import 'package:dlibphonenumber/generated/classes/phone_metadata/phonemetadata.pb.dart';
import 'package:xml/xml.dart';

import 'copyright_notice.dart';
import 'file_writer.dart';
import 'phone_metadata_parser.dart';

class ShortNumberMetadataGenerator extends FileWriter with PhoneMetadataParser {
  ShortNumberMetadataGenerator(super.args);

  final List<String> _importStatements = ["import 'phone_number_metadata_map.dart';"];
  final StringBuffer _territoriesMapsBuffer = StringBuffer();

  String start() {
    final File file = File(args.inputFilePath);
    final XmlDocument document = XmlDocument.parse(file.readAsStringSync());
    final Iterable<XmlElement> nodes = document.findAllElements('territory');

    for (XmlElement node in nodes) {
      final Map<String, dynamic> metadata = parseTerritory(node);
      final PhoneMetadata phoneMetadata = PhoneMetadata()..mergeFromProto3Json(metadata);
      _savePhoneMetadata(phoneMetadata);
      _buildTerritoriesMap(phoneMetadata);
    }

    _savePhoneNumberMetadataMap();
    return '${args.metadataType} metadata generated at ${args.outputDirectory}';
  }

  /// Mark: build supported territories imports and JSON data.
  void _buildTerritoriesMap(PhoneMetadata phoneMetadata) {
    String id = phoneMetadata.id;
    _importStatements.add(_getImportPath(id));
    _territoriesMapsBuffer.write("'$id': get$id(),");
  }

  String _getImportPath(String id) {
    return "import 'short_number/$id.dart';";
  }

  /// Mark: save the metadata for each country in a JSON format
  void _savePhoneMetadata(PhoneMetadata phoneMetadata) {
    String id = phoneMetadata.id;
    String ignoreStatement = '// ignore_for_file: file_names\n\n';
    String comment = '// This file is automatically generated from [${args.inputFilePath}].\n\n';
    String content = jsonEncode(phoneMetadata.toProto3Json()).replaceAll(r'$', r'\$');
    String fileOverview = '/// Short Number JSON data for $id\n';
    saveAsMapObject('$ignoreStatement$comment$fileOverview', id, content);
  }

  /// Mark: create a convenient map of all the supported countries
  /// with their JSON data
  void _savePhoneNumberMetadataMap() {
    StringBuffer stringBuffer = StringBuffer();
    String copyright = CopyrightNotice(2009, DateTime.now().year).toString();
    String fileOverview = ''
        '\n\n'
        '// [fileoverview]\n'
        '// This file is automatically generated from [${args.inputFilePath}].\n'
        '// Please do not modify it directly.\n'
        '\n\n';

    String shortNumberMetadataMap = ''
        ' class ShortNumberMetadataMap extends PhoneNumberMetadataMap {\n'
        '   const ShortNumberMetadataMap();'
        '\n\n'
        '   @override\n'
        '   Map<String, Object?>? getTerritory(String code) {\n'
        '     return _territories[code];\n'
        '   }'
        '\n\n'
        '   Map<String, Map<String, Object?>> get _territories {\n'
        '     return {${_territoriesMapsBuffer.toString()}};\n'
        '   }\n'
        ' }\n';

    stringBuffer
      ..write(copyright)
      ..write(_importStatements.join())
      ..write(fileOverview)
      ..write(shortNumberMetadataMap);

    return saveAsStringToSubDirectory(
      'short_number_metadata_map',
      stringBuffer.toString(),
    );
  }
}
