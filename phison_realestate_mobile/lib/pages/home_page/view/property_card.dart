import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/presentation/constants/app_assets_constant.dart';

class PropertyCard extends StatelessWidget {
  final bool isVertical;
  const PropertyCard({super.key, this.isVertical = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: isVertical ? const _VerticalLayout() : const _HorizontalLayout(),
    );
  }
}

class _VerticalLayout extends StatelessWidget {
  const _VerticalLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _PropertyImage(),
        SizedBox(
          height: 8.0,
        ),
        Expanded(
          child: _PropertyInfo(),
        ),
      ],
    );
  }
}

class _HorizontalLayout extends StatelessWidget {
  const _HorizontalLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: const [
          Flexible(
            flex: 2,
            child: _PropertyImage(),
          ),
          SizedBox(
            width: 8.0,
          ),
          Flexible(
            flex: 3,
            child: _PropertyInfo(),
          )
        ],
      ),
    );
  }
}

class _PropertyInfo extends StatelessWidget {
  const _PropertyInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'G+1 town Luxury Villa',
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
                'Addis Ababa, Bole Beshale',
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
                  '2',
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
                  '2',
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
  const _PropertyImage({
    Key? key,
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
          Image.asset(
            'assets/images/welcomeImage.png',
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: PhisonColors.orange.shade900,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Apartment',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
