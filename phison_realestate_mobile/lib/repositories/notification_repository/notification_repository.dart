import 'package:phison_realestate_mobile/api/core/models/paginated_response.dart';
import 'package:phison_realestate_mobile/api/notification/notification_api_client.dart';
import 'package:phison_realestate_mobile/repositories/core/item_repository.dart';
import 'package:phison_realestate_mobile/repositories/core/query_items_failure.dart';
import 'package:phison_realestate_mobile/repositories/notification_repository/notification_query_param.dart';

import '../../api/notification/models/notification.dart';

class NotificationRepository extends ItemRepository<NotificationQueryParam> {
  final NotificationApiClient _notificationApiClient;

  NotificationRepository({NotificationApiClient? client})
      : _notificationApiClient = client ?? NotificationApiClient.create();

  @override
  Future<PaginatedResponse<Notification>> getItems(
      NotificationQueryParam param) async {
    try {
      return await _notificationApiClient.getNotification(
          isRead: param.isRead, after: param.after);
    } on QueryNotificationsFailure catch (e) {
      throw QueryItemsFailure(message: e.message);
    }
  }

  Future<bool> hasUnreadNotifications() async {
    return await _notificationApiClient.hasUnreadNotifications();
  }
}
