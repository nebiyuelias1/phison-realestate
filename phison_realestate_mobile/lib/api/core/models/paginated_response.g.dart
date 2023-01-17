// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedResponse<T> _$PaginatedResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginatedResponse<T>(
      hasNextPage: json['hasNextPage'] as bool,
      endCursor: json['endCursor'] as String?,
      items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
    );
