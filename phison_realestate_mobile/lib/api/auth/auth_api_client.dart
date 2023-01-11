import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:graphql/client.dart';
import 'package:phison_realestate_mobile/api/auth/mutations/register_user_mutation.dart';
import 'package:phison_realestate_mobile/api/models/register_user.dart';

class RegisterUserFailure implements Exception {}

class AuthApiClient {
  final GraphQLClient _graphQLClient;

  AuthApiClient({required GraphQLClient graphQLClient})
      : _graphQLClient = graphQLClient;

  factory AuthApiClient.create() {
    String baseUrl = FlavorConfig.instance.variables["baseUrl"];
    final httpLink = HttpLink('$baseUrl/graphql');
    final link = Link.from([httpLink]);

    return AuthApiClient(
      graphQLClient: GraphQLClient(cache: GraphQLCache(), link: link),
    );
  }

  Future<void> registerUser(RegisterUser model) async {
    final MutationOptions options = MutationOptions(
      document: gql(registerUserMutation),
      variables: model.toJson(),
    );

    final result = await _graphQLClient.mutate(options);

    if (result.hasException) {
      throw RegisterUserFailure();
    }
  }
}
