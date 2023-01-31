import '../../api/core/models/paginated_response.dart';

abstract class ItemRepository<T> {
  Future<PaginatedResponse<Object>> getItems(T param);
}
