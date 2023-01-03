import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/presentation/constants/app_assets_constant.dart';

class PaymentInfo extends StatelessWidget {
  const PaymentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _PaymentInfoItem(),
      ],
    );
  }
}

class _PaymentInfoItem extends StatelessWidget {
  const _PaymentInfoItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadiusDirectional.circular(8.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '1st Payment',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                '15%',
                style: TextStyle(
                  color: PhisonColors.purple.shade900,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Text(
            'The G+1 Luxury Villa is currently the best residence'
            ' house type our company offers with spacious parking'
            ' and garden.',
          )
        ],
      ),
    );
  }
}
