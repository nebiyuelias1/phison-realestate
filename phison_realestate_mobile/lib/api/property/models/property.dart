import 'package:json_annotation/json_annotation.dart';

part 'property.g.dart';

enum PropertyType { apartment, villa }

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

  Property({
    required this.id,
    required this.name,
    required this.bedRoomCount,
    required this.size,
    required this.location,
    required this.address,
    required this.propertyType,
    required this.propertyImage,
    required this.video,
    required this.description,
  });

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  static PropertyType _propertyTypeFromJson(String value) {
    if (value == "VI") {
      return PropertyType.villa;
    }

    return PropertyType.apartment;
  }
}
