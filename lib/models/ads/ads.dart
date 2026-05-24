

import 'package:alice/config.dart';

final logger = LoggerConfig(instanceName: 'ads_model').logger;

class Ads {
  String _adId;
  String _title;
  String _category;
  String _description;
  List<String> _tags;
  List<String> _images;
  String? _standardProductId;
  DateTime _createdAt;
  DateTime _updatedAt;
  
  Ads({
    required String adId,
    required String title,
    required String category,
    required String description,
    required List<String> tags,
    required List<String> images,
    String? standardProductId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : _adId = adId,
       _title = title,
       _category = category,
       _description = description,
       _tags = tags,
       _images = images,
       _standardProductId = standardProductId,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  String get adId => _adId;
  String get title => _title;
  String get category => _category;
  String get description => _description;
  List<String> get images => _images;
  String? get standardProductId => _standardProductId;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;

  List<String> get tags {
    final Set<String> uniqueTags = {};
    for (final tag in _tags) {
      uniqueTags.add('#${tag.trim()}');
    }
    return uniqueTags.toList();
  }

  factory Ads.fromJson(Map<String, dynamic> json) {
      try {
        final Set<String> missingElements = {};
        dynamic validateTemplate(dynamic value, dynamic defaults, String fieldName) {
          if (value == null) {
            missingElements.add(fieldName);
            return defaults;
          }
          return value;
        }
    
        final Ads data = Ads(
          adId: validateTemplate(json['ad_id'], '', 'adId'),
          title: validateTemplate(json['title'], '', 'title'),
          category: validateTemplate(json['category'], 'General', 'category'),
          description: validateTemplate(json['description'], '', 'description'),
          tags: List<String>.from(validateTemplate(json['tags'], [], 'tags')),
          images: List<String>.from(validateTemplate(json['images'], [], 'images')),
          standardProductId: json['standard_product_id'] as String?,
          createdAt: DateTime.parse(validateTemplate(json['createdAt'], DateTime.now().toIso8601String(), 'createdAt')),
          updatedAt: DateTime.parse(validateTemplate(json['updatedAt'], DateTime.now().toIso8601String(), 'updatedAt')),
        );
        if (missingElements.isNotEmpty) throw Exception(missingElements.join(', '));
        return data;
      } catch (e) {
        logger.e('No enough data to load ad: [${e.toString()} \n]');
        rethrow;
      }
    }
}
