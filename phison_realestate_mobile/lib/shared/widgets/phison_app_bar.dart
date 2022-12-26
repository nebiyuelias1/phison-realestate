import 'package:flutter/material.dart';

AppBar getAppBar({required BuildContext context, required String title}) {
  return AppBar(
    elevation: 0.0,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: IconButton(
          icon: const Icon(Icons.chevron_left),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
      ),
    ),
    title: Text(title),
  );
}
