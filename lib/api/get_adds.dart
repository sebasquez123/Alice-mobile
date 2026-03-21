import 'package:alice/api/adds_mock.dart';

Future<Map<String, dynamic>> getAddsQuery() async {
  await Future.delayed(const Duration(seconds: 2));
  return {'adds': dummyAdds};
}