// File: lib/domain/entities/service.dart

import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

/// Service category enumeration
enum ServiceCategory {
  @JsonValue('web_development')
  webDevelopment,
  @JsonValue('graphic_design')
  graphicDesign,
  @JsonValue('content_writing')
  contentWriting,
  @JsonValue('event_planning')
  eventPlanning,
  @JsonValue('translation')
  translation,
  @JsonValue('legal')
  legal,
  @JsonValue('digital_marketing')
  digitalMarketing,
  @JsonValue('tutoring')
  tutoring,
  @JsonValue('home_services')
  homeServices,
  @JsonValue('other')
  other,
}

/// Service pricing model
enum PricingModel {
  @JsonValue('hourly')
  hourly,
  @JsonValue('fixed')
  fixed,
  @JsonValue('custom')
  custom,
}

/// Service entity representing a service offering
@JsonSerializable()
class Service {
  final String id;
  final String title;
  final String description;
  final ServiceCategory category;
  final String providerId;
  final String providerName;
  final String? providerAvatar;
  final double? providerRating;
  final int? providerReviews;
  final PricingModel pricingModel;
  final double? price;
  final String? priceDescription;
  final List<String> tags;
  final List<String> images;
  final List<String> features;
  final bool isActive;
  final bool isFeatured;
  final int views;
  final int favorites;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Service({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.providerId,
    required this.providerName,
    this.providerAvatar,
    this.providerRating,
    this.providerReviews,
    required this.pricingModel,
    this.price,
    this.priceDescription,
    required this.tags,
    required this.images,
    required this.features,
    this.isActive = true,
    this.isFeatured = false,
    this.views = 0,
    this.favorites = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create a copy of this service with updated fields
  Service copyWith({
    String? id,
    String? title,
    String? description,
    ServiceCategory? category,
    String? providerId,
    String? providerName,
    String? providerAvatar,
    double? providerRating,
    int? providerReviews,
    PricingModel? pricingModel,
    double? price,
    String? priceDescription,
    List<String>? tags,
    List<String>? images,
    List<String>? features,
    bool? isActive,
    bool? isFeatured,
    int? views,
    int? favorites,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Service(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      providerId: providerId ?? this.providerId,
      providerName: providerName ?? this.providerName,
      providerAvatar: providerAvatar ?? this.providerAvatar,
      providerRating: providerRating ?? this.providerRating,
      providerReviews: providerReviews ?? this.providerReviews,
      pricingModel: pricingModel ?? this.pricingModel,
      price: price ?? this.price,
      priceDescription: priceDescription ?? this.priceDescription,
      tags: tags ?? this.tags,
      images: images ?? this.images,
      features: features ?? this.features,
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
      views: views ?? this.views,
      favorites: favorites ?? this.favorites,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Get formatted price string
  String get formattedPrice {
    if (price == null) return 'Custom Quote';
    
    switch (pricingModel) {
      case PricingModel.hourly:
        return 'GH₵ ${price!.toStringAsFixed(0)}/hour';
      case PricingModel.fixed:
        return 'GH₵ ${price!.toStringAsFixed(0)}';
      case PricingModel.custom:
        return priceDescription ?? 'Custom Quote';
    }
  }

  /// Get category display name
  String get categoryDisplayName {
    switch (category) {
      case ServiceCategory.webDevelopment:
        return 'Web Development';
      case ServiceCategory.graphicDesign:
        return 'Graphic Design';
      case ServiceCategory.contentWriting:
        return 'Content Writing';
      case ServiceCategory.eventPlanning:
        return 'Event Planning';
      case ServiceCategory.translation:
        return 'Translation';
      case ServiceCategory.legal:
        return 'Legal Services';
      case ServiceCategory.digitalMarketing:
        return 'Digital Marketing';
      case ServiceCategory.tutoring:
        return 'Tutoring & Education';
      case ServiceCategory.homeServices:
        return 'Home Services';
      case ServiceCategory.other:
        return 'Other';
    }
  }

  /// Get category icon
  String get categoryIcon {
    switch (category) {
      case ServiceCategory.webDevelopment:
        return 'assets/images/featured_web_dev.jpg';
      case ServiceCategory.graphicDesign:
        return 'assets/images/featured_logo_design.jpg';
      case ServiceCategory.contentWriting:
        return 'assets/images/featured_content_writing.jpg';
      case ServiceCategory.eventPlanning:
        return 'assets/images/featured_events.jpg';
      case ServiceCategory.translation:
        return 'assets/images/featured_translation.jpg';
      case ServiceCategory.legal:
        return 'assets/images/featured_legal.jpg';
      default:
        return 'assets/images/featured_web_dev.jpg';
    }
  }

  /// Factory constructor from JSON
  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$ServiceToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Service && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Service(id: $id, title: $title, category: $category)';
  }
} 