import 'package:graphql/client.dart';
import 'package:phison_realestate_mobile/api/payment_schedule/models/payment_schedule.dart';
import 'package:phison_realestate_mobile/api/payment_schedule/queries/all_user_payment_schedules_query.dart';
import 'package:phison_realestate_mobile/api/payment_schedule/queries/usd_to_etb_exchange_rate_query.dart';

import '../core/graph_ql_client.dart';
import '../core/models/paginated_response.dart';

class QueryPaymentScheduleFailure implements Exception {
  final String? message;

  QueryPaymentScheduleFailure({this.message});
}

class GetExchangeRateFailure implements Exception {}

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

    final data = result.data!['allUserPaymentSchedules'];
    Map<String, dynamic> jsonMap = {
      ...data['pageInfo'],
      'items': data['edges']
    };

    return PaginatedResponse<PaymentSchedule>.fromJson(jsonMap, (json) {
      final paymentScheduleJsonMap = (json as Map)['node'];
      return PaymentSchedule.fromJson({
        ...paymentScheduleJsonMap,
        'property': paymentScheduleJsonMap['buyer']['property']
      });
    });
  }

  Future<double> getUsdToEtbExchangeRate() async {
    final queryOption = QueryOptions(document: gql(usdToEtbExchangeRateQuery));

    final result = await _graphQLClient.query(queryOption);

    if (result.hasException) {
      throw GetExchangeRateFailure();
    }

    return result.data!['usdToEtbRate'];
  }
}
