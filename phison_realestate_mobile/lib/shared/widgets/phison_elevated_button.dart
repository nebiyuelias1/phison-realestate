import 'package:flutter/material.dart';

class PhisonElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool showLoader;
  final String label;

  const PhisonElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.showLoader = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showLoader)
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          Text(label),
        ],
      ),
    );
  }
}
