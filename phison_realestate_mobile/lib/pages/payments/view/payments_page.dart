import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';

import '../../../shared/constants/app_assets_constant.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: 'Payments',
        hideLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            _PaymentItem(),
          ],
        ),
      ),
    );
  }
}

class _PaymentItem extends StatelessWidget {
  const _PaymentItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey.shade100,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Image.asset(
                  'assets/images/welcomeImage.png',
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Third Payment',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'G+1 town Luxury Apartment',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                    Text(
                      'Apartment',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: PhisonColors.orange.shade900,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Pending',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            '20% Payment upon your apartments structure completion'
            ' with three months payment time period '
            'from previous settlement',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '12/10/2022',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          text: 'Br',
                        ),
                        TextSpan(
                          text: ' 450,000.00',
                          style: TextStyle(
                            color: PhisonColors.purple.shade900,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text('(\$1000)'),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
