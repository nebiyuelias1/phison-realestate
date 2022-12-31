import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: 'Notifications'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            _NotificationItem(),
          ],
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem();

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
                  'Payment Completed',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Next payment is due tomorrow please pay on time.',
                  ),
                ),
                Text(
                  '10 min ago',
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
