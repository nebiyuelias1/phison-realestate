import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/shared/constants/app_assets_constant.dart';

import '../../../api/property/models/property.dart';
import '../../../shared/utils/format_money.dart';

class PaymentInfo extends StatelessWidget {
  final Property property;
  const PaymentInfo({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: property.paymentInfos
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: _PaymentInfoItem(
                  paymentInformation: e,
                ),
              ),
            )
            .toList());
  }
}

class _PaymentInfoItem extends StatelessWidget {
  final PaymentInformation paymentInformation;
  const _PaymentInfoItem({required this.paymentInformation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadiusDirectional.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                paymentInformation.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                '\$ ${formatMoney(paymentInformation.amount)}',
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
          Text(
            paymentInformation.description,
          )
        ],
      ),
    );
  }
}
