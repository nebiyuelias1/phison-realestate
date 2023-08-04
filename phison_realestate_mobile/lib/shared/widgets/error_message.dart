import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    Key? key,
    required this.error,
  }) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error),
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Text(S.of(context).goToLogin),
          )
        ],
      ),
    );
  }
}
