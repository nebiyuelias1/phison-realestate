import 'package:phison_realestate_mobile/api/core/models/paginated_response.dart';
import 'package:phison_realestate_mobile/api/payment_schedule/models/payment_schedule.dart';
import 'package:phison_realestate_mobile/api/payment_schedule/payment_schedule_api_client.dart';
import 'package:phison_realestate_mobile/repositories/core/item_repository.dart';
import 'package:phison_realestate_mobile/repositories/core/query_items_failure.dart';
import 'package:phison_realestate_mobile/repositories/payment_schedule_repository/payment_schedule_query_param.dart';

class PaymentScheduleRepository
    extends ItemRepository<PaymentScheduleQueryParam> {
  final PaymentScheduleApiClient _paymentScheduleApiClient;

  PaymentScheduleRepository({PaymentScheduleApiClient? client})
      : _paymentScheduleApiClient = client ?? PaymentScheduleApiClient.create();

  @override
  Future<PaginatedResponse<PaymentSchedule>> getItems(
      PaymentScheduleQueryParam param) async {
    try {
      return await _paymentScheduleApiClient.getPaymentSchedules(
          after: param.after);
    } on QueryPaymentScheduleFailure catch (e) {
      throw QueryItemsFailure(message: e.message);
    }
  }

  Future<double> getUsdToEtbExchangeRate() async {
    return await _paymentScheduleApiClient.getUsdToEtbExchangeRate();
  }
}
