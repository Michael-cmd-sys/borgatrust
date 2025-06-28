// File: lib/domain/entities/user.dart

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// User role enumeration
enum UserRole {
  @JsonValue('client')
  client,
  @JsonValue('service_agent')
  serviceAgent,
  @JsonValue('none')
  none,
}

/// User entity representing a user in the system
@JsonSerializable()
class User {
  final String id;
  final String fullName;
  final String email;
  final UserRole role;
  final String? phone;
  final String? location;
  final String? avatarUrl;
  final String? bio;
  final DateTime memberSince;
  final bool isVerified;
  final bool isActive;
  final DateTime? lastLoginAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Service agent specific fields
  final String? businessName;
  final String? businessEmail;
  final String? businessRegNumber;
  final List<String>? servicesOffered;
  final double? rating;
  final int? totalReviews;
  final int? completedJobs;

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    this.phone,
    this.location,
    this.avatarUrl,
    this.bio,
    required this.memberSince,
    this.isVerified = false,
    this.isActive = true,
    this.lastLoginAt,
    required this.createdAt,
    required this.updatedAt,
    this.businessName,
    this.businessEmail,
    this.businessRegNumber,
    this.servicesOffered,
    this.rating,
    this.totalReviews,
    this.completedJobs,
  });

  /// Create a copy of this user with updated fields
  User copyWith({
    String? id,
    String? fullName,
    String? email,
    UserRole? role,
    String? phone,
    String? location,
    String? avatarUrl,
    String? bio,
    DateTime? memberSince,
    bool? isVerified,
    bool? isActive,
    DateTime? lastLoginAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? businessName,
    String? businessEmail,
    String? businessRegNumber,
    List<String>? servicesOffered,
    double? rating,
    int? totalReviews,
    int? completedJobs,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      memberSince: memberSince ?? this.memberSince,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      businessName: businessName ?? this.businessName,
      businessEmail: businessEmail ?? this.businessEmail,
      businessRegNumber: businessRegNumber ?? this.businessRegNumber,
      servicesOffered: servicesOffered ?? this.servicesOffered,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      completedJobs: completedJobs ?? this.completedJobs,
    );
  }

  /// Check if user is a service agent
  bool get isServiceAgent => role == UserRole.serviceAgent;

  /// Check if user is a client
  bool get isClient => role == UserRole.client;

  /// Get display name (business name for agents, full name for clients)
  String get displayName => isServiceAgent && businessName != null 
      ? businessName! 
      : fullName;

  /// Get display email (business email for agents, personal email for clients)
  String get displayEmail => isServiceAgent && businessEmail != null 
      ? businessEmail! 
      : email;

  /// Factory constructor from JSON
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'User(id: $id, fullName: $fullName, email: $email, role: $role)';
  }
} 