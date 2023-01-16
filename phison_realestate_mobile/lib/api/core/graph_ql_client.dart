import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:graphql/client.dart';

GraphQLClient getGraphQLClient() {
  String baseUrl = FlavorConfig.instance.variables["baseUrl"];
  final httpLink = HttpLink('$baseUrl/graphql');
  final link = Link.from([httpLink]);

  return GraphQLClient(link: link, cache: GraphQLCache());
}
