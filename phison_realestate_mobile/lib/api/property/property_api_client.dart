import 'package:graphql/client.dart';
import 'package:phison_realestate_mobile/api/core/models/paginated_response.dart';
import 'package:phison_realestate_mobile/api/property/queries/all_properties_query.dart';

import '../core/graph_ql_client.dart';
import 'models/property.dart';

class QueryPropertiesFailure implements Exception {
  final String message;

  QueryPropertiesFailure({String? message})
      : message = message ?? 'Something went wrong.';
}

class PropertyApiClient {
  final GraphQLClient _graphQLClient;

  PropertyApiClient({required GraphQLClient graphQLClient})
      : _graphQLClient = graphQLClient;

  factory PropertyApiClient.create() {
    return PropertyApiClient(
      graphQLClient: getGraphQLClient(),
    );
  }

  Future<PaginatedResponse<Property>> queryProperties(
      {bool isFeatured = false, String? after}) async {
    final queryOption = QueryOptions(
        document: gql(allPropertiesQuery),
        variables: {"isFeatured": isFeatured, "after": after});

    final result = await _graphQLClient.query(queryOption);
    if (result.hasException) {
      throw QueryPropertiesFailure();
    }

    final data = result.data!['allProperties'];
    Map<String, dynamic> jsonMap = {
      ...data['pageInfo'],
      'items': data['edges'],
    };
    return PaginatedResponse<Property>.fromJson(
        jsonMap, (json) => Property.fromJson((json as Map)['node']));
  }
}
