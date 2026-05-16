import 'package:alice/api/preferences_mock.dart';

Future<Map<String, dynamic>> getPreferencesQuery() async {
  await Future.delayed(const Duration(seconds: 2));
  return {'preferences': dummyPreferences};
}