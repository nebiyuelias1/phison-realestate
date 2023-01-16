import 'package:graphql/client.dart';
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

  Future<List<Property>> queryProperties({bool isFeatured = false}) async {
    final queryOption = QueryOptions(
      document: gql(allPropertiesQuery),
      variables: {
        "isFeatured": isFeatured
      }
    );

    final result = await _graphQLClient.query(queryOption);
    if (result.hasException) {
      throw QueryPropertiesFailure();
    }

    return (result.data?['allProperties']['edges'] as List<dynamic>)
        .map((p) => Property.fromJson(p['node']))
        .toList();
  }
}
