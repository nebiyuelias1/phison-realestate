import 'package:json_annotation/json_annotation.dart';

part 'paginated_response.g.dart';

@JsonSerializable(
    createToJson: false, createFactory: true, genericArgumentFactories: true)
class PaginatedResponse<T> {
  final bool hasNextPage;
  final String endCursor;
  final List<T> items;

  PaginatedResponse(
      {required this.hasNextPage,
      required this.endCursor,
      required this.items});

  factory PaginatedResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PaginatedResponseFromJson(json, fromJsonT);
}
