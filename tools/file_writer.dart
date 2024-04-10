import 'dart:io';
import 'dart:typed_data';

import 'args_model.dart';

class FileWriter {
  final ArgsModel args;
  const FileWriter(this.args);

  File getOutputFile(String id) {
    String directoryPath = args.outputDirectory;
    if (!directoryPath.endsWith('/')) {
      directoryPath += '/';
    }

    final dir = Directory('$directoryPath${args.metadataType}');
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    String extension = '';
    if (args.outputFileFormat == 'dart') {
      extension = '.dart';
    }

    String filePath = dir.path;
    if (!filePath.endsWith('/')) {
      filePath += '/';
    }

    return File('$filePath$id$extension');
  }

  Directory getSubDirectory() {
    final dir = Directory(args.outputDirectory);
    if (!dir.existsSync()) {
      dir.createSync();
    }

    String subDirectoryPath = dir.path;
    if (!subDirectoryPath.endsWith('/')) {
      subDirectoryPath += '/';
    }

    return Directory(subDirectoryPath);
  }

  void saveAsBytes(String id, Uint8List contents) {
    final file = getOutputFile(id);
    return file.writeAsBytesSync(contents);
  }

  void saveAsString(String id, String contents) {
    final file = getOutputFile(id);
    return file.writeAsStringSync(contents);
  }

  void saveAsStringToSubDirectory(String id, String contents) {
    final String subDirPath = getSubDirectory().path;

    String extension = '';
    if (args.outputFileFormat == 'dart') {
      extension = '.dart';
    }

    final file = File('$subDirPath$id$extension');
    return file.writeAsStringSync(contents);
  }

  void saveAsMapObject<K, V>(String comments, String id, Object? contents) {
    String key = K == dynamic ? 'String' : '$K';
    String value = V == dynamic ? 'Object?' : '$V';
    String function = '$comments Map<$key, $value> get$id() { return $contents; }';
    File file = getOutputFile(id);
    return file.writeAsStringSync(function);
  }

  void saveAsMapObjectWithFile<K, V>(String comments, File file, Object? contents) {
    String type = K == dynamic ? 'String' : '$K';
    String value = V == dynamic ? 'Object?' : '$V';
    String id = file.path.split('/').last.split('.').first;
    String function = '$comments Map<$type, $value> get$id() { return $contents; }';
    return file.writeAsStringSync(function);
  }
}
