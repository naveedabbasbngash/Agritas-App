import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String providerName;

  MapScreen({
    required this.latitude,
    required this.longitude,
    required this.providerName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location of $providerName'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: MarkerId(providerName),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: providerName),
          ),
        },
      ),
    );
  }
}