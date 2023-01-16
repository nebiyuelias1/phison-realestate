// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      name: json['name'] as String,
      bedRoomCount: json['bedRoomCount'] as int,
      size: (json['size'] as num).toDouble(),
      location: json['location'] as String,
      address: json['address'] as String,
      propertyType:
          Property._propertyTypeFromJson(json['propertyType'] as String),
      propertyImage: json['propertyImage'] as String?,
    );
