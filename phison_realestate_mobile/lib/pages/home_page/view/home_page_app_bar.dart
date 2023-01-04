import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/pages/notifications/view/notifications_page.dart';
import 'package:phison_realestate_mobile/presentation/constants/app_assets_constant.dart';

AppBar getHomePageAppBar({required BuildContext context}) {
  return AppBar(
    toolbarHeight: 72.0,
    titleSpacing: 0,
    leading: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: -292,
          left: -175,
          child: Transform.rotate(
            angle: math.pi / 10,
            child: Container(
              width: 330,
              height: 330,
              decoration: BoxDecoration(
                color: PhisonColors.orange.shade100.withOpacity(0.8),
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
        ),
        Positioned(
          top: -290,
          left: -82,
          child: Transform.rotate(
            angle: math.pi / 7,
            child: Container(
              width: 250,
              height: 330,
              decoration: BoxDecoration(
                color: PhisonColors.purple.shade100.withOpacity(0.8),
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
        ),
        Image.asset(
          'assets/images/phison-logo.png',
          scale: 1.2,
        ),
      ],
    ),
    leadingWidth: 200,
    actions: [
      Row(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: PhisonColors.orange,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(64.0),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const NotificationsPage(),
                  ),
                );
              },
              icon: Stack(
                children: [
                  const Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: PhisonColors.orange.shade900,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    ],
  );
}
