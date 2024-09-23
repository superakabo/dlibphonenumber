import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<void> main() {
  return _hasNewRelease();
}

/// Check and compare release ids to see if a new release
/// has been published.
Future<void> _hasNewRelease() async {
  final String existingRelease = await _getReleaseId();
  final String newRelease = await _checkForNewRelease();
  final bool isNewRelease = (existingRelease != newRelease);

  if (isNewRelease) {
    await _saveReleaseId(newRelease);
  }

  print(isNewRelease);
}

/// Fetch the latest release id from the libphonenumber repository.
Future<String> _checkForNewRelease() async {
  final Uri url = Uri.parse('https://api.github.com/repos/google/libphonenumber/releases/latest');

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/vnd.github+json',
  };

  final http.Response response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final Map<String, dynamic> payload = jsonDecode(response.body);
    return payload['id'].toString();
  }

  return '';
}

/// Read the last used release id for libphonenumber.
Future<String> _getReleaseId() async {
  final File file = File('source_release_id');

  if (file.existsSync()) {
    return file.readAsString();
  }

  return '';
}

/// Save the latest release id for libphonenumber.
Future<void> _saveReleaseId(String releaseId) async {
  final File file = File('source_release_id');

  if (!file.existsSync()) {
    await file.create();
  }

  file.writeAsString(releaseId);
}