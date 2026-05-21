

import 'package:alice/config.dart';

final logger = LoggerConfig(instanceName: 'mostrarios_model').logger;

class Mostrarios {
  String _mostrarioId;
  String _title;
  String _description;
  List<String> _images;
  String _category;
  DateTime _createdAt;
  DateTime _updatedAt;
  
  Mostrarios({
    required String mostrarioId,
    required String title,
    required String description,
    required List<String> images,
    required String category,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : _mostrarioId = mostrarioId,
       _title = title,
       _description = description,
       _images = images,
       _category = category,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  String get mostrarioId => _mostrarioId;
  String get title => _title;
  String get description => _description;
  List<String> get images => _images;
  String get category => _category;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;

  factory Mostrarios.fromJson(Map<String, dynamic> json) {
    try {
      final Set<String> missingElements = {};
      
      dynamic validateTemplate(dynamic value, dynamic defaults, String fieldName) {
        if (value == null) {
          missingElements.add(fieldName);
          return defaults;
        }
        return value;
      }

      final Mostrarios data = Mostrarios(
        mostrarioId: validateTemplate(json['mostrario_id'], '', 'mostrario_id'),
        title: validateTemplate(json['title'], '', 'title'),
        description: validateTemplate(json['description'], '', 'description'),
        images: List<String>.from(validateTemplate(json['images'], [], 'images')),
        category: validateTemplate(json['category'], '', 'category'),
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
