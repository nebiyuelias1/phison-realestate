import 'package:phison_realestate_mobile/api/core/models/paginated_response.dart';
import 'package:phison_realestate_mobile/api/property/property_api_client.dart';

import '../../api/property/models/property.dart';

class PropertiesRepository {
  final PropertyApiClient _propertyApiClient;

  PropertiesRepository({PropertyApiClient? client})
      : _propertyApiClient = client ?? PropertyApiClient.create();

  Future<PaginatedResponse<Property>> getProperties(
      {bool isFeatured = false, String? after}) {
    return _propertyApiClient.queryProperties(
      isFeatured: isFeatured,
      after: after,
    );
  }

  Future<Property> getPropertyDetail(String propertyId) async {
    return await _propertyApiClient.queryProperty(propertyId);
  }
}
