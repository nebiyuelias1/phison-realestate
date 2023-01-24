import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:phison_realestate_mobile/shared/constants/app_assets_constant.dart';

import '../../../api/property/models/property.dart';

class PropertyLocationMap extends StatelessWidget {
  final Property property;
  const PropertyLocationMap({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(
            _getLat(property.location),
            _getLong(
              property.location,
            ),
          ),
          zoom: 9.2,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 40,
                height: 40,
                point: LatLng(
                  _getLat(property.location),
                  _getLong(property.location),
                ),
                builder: (ctx) => Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: const Icon(
                    Icons.location_pin,
                    color: PhisonColors.purple,
                  ),
                ),
                key: ValueKey(key),
              )
            ],
          )
        ],
      ),
    );
  }

  double _getLat(String coordinate) {
    if (coordinate.isEmpty) {
      return 9.0063576;
    }

    return double.parse(coordinate.split(',')[0]);
  }

  double _getLong(String coordinate) {
    if (coordinate.isEmpty) {
      return 38.8741525;
    }

    return double.parse(coordinate.split(',')[1]);
  }
}
