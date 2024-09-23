import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:yaml_edit/yaml_edit.dart';

Future<void> main() {
  return _updateChangeLog();
}

///
/// Start the process to update the changelog.md with
/// the latest release notes and increment the
/// semantic versioning number.
///
Future<void> _updateChangeLog() async {
  final File releaseNotesFile = File('resources/release_notes.txt');
  final File changelogFile = File('CHANGELOG.md');

  final String currentReleaseNotes = await _readReleaseNotes(releaseNotesFile);
  final String currentChangelog = await _readChangelog(changelogFile);

  if (currentReleaseNotes != currentChangelog) {
    final String versionNumber = await _updateVersionInPubspecYaml();
    final String changelog = await changelogFile.readAsString();
    final String contents = '## $versionNumber\n$currentReleaseNotes\n$changelog';
    await changelogFile.writeAsString(contents);

    // The output from this print statement is used
    // by the bash script to commit changes to the GitHub repo.
    print('$versionNumber|$currentReleaseNotes');
  }
}

///
/// Updates the version number of the pubspec.yaml file
/// This function returns the latest version number that was applied.
///
Future<String> _updateVersionInPubspecYaml() async {
  final File file = File('pubspec.yaml');
  final YamlEditor yamlContent = await _readPubspecYaml(file);

  final String currentVersionNumber = yamlContent.parseAt(['version']).value;
  final String newVersionNumber = _increaseVersion(currentVersionNumber);

  yamlContent.update(['version'], newVersionNumber);
  await file.writeAsString(yamlContent.toString());

  return newVersionNumber;
}

///
/// Increase the semantic versioning for every release.
/// The minor and major version numbers will be
/// incremented after every 100 cycles.
///
String _increaseVersion(String version) {
  final List<String> semVer = version.split('.');
  int major = int.parse(semVer[0]);
  int minor = int.parse(semVer[1]);
  int patch = int.parse(semVer[2]);

  patch += 1;

  if (patch == 100) {
    patch = 0;
    minor += 1;
  }

  if (minor == 100) {
    minor = 0;
    major += 1;
  }

  return '$major.$minor.$patch';
}

///
/// Reads the pubspec.yaml file for this project.
///
Future<YamlEditor> _readPubspecYaml(File file) async {
  final String yamlContent = await file.readAsString();
  return YamlEditor(yamlContent);
}

///
/// Reads a file for the most recent release notes
/// and stops when it reads an empty line.
/// An empty line marks the end of the latest release notes.
///
Future<String> _readReleaseNotes(File file) {
  late StreamSubscription<String> subscription;
  final StringBuffer stringBuffer = StringBuffer();
  final Completer<String> completer = Completer<String>();
  bool startsWithMetadataChanges = false;

  subscription = file.openRead().transform(utf8.decoder).transform(LineSplitter()).listen((lineOfText) {
    lineOfText = lineOfText.trim();

    if (lineOfText.contains('Metadata changes:') || lineOfText.contains('Metadata change')) {
      startsWithMetadataChanges = true;
    }

    // We are only interested in metadata change-log
    if (startsWithMetadataChanges) {
      if (lineOfText.isNotEmpty) {
        _parseNotes(lineOfText, stringBuffer);
      } else {
        subscription.cancel();
        completer.complete(stringBuffer.toString());
      }
    }
  });

  return completer.future;
}

/// Reads the projects change-log file for comparisons.
Future<String> _readChangelog(File file) {
  late StreamSubscription<String> subscription;
  final StringBuffer stringBuffer = StringBuffer();
  final Completer<String> completer = Completer<String>();

  subscription = file.openRead().transform(utf8.decoder).transform(LineSplitter()).listen((lineOfText) {
    lineOfText = lineOfText.trim();

    if (lineOfText.isNotEmpty) {
      _parseNotes(lineOfText, stringBuffer);
    } else {
      subscription.cancel();
      completer.complete(stringBuffer.toString());
    }
  });

  return completer.future;
}

///
/// Formats text from for example
/// source:
/// - Updated phone metadata for region code(s):
///   AU, CC, CX, CZ, GF, MH, MQ, TH, YT
///
/// into:
/// - Updated phone metadata for region code(s): AU, CC, CX, CZ, GF, MH, MQ, TH, YT
///
void _parseNotes(String lineOfText, StringBuffer notesBuffer) {
  // Some paragraghs do not have line breaks.
  // We write them as they are.
  if (lineOfText.startsWith('-') && !lineOfText.endsWith(':')) {
    notesBuffer.writeln(lineOfText);
  }

  // Some paragraphs have been split into 2 lines.
  // We correct them by writing the first part on a line.
  else if (lineOfText.startsWith('-') && lineOfText.endsWith(':')) {
    notesBuffer.write(lineOfText);
  }

  // We append the 2nd line to it so that they all appear on the same line.
  else if (notesBuffer.isNotEmpty && notesBuffer.toString()[notesBuffer.length - 1] == ":") {
    notesBuffer.writeln(' $lineOfText');
  }
}
