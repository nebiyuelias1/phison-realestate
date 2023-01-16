import 'package:phison_realestate_mobile/api/property/property_api_client.dart';

import '../../api/property/models/property.dart';

class PropertiesRepository {
  final PropertyApiClient _propertyApiClient;

  PropertiesRepository({PropertyApiClient? client})
      : _propertyApiClient = client ?? PropertyApiClient.create();

  Future<List<Property>> getProperties({bool isFeatured = false}) {
    return _propertyApiClient.queryProperties(isFeatured: isFeatured);
  }
}
