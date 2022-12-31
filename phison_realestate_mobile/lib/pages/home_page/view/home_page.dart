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
        child: Column(
          children: const [
            _FeaturedProperties(),
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
            children: const [
              PropertyCard(),
              PropertyCard(),
            ],
          ),
        ),
      ],
    );
  }
}
