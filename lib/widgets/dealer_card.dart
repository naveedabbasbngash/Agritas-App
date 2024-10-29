import 'package:flutter/material.dart';
import '../models/dealer.dart'; // Import your Dealer model

class DealerCard extends StatelessWidget {
  final Dealer dealer;

  const DealerCard({required this.dealer});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      color: Colors.white, // White background for the card
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circle Avatar for Dealer
            CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.business, color: Colors.white),
              radius: 30.0,
            ),
            SizedBox(width: 16.0),

            // Dealer Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dealer.dealerName,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Black text for dealer name
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.green), // Green phone icon
                      SizedBox(width: 8.0),
                      Text(
                        dealer.dealerContact,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black54, // Slightly dimmed text
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.green), // Green location icon
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          dealer.dealerAddress.isNotEmpty
                              ? dealer.dealerAddress
                              : 'Address not provided',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54, // Slightly dimmed text
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
