import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart'; // Import Provider for language support
import '../models/problems.dart';
import '../viewmodels/language_viewmodel.dart'; // Import LanguageViewModel for language support

class ProblemDetailsView extends StatelessWidget {
  final Problem problem;

  const ProblemDetailsView({
    required this.problem,
  });

  @override
  Widget build(BuildContext context) {
    // Access the language model to determine the selected language
    final languageModel = Provider.of<LanguageViewModel>(context);

    // Select problem name and description based on the selected language
    String problemTitle = languageModel.selectedLanguage == 'en'
        ? problem.problem_name
        : problem.problem_name_ur;

    String problemDescription = languageModel.selectedLanguage == 'en'
        ? problem.description_en
        : problem.description_ur;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          problemTitle, // Use dynamic title based on language
          style: TextStyle(color: Colors.white), // Set title text to white
        ),
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white), // Set back arrow color to white
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full-width image
            CachedNetworkImage(
              imageUrl: "http://agritas.com.pk/" + problem.img_url,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    problemTitle,  // Use dynamic title based on language
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    problemDescription,  // Use dynamic description based on language
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Add other relevant details here if needed
                  Text(
                    'More Information',  // Example of another section
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Additional information about this problem goes here.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
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
