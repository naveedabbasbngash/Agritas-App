import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final IconData icon;

  CustomHeader({
    required this.title,
    this.onBackPressed,
    this.icon = Icons.arrow_back, // Default to arrow_back if not specified
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 10,
        right: 10,
        bottom: 5,
      ),
      color: Color(0xFF0fa065), // Green background color
      child: Directionality(
        textDirection: TextDirection.ltr, // Force LTR directionality
        child: Row(
          children: [
            IconButton(
              icon: Icon(icon, color: Colors.white),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
              iconSize: 24.0,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white, // White color for the text
                  fontSize: 20, // Font size
                  fontWeight: FontWeight.bold, // Bold text
                ),
                textAlign: TextAlign.center, // Center the title
              ),
            ),
            const SizedBox(
              width: 48, // Empty space for layout balance
            ),
          ],
        ),
      ),
    );
  }
}
