import 'package:json_annotation/json_annotation.dart';

part 'property.g.dart';

enum PropertyType { apartment, villa }

@JsonSerializable(createFactory: true, createToJson: false)
class PropertyImage {
  final String id;
  final String image;
  final int height;
  final int width;

  PropertyImage({
    required this.id,
    required this.image,
    required this.height,
    required this.width,
  });

  factory PropertyImage.fromJson(Map<String, dynamic> json) =>
      _$PropertyImageFromJson(json);
}

@JsonSerializable(createFactory: true, createToJson: false)
class Property {
  final String id;
  final String name;
  final int bedRoomCount;
  final double size;
  final String location;
  final String address;
  @JsonKey(fromJson: _propertyTypeFromJson)
  final PropertyType propertyType;
  final String? propertyImage;
  final String? video;
  final String description;
  final List<PropertyImage> images;

  Property(
      {required this.id,
      required this.name,
      required this.bedRoomCount,
      required this.size,
      required this.location,
      required this.address,
      required this.propertyType,
      required this.propertyImage,
      required this.video,
      required this.description,
      this.images = const []});

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  static PropertyType _propertyTypeFromJson(String value) {
    if (value == "VI") {
      return PropertyType.villa;
    }

    return PropertyType.apartment;
  }
}
