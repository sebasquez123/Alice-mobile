import 'package:alice/api/mocks/index.dart';

Future<Map<String, dynamic>> getMostrarioQuery() async {
  await Future.delayed(const Duration(seconds: 2));
  return {'mostrario': dummyMostrario};
}