// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String?,
      memberSince: DateTime.parse(json['memberSince'] as String),
      isVerified: json['isVerified'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      businessName: json['businessName'] as String?,
      businessEmail: json['businessEmail'] as String?,
      businessRegNumber: json['businessRegNumber'] as String?,
      servicesOffered: (json['servicesOffered'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      rating: (json['rating'] as num?)?.toDouble(),
      totalReviews: (json['totalReviews'] as num?)?.toInt(),
      completedJobs: (json['completedJobs'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'role': _$UserRoleEnumMap[instance.role]!,
      'phone': instance.phone,
      'location': instance.location,
      'avatarUrl': instance.avatarUrl,
      'bio': instance.bio,
      'memberSince': instance.memberSince.toIso8601String(),
      'isVerified': instance.isVerified,
      'isActive': instance.isActive,
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'businessName': instance.businessName,
      'businessEmail': instance.businessEmail,
      'businessRegNumber': instance.businessRegNumber,
      'servicesOffered': instance.servicesOffered,
      'rating': instance.rating,
      'totalReviews': instance.totalReviews,
      'completedJobs': instance.completedJobs,
    };

const _$UserRoleEnumMap = {
  UserRole.client: 'client',
  UserRole.serviceAgent: 'service_agent',
  UserRole.none: 'none',
};
