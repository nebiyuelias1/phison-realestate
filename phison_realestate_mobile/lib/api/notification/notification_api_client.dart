import 'package:graphql/client.dart';
import 'package:phison_realestate_mobile/api/core/graph_ql_client.dart';
import 'package:phison_realestate_mobile/api/core/models/paginated_response.dart';
import 'package:phison_realestate_mobile/api/notification/queries/all_notifications_query.dart';

import 'models/notification.dart';

class QueryNotificationsFailure implements Exception {
  final String? message;

  QueryNotificationsFailure({this.message});
}

class NotificationApiClient {
  final GraphQLClient _graphQLClient;

  NotificationApiClient({required GraphQLClient graphQLClient})
      : _graphQLClient = graphQLClient;

  factory NotificationApiClient.create({String? authToken}) {
    return NotificationApiClient(
      graphQLClient: getGraphQLClient(
        authToken: authToken,
      ),
    );
  }

  Future<PaginatedResponse<Notification>> getNotification({
    bool? isRead,
    String? after,
  }) async {
    final queryOption = QueryOptions(
      document: gql(allNotificationsQuery),
      variables: {
        "isRead": isRead,
        "after": after,
      },
    );

    final result = await _graphQLClient.query(queryOption);

    if (result.hasException) {
      throw QueryNotificationsFailure(
          message: result.exception?.graphqlErrors.first.message);
    }

    final data = result.data!['allUserNotifications'];
    Map<String, dynamic> jsonMap = {
      ...data['pageInfo'],
      'items': data['edges']
    };

    return PaginatedResponse<Notification>.fromJson(
        jsonMap, (json) => Notification.fromJson((json as Map)['node']));
  }

  Future<bool> hasUnreadNotifications() async {
    final queryOption = QueryOptions(
        document: gql(allNotificationsQuery),
        variables: const {"isRead": false});

    final result = await _graphQLClient.query(queryOption);

    final data = result.data!['allUserNotifications'];

    return data['edges'].length > 0;
  }
}
