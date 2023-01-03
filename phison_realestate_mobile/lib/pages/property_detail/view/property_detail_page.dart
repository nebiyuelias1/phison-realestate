import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/pages/property_detail/view/payment_info.dart';
import 'package:phison_realestate_mobile/pages/property_detail/view/property_location_map.dart';
import 'package:phison_realestate_mobile/presentation/constants/app_assets_constant.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';

import 'icon_row.dart';

class PropertyDetailPage extends StatelessWidget {
  const PropertyDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: 'Property Detail'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'G+1 town Luxuary Villa',
                style: Theme.of(context).textTheme.headline1,
              ),
              const Text(
                'The G+1 Luxury Villa is currently the best residence house'
                'type our company offers with spacious parking and garden.',
              ),
              Text(
                'Charcteristics & Status',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Text('Block Work'),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                height: 32,
                child: Row(
                  children: [
                    Container(
                      height: 32,
                      width: 100,
                      decoration: BoxDecoration(
                        color: PhisonColors.purple.shade900,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: const Center(
                        child: Text(
                          '42% Completed',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const IconRow(),
              Text(
                'Location',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  const Expanded(
                    child: Text('St. Cikoko Timur, Kec. Pancoran, Jakarta'
                        ' Selatan, Indonesia 12770'),
                  ),
                ],
              ),
              const PropertyLocationMap(),
              const PaymentInfo()
            ],
          ),
        ),
      ),
    );
  }
}
