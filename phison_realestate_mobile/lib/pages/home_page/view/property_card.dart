import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/shared/constants/app_assets_constant.dart';
import 'package:phison_realestate_mobile/shared/widgets/property_type_badge.dart';

import '../../../api/property/models/property.dart';

class PropertyCard extends StatelessWidget {
  final bool isVertical;
  final Property property;
  const PropertyCard(
      {super.key, this.isVertical = false, required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: isVertical
          ? _VerticalLayout(property)
          : _HorizontalLayout(
              property: property,
            ),
    );
  }
}

class _VerticalLayout extends StatelessWidget {
  final Property property;

  const _VerticalLayout(this.property);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PropertyImage(
          property: property,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Expanded(
          child: _PropertyInfo(
            property: property,
          ),
        ),
      ],
    );
  }
}

class _HorizontalLayout extends StatelessWidget {
  final Property property;

  const _HorizontalLayout({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: _PropertyImage(
              property: property,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Flexible(
            flex: 3,
            child: _PropertyInfo(property: property),
          )
        ],
      ),
    );
  }
}

class _PropertyInfo extends StatelessWidget {
  final Property property;

  const _PropertyInfo({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          property.name,
          style: Theme.of(context).textTheme.headline6,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Icon(
              Icons.location_pin,
              size: 16.0,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Text(
                property.address,
                style: Theme.of(context).textTheme.caption,
              ),
            )
          ],
        ),
        Row(
          children: [
            Row(
              children: [
                Icon(
                  Icons.bed,
                  color: PhisonColors.purple.shade900,
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Text(
                  property.bedRoomCount.toString(),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(
              width: 24.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.square_foot,
                  color: PhisonColors.purple.shade900,
                ),
                Text(
                  property.size.toString(),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

class _PropertyImage extends StatelessWidget {
  final Property property;

  const _PropertyImage({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          if (property.propertyImage == null)
            Image.asset(
              'assets/images/welcomeImage.png',
              fit: BoxFit.cover,
            ),
          if (property.propertyImage != null)
            Image.network(
              property.propertyImage!,
              fit: BoxFit.cover,
            ),
          Positioned(
            bottom: 8,
            right: 8,
            child: PropertyTypeBadge(
              propertyType: property.propertyType,
            ),
          )
        ],
      ),
    );
  }
}
