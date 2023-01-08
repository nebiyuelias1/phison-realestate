import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/pages/home_page/view/property_card.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';

class PropertiesPage extends StatelessWidget {
  const PropertiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: 'Our Properties',
        hideLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: PropertyCard(),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: PropertyCard(),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: PropertyCard(),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: PropertyCard(),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: PropertyCard(),
            ),
          ],
        ),
      ),
    );
  }
}
