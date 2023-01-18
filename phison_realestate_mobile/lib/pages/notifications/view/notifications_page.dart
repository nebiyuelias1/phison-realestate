import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:phison_realestate_mobile/api/notification/notification_api_client.dart';
import 'package:phison_realestate_mobile/pages/core/bloc/items_bloc.dart';
import 'package:phison_realestate_mobile/repositories/notification_repository/notification_query_param.dart';
import 'package:phison_realestate_mobile/repositories/notification_repository/notification_repository.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart' as intl;

import '../../../api/notification/models/notification.dart';
import '../../app/bloc/bloc/app_bloc.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

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
    final token = context.read<AppBloc>().state.authToken;
    _notificationBloc =
        ItemsBloc<Notification, NotificationQueryParam>(NotificationRepository(
      client: NotificationApiClient.create(authToken: token),
    ));
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
      appBar: getAppBar(context: context, title: 'Notifications'),
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
                    _Error(pagingController: _pagingController),
                firstPageErrorIndicatorBuilder: (context) =>
                    _Error(pagingController: _pagingController),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({
    Key? key,
    required PagingController<String?, Notification> pagingController,
  })  : _pagingController = pagingController,
        super(key: key);

  final PagingController<String?, Notification> _pagingController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_pagingController.error),
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
                  _getNotificationHeader(notification.notificationType),
                  style: Theme.of(context).textTheme.headline6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    _getNotificationDescription(notification),
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

  String _getNotificationHeader(NotificationType notificationType) {
    switch (notificationType) {
      case NotificationType.paymentDue:
        return 'Payment Due';
      default:
        return 'Notification';
    }
  }

  String _getNotificationDescription(Notification notification) {
    switch (notification.notificationType) {
      case NotificationType.paymentDue:
        final deadline = DateTime.parse(notification.data['deadline']);
        String formattedDate = intl.DateFormat.yMMMMd().format(deadline);
        return 'You have an upcoming payment scheduled for $formattedDate.';
      default:
        return 'You have a notification.';
    }
  }
}
