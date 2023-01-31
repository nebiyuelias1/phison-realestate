import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'property.g.dart';

enum PropertyType { apartment, villa }

@JsonSerializable(createFactory: true, createToJson: false)
class PropertyImage extends Equatable {
  final String id;
  final String image;
  final int height;
  final int width;

  const PropertyImage({
    required this.id,
    required this.image,
    required this.height,
    required this.width,
  });

  factory PropertyImage.fromJson(Map<String, dynamic> json) =>
      _$PropertyImageFromJson(json);

  @override
  List<Object?> get props => [id, image, height, width];
}

@JsonSerializable(createFactory: true, createToJson: false)
class PaymentInformation extends Equatable {
  final String title;
  final String timePeriod;
  final String description;
  @JsonKey(fromJson: _amountFromJson)
  final double amount;

  const PaymentInformation({
    required this.title,
    required this.timePeriod,
    required this.description,
    required this.amount,
  });

  static double _amountFromJson(String value) {
    return double.parse(value);
  }

  factory PaymentInformation.fromJson(Map<String, dynamic> json) =>
      _$PaymentInformationFromJson(json);

  @override
  List<Object?> get props => [title, timePeriod, description, amount];
}

@JsonSerializable(createFactory: true, createToJson: false)
class Property extends Equatable {
  final String id;
  final String name;
  final int bedRoomCount;
  final int bathRoomCount;
  final double size;
  final String location;
  final String address;
  @JsonKey(fromJson: _propertyTypeFromJson)
  final PropertyType propertyType;
  final String? propertyImage;
  final String? video;
  final String description;
  final List<PropertyImage> images;
  final List<PaymentInformation> paymentInfos;

  const Property({
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
    required this.bathRoomCount,
    this.images = const [],
    this.paymentInfos = const [],
  });

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  static PropertyType _propertyTypeFromJson(String value) {
    if (value == "VI") {
      return PropertyType.villa;
    }

    return PropertyType.apartment;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        bedRoomCount,
        size,
        location,
        address,
        propertyType,
        propertyImage,
        video,
        description,
        images,
        bathRoomCount,
        paymentInfos
      ];
}
