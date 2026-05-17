import 'package:alice/api/mocks/index.dart';

Future<Map<String, dynamic>> getProductsQuery() async {
  await Future.delayed(const Duration(seconds: 2));
  return {'products': dummyProducts};
}