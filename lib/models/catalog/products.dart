

import 'package:alice/config.dart';

final logger = LoggerConfig(instanceName: 'products_model').logger;

class Products {
  String _standardProductId;
  String _title;
  String _description;
  List<String> _images;
  String _category;
  double _cost;
  DateTime _createdAt;
  DateTime _updatedAt;
  
  Products({
    required String standardProductId,
    required String title,
    required String description,
    required List<String> images,
    required String category,
    required double cost,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : _standardProductId = standardProductId,
       _title = title,
       _description = description,
       _images = images,
       _category = category,
       _cost = cost,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  String get standardProductId => _standardProductId;
  String get title => _title;
  String get description => _description;
  List<String> get images => _images;
  String get category => _category;
  double get cost => _cost;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;

  factory Products.fromJson(Map<String, dynamic> json) {
    try {
      final Set<String> missingElements = {};
      
      dynamic validateTemplate(dynamic value, dynamic defaults, String fieldName) {
        if (value == null) {
          missingElements.add(fieldName);
          return defaults;
        }
        return value;
      }

      final Products data = Products(
        standardProductId: validateTemplate(json['standard_product_id'], '', 'standard_product_id'),
        title: validateTemplate(json['title'], '', 'title'),
        description: validateTemplate(json['description'], '', 'description'),
        images: List<String>.from(validateTemplate(json['images'], [], 'images')),
        category: validateTemplate(json['category'], '', 'category'),
        cost: validateTemplate(json['cost'], 0.0, 'cost').toDouble(),
        createdAt: DateTime.parse(validateTemplate(json['createdAt'], DateTime.now().toIso8601String(), 'createdAt')),
        updatedAt: DateTime.parse(validateTemplate(json['updatedAt'], DateTime.now().toIso8601String(), 'updatedAt')),
      );
      
      if (missingElements.isNotEmpty) throw Exception(missingElements.join(', '));
      return data;
    } catch (e) {
      logger.e('Not enough data: [${e.toString()}]');
      rethrow;
    }
  }
}
