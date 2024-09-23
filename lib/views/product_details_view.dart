import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:provider/provider.dart'; // Import provider for language handling
import '../viewmodels/language_viewmodel.dart'; // Import LanguageViewModel for language switching

class ProductDetailsView extends StatelessWidget {
  final Product product;

  const ProductDetailsView({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageViewModel = Provider.of<LanguageViewModel>(context);
    final isUrdu = languageViewModel.selectedLanguage == 'ur'; // Check selected language

    return Scaffold(
      backgroundColor: Color(0xFFE1FDF9),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle PDF button action here
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.picture_as_pdf, color: Colors.white),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(), // For smoother scrolling on iOS
        slivers: [
          SliverAppBar(
            backgroundColor: Color(0xFF4CAF50),
            expandedHeight: 300.0,
            floating: false,
            pinned: true, // Pin the app bar to keep it visible
            snap: false,
            stretch: true,
            automaticallyImplyLeading: true, // Use the default back button
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var top = constraints.biggest.height;
                var isCollapsed = top <= 120; // Check if the app bar is collapsed

                return FlexibleSpaceBar(
                  title: isCollapsed
                      ? Text(
                    isUrdu ? product.urProductName : product.productName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )
                      : null, // Show title only when collapsed
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Centered image below the back button
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: 'https://www.agritas.com.pk/${product.imageUrl}',
                            width: 150.0, // Set the desired width of the image
                            height: 150.0, // Set the desired height of the image
                            fit: BoxFit.contain, // Ensure the image is fully visible
                          ),
                        ),
                      ),
                      // Title below the image with 10dp spacing
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: Center(
                          child: Text(
                            isUrdu ? product.urProductName : product.productName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Composition", "ترکیب", context, isUrdu),
                  _buildSectionContent(isUrdu ? product.compositionUr : product.composition),
                  _buildSectionTitle("Packing", "پیکنگ", context, isUrdu),
                  _buildSectionContent(product.packSize),
                  _buildSectionTitle("Mode of Action", "طریقہ کار", context, isUrdu),
                  _buildSectionContent(isUrdu ? product.modeOfActionUr : product.modeOfAction),
                  _buildSectionTitle("Application", "درخواست", context, isUrdu),
                  _buildSectionContent(isUrdu ? product.applicationUr : product.application),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Section title widget with language support and hardcoded Urdu titles
  Widget _buildSectionTitle(String titleEn, String titleUr, BuildContext context, bool isUrdu) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: Text(
          isUrdu ? titleUr : titleEn, // Switch between English and Urdu titles
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: isUrdu ? 'Nastaliq' : null, // Optional Urdu font if available
          ),
          textAlign: isUrdu ? TextAlign.right : TextAlign.left, // Adjust alignment for Urdu
        ),
      ),
    );
  }

  // Section content widget with language support
  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }
}
