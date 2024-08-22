import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background colors
          Column(

            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: const Color(0xFF0fa065), // Green portion (40%)
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: const Color(0xFFE1FDF9), // Light blue portion (60%)
                ),
              ),
            ],
          ),
          // Content
          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:10),

                // Date, City, Weather, and Temperature
                Padding(

                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "31, July, 2024",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              "Peshawar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Clear & Sunny Day",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "31°",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 64.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Real feel 45°",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Spacing between "Clear & Sunny Day" and the white box
                SizedBox(height: 20),
                // Adjust this value to get the desired spacing
                // Rounded shape with logo, slider, and boxes
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // App Logo
                      Container(
                        height: 80,
                        child: Image.asset(
                            'assets/images/language_top_logo.png'), // Update with your logo asset path
                      ),
                      SizedBox(height: 20), // 10px space after the logo
                      // Animated Slider
                      Container(
                        height: 120.0,
                        color: Colors.grey[300], // Placeholder for slider
                        child: Center(
                          child: Text("Slider Placeholder"),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height: 20),
                        ],
                      ), // 10px space after the slider
                      // ListView of boxes

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo// Grid of Buttons
                          Wrap(
                            spacing: 20, // Horizontal spacing between children
                            runSpacing: 20, // Vertical spacing between rows
                            children: [
                              _buildDashboardButton('Products', 'assets/images/plantation.png', Colors.orange),
                              _buildDashboardButton('Crops', 'assets/images/plantation.png', Colors.green),
                              _buildDashboardButton('Problems', 'assets/images/plantation.png', Colors.purple),
                              _buildDashboardButton('Dealers', 'assets/images/plantation.png', Colors.yellow),
                              _buildDashboardButton('Contact Us', 'assets/images/plantation.png', Colors.blue),
                              _buildDashboardButton('Services', 'assets/images/plantation.png', Colors.orangeAccent),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardButton(String title, String iconPath, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 120, // Increased height of the color box
          width: 100,  // Optional: Set a fixed width if needed
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              height: 50,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
