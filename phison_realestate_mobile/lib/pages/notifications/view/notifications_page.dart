import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:phison_realestate_mobile/pages/core/bloc/items_bloc.dart';
import 'package:phison_realestate_mobile/repositories/notification_repository/notification_query_param.dart';
import 'package:phison_realestate_mobile/repositories/notification_repository/notification_repository.dart';
import 'package:phison_realestate_mobile/shared/widgets/error_message.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart' as intl;

import '../../../api/notification/models/notification.dart';
import '../../../generated/l10n.dart';

class NotificationsPage extends StatefulWidget {
  final NotificationRepository notificationRepository;

  const NotificationsPage({
    super.key,
    required this.notificationRepository,
  });

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final PagingController<String?, Notification> _pagingController =
      PagingController(firstPageKey: null);
  late final ItemsBloc<Notification, NotificationQueryParam> _notificationBloc;

  @override
  void initState() {
    super.initState();
    _notificationBloc = ItemsBloc<Notification, NotificationQueryParam>(
        widget.notificationRepository);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(String? pageKey) async {
    _notificationBloc.add(
      FetchNextPageRequested<NotificationQueryParam>(
        param: NotificationQueryParam(
          after: pageKey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: S.of(context).notifications),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) => _notificationBloc,
          child: BlocListener<ItemsBloc<Notification, NotificationQueryParam>,
              ItemsState<Notification>>(
            listener: (context, state) {
              if (state.status.isSubmissionSuccess) {
                final isLastPage = !state.hasNextPage;
                isLastPage
                    ? _pagingController
                        .appendLastPage(state.items.cast<Notification>())
                    : _pagingController.appendPage(
                        state.items.cast<Notification>(), state.endCursor);
              } else if (state.status.isSubmissionFailure) {
                _pagingController.error = state.error;
              }
            },
            child: PagedListView<String?, Notification>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Notification>(
                itemBuilder: (context, item, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _NotificationItem(item),
                ),
                newPageErrorIndicatorBuilder: (context) =>
                    ErrorMessage(error: _pagingController.error),
                firstPageErrorIndicatorBuilder: (context) =>
                    ErrorMessage(error: _pagingController.error),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final Notification notification;

  const _NotificationItem(this.notification);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/phison-logo-round.png',
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  _getNotificationHeader(
                      notification.notificationType, context),
                  style: Theme.of(context).textTheme.headline6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    _getNotificationDescription(notification, context),
                  ),
                ),
                Text(
                  timeago.format(notification.createdAt),
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String _getNotificationHeader(
      NotificationType notificationType, BuildContext context) {
    switch (notificationType) {
      case NotificationType.paymentDue:
        return S.of(context).paymentDue;
      default:
        return S.of(context).notification;
    }
  }

  String _getNotificationDescription(
      Notification notification, BuildContext context) {
    switch (notification.notificationType) {
      case NotificationType.paymentDue:
        final deadline = DateTime.parse(notification.data['deadline']);
        String formattedDate = intl.DateFormat.yMMMMd().format(deadline);
        final notificationText =
            S.of(context).youHaveAnUpcomingPaymentScheduledFor;
        return '$notificationText $formattedDate.';
      default:
        return S.of(context).youHaveANotification;
    }
  }
}
