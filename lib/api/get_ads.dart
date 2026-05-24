import 'package:alice/api/mocks/index.dart';

Future<Map<String, dynamic>> getAdsQuery() async {
  await Future.delayed(const Duration(seconds: 2));
  return {'ads': dummyAds};
}