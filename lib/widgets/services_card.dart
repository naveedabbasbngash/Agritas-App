import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/services.dart';

class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: Colors.white,
        elevation: 6,
        child: Container(
          height: 120,  // Adjust the height as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            image: DecorationImage(
              image: AssetImage('assets/images/services_card_bg.png'), // Use the image from assets
              fit: BoxFit.cover,  // Fit the image to cover the entire card
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),  // Dark overlay to make the text more readable
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                _buildServiceImage(),  // Display the service image
                SizedBox(width: 16.0),
                _buildServiceDetails(context),  // Display the service name and description
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build the service image using CachedNetworkImage for efficient image loading
// Build the service image using CachedNetworkImage for efficient image loading
// Build the service image using CachedNetworkImage for efficient image loading
  Widget _buildServiceImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: CachedNetworkImage(
        imageUrl: service.typeImageUrl,
        width: 70,  // Set fixed width
        height: 70,  // Set fixed height
        fit: BoxFit.contain,  // Ensure the entire image is shown without clipping
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  // Build the service details (name and description)
  Widget _buildServiceDetails(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            service.typeName,  // Service Name
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,  // Change text color to white for better visibility
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            service.typeDescription.isNotEmpty
                ? service.typeDescription
                : 'No description available',  // Service description or fallback text
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white70,  // Use a lighter white shade for the description
            ),
          ),
        ],
      ),
    );
  }
}
