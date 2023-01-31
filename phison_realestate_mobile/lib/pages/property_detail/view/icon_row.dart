import 'package:flutter/material.dart';

import '../../../api/property/models/property.dart';

class IconRow extends StatelessWidget {
  final Property property;
  const IconRow({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _Icon(
            icon: Icons.square_foot,
            text: '${property.size} m\u00B2',
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: _Icon(
            icon: Icons.bed,
            text: property.bedRoomCount.toString(),
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: _Icon(
            icon: Icons.shower,
            text: property.bathRoomCount.toString(),
          ),
        ),
      ],
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2.0,
        ),
        borderRadius: BorderRadiusDirectional.circular(
          8.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
