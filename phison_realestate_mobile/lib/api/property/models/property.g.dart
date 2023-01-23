// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyImage _$PropertyImageFromJson(Map<String, dynamic> json) =>
    PropertyImage(
      id: json['id'] as String,
      image: json['image'] as String,
      height: json['height'] as int,
      width: json['width'] as int,
    );

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      id: json['id'] as String,
      name: json['name'] as String,
      bedRoomCount: json['bedRoomCount'] as int,
      size: (json['size'] as num).toDouble(),
      location: json['location'] as String,
      address: json['address'] as String,
      propertyType:
          Property._propertyTypeFromJson(json['propertyType'] as String),
      propertyImage: json['propertyImage'] as String?,
      video: json['video'] as String?,
      description: json['description'] as String,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => PropertyImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
