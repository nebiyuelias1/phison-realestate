import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/pages/home_page/view/home_page_app_bar.dart';
import 'package:phison_realestate_mobile/pages/home_page/view/property_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getHomePageAppBar(context: context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: _FeaturedProperties(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 8.0),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Properties',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View All',
                    ),
                  )
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 8.0),
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.75,
              children: const [
                PropertyCard(
                  isVertical: true,
                ),
                PropertyCard(
                  isVertical: true,
                ),
                PropertyCard(
                  isVertical: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _FeaturedProperties extends StatelessWidget {
  const _FeaturedProperties();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Properties',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(
          height: 4.0,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                width: 310,
                margin: const EdgeInsets.only(right: 8.0),
                child: const PropertyCard(),
              ),
              const SizedBox(
                width: 310,
                child: PropertyCard(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
