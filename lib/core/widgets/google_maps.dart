import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  final latitude;
  final longitude;
  const MapScreen({this.latitude, this.longitude});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
          center: const LatLng(41, 29),
          zoom: 12.0,
          onTap: (TapPosition, latLng) {
            double latitude = latLng.latitude;
            double longitude = latLng.longitude;
            print('tıklanan nokta: ($latitude, $longitude)');
            Navigator.pop(
                context, {'latitude': latitude, 'longitude': longitude});
          }),
      children: [
        TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c']),
        MarkerLayer(markers: [
          Marker(
            width: 40.0,
            height: 40.0,
            point: const LatLng(41.1277837, 28.8125302),
            builder: (ctx) => Container(
              child: const FlutterLogo(),
            ),
          ),
          Marker(
            width: 40.0,
            height: 40.0,
            point: const LatLng(41.0973412, 29.0005743),
            builder: (ctx) => Container(
              child: const FlutterLogo(),
            ),
          ),
          Marker(
            width: 40.0,
            height: 40.0,
            point: const LatLng(40.9239525, 29.3231561),
            builder: (ctx) => Container(
              child: const FlutterLogo(),
            ),
          ),
        ])
      ],
    );
  }
}
