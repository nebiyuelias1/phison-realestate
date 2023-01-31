import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:graphql/client.dart';

GraphQLClient getGraphQLClient({String? authToken}) {
  String baseUrl = FlavorConfig.instance.variables["baseUrl"];
  List<Link> links = [
    HttpLink('$baseUrl/graphql',
        defaultHeaders: authToken == null ? {} : {"Authorization": authToken}),
  ];

  final link = Link.from(links);

  return GraphQLClient(link: link, cache: GraphQLCache());
}
