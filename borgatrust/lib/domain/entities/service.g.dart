// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$ServiceCategoryEnumMap, json['category']),
      providerId: json['providerId'] as String,
      providerName: json['providerName'] as String,
      providerAvatar: json['providerAvatar'] as String?,
      providerRating: (json['providerRating'] as num?)?.toDouble(),
      providerReviews: (json['providerReviews'] as num?)?.toInt(),
      pricingModel: $enumDecode(_$PricingModelEnumMap, json['pricingModel']),
      price: (json['price'] as num?)?.toDouble(),
      priceDescription: json['priceDescription'] as String?,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      features:
          (json['features'] as List<dynamic>).map((e) => e as String).toList(),
      isActive: json['isActive'] as bool? ?? true,
      isFeatured: json['isFeatured'] as bool? ?? false,
      views: (json['views'] as num?)?.toInt() ?? 0,
      favorites: (json['favorites'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': _$ServiceCategoryEnumMap[instance.category]!,
      'providerId': instance.providerId,
      'providerName': instance.providerName,
      'providerAvatar': instance.providerAvatar,
      'providerRating': instance.providerRating,
      'providerReviews': instance.providerReviews,
      'pricingModel': _$PricingModelEnumMap[instance.pricingModel]!,
      'price': instance.price,
      'priceDescription': instance.priceDescription,
      'tags': instance.tags,
      'images': instance.images,
      'features': instance.features,
      'isActive': instance.isActive,
      'isFeatured': instance.isFeatured,
      'views': instance.views,
      'favorites': instance.favorites,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$ServiceCategoryEnumMap = {
  ServiceCategory.webDevelopment: 'web_development',
  ServiceCategory.graphicDesign: 'graphic_design',
  ServiceCategory.contentWriting: 'content_writing',
  ServiceCategory.eventPlanning: 'event_planning',
  ServiceCategory.translation: 'translation',
  ServiceCategory.legal: 'legal',
  ServiceCategory.digitalMarketing: 'digital_marketing',
  ServiceCategory.tutoring: 'tutoring',
  ServiceCategory.homeServices: 'home_services',
  ServiceCategory.other: 'other',
};

const _$PricingModelEnumMap = {
  PricingModel.hourly: 'hourly',
  PricingModel.fixed: 'fixed',
  PricingModel.custom: 'custom',
};
