import 'package:graphql/client.dart';
import 'package:phison_realestate_mobile/api/me/models/phison_user.dart';
import 'package:phison_realestate_mobile/api/me/queries/me_query.dart';

import '../core/graph_ql_client.dart';

class GetMeFailure implements Exception {
  final String? message;

  GetMeFailure({this.message});
}

class MeApiClient {
  final GraphQLClient _graphQLClient;

  MeApiClient({required GraphQLClient graphQLClient})
      : _graphQLClient = graphQLClient;

  factory MeApiClient.create({String? authToken}) {
    return MeApiClient(
      graphQLClient: getGraphQLClient(
        authToken: authToken,
      ),
    );
  }

  Future<PhisonUser> getMe() async {
    final queryOption = QueryOptions(
      document: gql(meQuery),
    );

    final result = await _graphQLClient.query(queryOption);

    if (result.hasException) {
      throw GetMeFailure(
          message: result.exception?.graphqlErrors.first.message);
    }

    final data = result.data!['me'];

    return PhisonUser.fromJson(data);
  }
}
