import 'package:graphql/client.dart';
import 'package:phison_realestate_mobile/api/payment_schedule/models/payment_schedule.dart';
import 'package:phison_realestate_mobile/api/payment_schedule/queries/all_user_payment_schedules_query.dart';

import '../core/graph_ql_client.dart';
import '../core/models/paginated_response.dart';

class QueryPaymentScheduleFailure implements Exception {
  final String? message;

  QueryPaymentScheduleFailure({this.message});
}

class PaymentScheduleApiClient {
  final GraphQLClient _graphQLClient;

  PaymentScheduleApiClient({required GraphQLClient graphQLClient})
      : _graphQLClient = graphQLClient;

  factory PaymentScheduleApiClient.create({String? authToken}) {
    return PaymentScheduleApiClient(
      graphQLClient: getGraphQLClient(
        authToken: authToken,
      ),
    );
  }

  Future<PaginatedResponse<PaymentSchedule>> getPaymentSchedules({
    String? after,
  }) async {
    final queryOption = QueryOptions(
      document: gql(allUserPaymentScheduleQuery),
      variables: {
        "after": after,
      },
    );

    final result = await _graphQLClient.query(queryOption);

    if (result.hasException) {
      throw QueryPaymentScheduleFailure(
          message: result.exception?.graphqlErrors.first.message);
    }

    final data = result.data!['allUserNotifications'];
    Map<String, dynamic> jsonMap = {
      ...data['pageInfo'],
      'items': data['edges']
    };

    return PaginatedResponse<PaymentSchedule>.fromJson(
        jsonMap, (json) => PaymentSchedule.fromJson((json as Map)['node']));
  }
}
