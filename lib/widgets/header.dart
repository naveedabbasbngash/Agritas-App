import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;

  CustomHeader({required this.title, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, left: 10, right: 10, bottom: 5),
      color: Color(0xFF0fa065), // Green background color
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
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
          SizedBox(width: 48), // Add an empty box of same width as the IconButton to balance the title
        ],
      ),
    );
  }
}
