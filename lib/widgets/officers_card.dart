import 'package:flutter/material.dart';
import '../models/servics_providers.dart';
import '../views/mapview.dart';

class OfficerCard extends StatelessWidget {
  final Officer officer;

  OfficerCard({required this.officer});

  String getTrimmedText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength) + '...';
  }

  @override
  Widget build(BuildContext context) {
    // Check if `latLong` is not empty and contains a valid format (latitude,longitude)
    double latitude = 0.0;
    double longitude = 0.0;
    if (officer.latLong.isNotEmpty && officer.latLong.contains(',')) {
      final latLong = officer.latLong.split(',');
      if (latLong.length == 2) {
        latitude = double.tryParse(latLong[0]) ?? 0.0;
        longitude = double.tryParse(latLong[1]) ?? 0.0;
      }
    }

    return GestureDetector(
      onTap: () {
        // Navigate to the MapScreen with the officer's coordinates
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapScreen(
              latitude: latitude,
              longitude: longitude,
              providerName: officer.providerName,
            ),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main card container
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 40),

                // Text section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        officer.providerName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        getTrimmedText(officer.serviceDescription, 30),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                // Trailing arrow icon
                Icon(
                  Icons.arrow_forward,
                  color: Colors.green,
                ),
              ],
            ),
          ),

          // Location marker icon positioned above the card
          Positioned(
            left: -5,
            top: -10,
            child: Icon(
              Icons.location_on,
              color: Colors.green,
              size: 80,
            ),
          ),
        ],
      ),
    );
  }
}