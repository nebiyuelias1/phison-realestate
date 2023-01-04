import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:phison_realestate_mobile/presentation/constants/app_assets_constant.dart';

class PropertyLocationMap extends StatelessWidget {
  const PropertyLocationMap({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(51.509364, -0.128928),
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
                point: LatLng(51.509364, -0.128928),
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
}
