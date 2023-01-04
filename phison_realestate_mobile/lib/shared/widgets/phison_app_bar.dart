import 'package:flutter/material.dart';

AppBar getAppBar({
  required BuildContext context,
  required String title,
  bool hideLeading = false,
}) {
  return AppBar(
    elevation: 0.0,
    automaticallyImplyLeading: false,
    leading: hideLeading
        ? null
        : const AppBarLeadingIcon(),
    title: Text(title),
  );
}

class AppBarLeadingIcon extends StatelessWidget {
  const AppBarLeadingIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
      );
  }
}
