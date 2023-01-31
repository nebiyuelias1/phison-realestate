import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/api/property/models/property.dart';

import '../constants/app_assets_constant.dart';

class PropertyTypeBadge extends StatelessWidget {
  final PropertyType propertyType;
  const PropertyTypeBadge({super.key, required this.propertyType});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PhisonColors.orange.shade900,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(4.0),
      child: Text(
        propertyType == PropertyType.villa ? 'Vila' : 'Apartment',
        style: Theme.of(context).textTheme.caption!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
