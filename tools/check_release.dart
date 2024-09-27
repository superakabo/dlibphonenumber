import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<void> main() async {
  return await _hasNewRelease();
}

/// Check and compare release ids to see if a new release
/// has been published.
Future<void> _hasNewRelease() async {
  final String existingRelease = _getReleaseId();
  final String newRelease = await _checkForNewRelease();

  if (newRelease.isNotEmpty) {
    _saveReleaseId(newRelease);
  }

  if (existingRelease.isEmpty || (existingRelease != newRelease)) {
    print(true);
  } else {
    print(false);
  }
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

File get _file {
  return File('./source_release_id');
}

/// Read the last used release id for libphonenumber.
String _getReleaseId() {
  if (_file.existsSync()) {
    return _file.readAsStringSync();
  }
  return '';
}

/// Save the latest release id for libphonenumber.
void _saveReleaseId(String releaseId) {
  if (!_file.existsSync()) {
    _file.createSync();
  }
  return _file.writeAsStringSync(releaseId);
}
