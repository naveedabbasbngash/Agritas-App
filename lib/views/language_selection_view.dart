// lib/views/language_selection_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/language_viewmodel.dart';
import 'product_list_view.dart';

class LanguageSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/language_bg.png', // Path to your background image
              fit: BoxFit.cover, // Ensure the image covers the entire screen
            ),
          ),

          // Content positioned based on requirements
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            // 20dp padding from left and right
            child: Column(
              children: [
                // Top logo positioned 50dp from the top
                Padding(
                  padding: const EdgeInsets.only(top: 150.0), // 50dp from top
                  child: Center(
                    child: Image.asset(
                      'assets/images/language_top_logo.png',
                      // Path to your logo asset
                      height: 120,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                // 30dp space between the logo and language box

                // Language selection box
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // Changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      // Increased space from the top border to the text

                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        // Add padding to align text with radio buttons
                        child: Text(
                          "Please, Select your language!!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      // Decrease the space between the text and the radio buttons
                      Consumer<LanguageViewModel>(
                        builder: (context, model, child) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0),
                              child: RadioListTile<String>(
                                activeColor: Colors.green,
                                contentPadding: EdgeInsets.zero,
                                title: Transform.translate(
                                  offset: Offset(-10, 0), // Move the title closer to the radio button by 5sp
                                  child: Text("English"),
                                ),
                                value: "en",
                                groupValue: model.selectedLanguage,
                                onChanged: (value) {
                                  model.selectLanguage(value!);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0),
                              child: RadioListTile<String>(
                                activeColor: Colors.green,
                                contentPadding: EdgeInsets.zero,
                                title: Transform.translate(
                                  offset: Offset(-10, 0), // Move the title closer to the radio button by 5sp
                                  child: Text("اردو"),
                                ),
                                value: "ur",
                                groupValue: model.selectedLanguage,
                                onChanged: (value) {
                                  model.selectLanguage(value!);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the ProductListView
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductListView()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0fa065), // Green color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 30.0),
                            child: Text(
                              "Next",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
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
}
