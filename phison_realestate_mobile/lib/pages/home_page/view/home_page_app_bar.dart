import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/presentation/constants/app_assets_constant.dart';

AppBar getHomePageAppBar() {
  return AppBar(
    toolbarHeight: 72.0,
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
              onPressed: () {},
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
