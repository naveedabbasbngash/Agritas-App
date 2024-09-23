import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import '../viewmodels/language_viewmodel.dart'; // Import LanguageViewModel

class CropDetailPage extends StatefulWidget {
  final String titleEn; // English title
  final String titleUr; // Urdu title
  final String descriptionEn; // English description
  final String descriptionUr; // Urdu description
  final String image;

  const CropDetailPage({
    required this.titleEn,
    required this.titleUr,
    required this.descriptionEn,
    required this.descriptionUr,
    required this.image,
  });

  @override
  _CropDetailPageState createState() => _CropDetailPageState();
}

class _CropDetailPageState extends State<CropDetailPage> {
  Color? dominantColor;

  @override
  void initState() {
    super.initState();
    _updatePalette();
  }

  Future<void> _updatePalette() async {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      CachedNetworkImageProvider('http://agritas.com.pk/' + widget.image),
    );

    setState(() {
      dominantColor = paletteGenerator.dominantColor?.color.withOpacity(0.7) ?? Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access the language view model to determine the selected language
    final languageModel = Provider.of<LanguageViewModel>(context);

    // Select title and description based on the selected language
    String title = languageModel.selectedLanguage == 'en'
        ? widget.titleEn
        : widget.titleUr;

    String description = languageModel.selectedLanguage == 'en'
        ? widget.descriptionEn
        : widget.descriptionUr;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: dominantColor ?? Colors.green, // Use dominant color or fallback to green
        title: const SizedBox.shrink(), // Keeps the AppBar clean without a title
        toolbarHeight: 60, // Adjust the AppBar height
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section with dynamic image
            Container(
              color: dominantColor ?? Colors.white, // Set dominant color as background
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: 'http://agritas.com.pk/' + widget.image, // Use dynamic image URL
                        height: 200,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Text Section with dynamic data based on language
            Container(
              color: Colors.lightBlue.shade50, // Background color of text section
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title, // Use dynamic title based on language
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    description, // Use dynamic description based on language
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      height: 1.5,
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
