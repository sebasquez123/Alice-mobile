

import 'package:alice/config.dart';

final logger = LoggerConfig(instanceName: 'adds_model').logger;

class Adds {
  String _addId;
  int _liked;
  String _title;
  String _description;
  List<String> _tags;
  List<String> _images;
  DateTime _createdAt;
  DateTime _updatedAt;
  
  Adds({
    required String addId,
    required int liked,
    required String title,
    required String description,
    required List<String> tags,
    required List<String> images,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : _addId = addId,
       _liked = liked,
       _title = title,
       _description = description,
       _tags = tags,
       _images = images,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  String get addId => _addId;
  int get liked => _liked;
  String get title => _title;
  String get description => _description;
  List<String> get images => _images;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;

  List<String> get tags {
    final Set<String> uniqueTags = {};
    for (final tag in _tags) {
      uniqueTags.add('@${tag.trim()}');
    }
    return uniqueTags.toList();
  }

  factory Adds.fromJson(Map<String, dynamic> json) {
      try {
        final Set<String> missingElements = {};
        dynamic validateTemplate(dynamic value, dynamic defaults, String fieldName) {
          if (value == null) {
            missingElements.add(fieldName);
            return defaults;
          }
          return value;
        }
    
        final Adds data = Adds(
          addId: validateTemplate(json['addId'], '', 'addId'),
          liked: validateTemplate(json['liked'], 0, 'liked'),
          title: validateTemplate(json['title'], '', 'title'),
          description: validateTemplate(json['description'], '', 'description'),
          tags: List<String>.from(validateTemplate(json['tags'], [], 'tags')),
          images: List<String>.from(validateTemplate(json['images'], [], 'images')),
          createdAt: DateTime.parse(validateTemplate(json['createdAt'], DateTime.now().toIso8601String(), 'createdAt')),
          updatedAt: DateTime.parse(validateTemplate(json['updatedAt'], DateTime.now().toIso8601String(), 'updatedAt')),
        );
        if (missingElements.isNotEmpty) throw Exception(missingElements.join(', '));
        return data;
      } catch (e) {
        logger.e('[Add] No enough data to load add: [${e.toString()} \n]');
        rethrow;
      }
    }
}
