import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/crops_viewmodel.dart';
import '../viewmodels/language_viewmodel.dart';
import '../widgets/crops_card.dart';
import 'crop_details_view.dart';

class CropView extends StatefulWidget {
  @override
  _CropViewState createState() => _CropViewState();
}

class _CropViewState extends State<CropView> {
  bool _isLoading = true;  // Add a loading state

  @override
  void initState() {
    super.initState();

    // Show loading indicator while loading crops
    Future.microtask(() async {
      final viewModel = Provider.of<CropsViewModel>(context, listen: false);
      await viewModel.loadCrops(context);
      setState(() {
        _isLoading = false;  // Update loading state
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CropsViewModel>(context);
    final languageModel = Provider.of<LanguageViewModel>(context);

    // Show loading indicator if still loading
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Color(0xFFE1FDF9),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0), // Add left padding
          child: Text(
            languageModel.selectedLanguage == 'en' ? 'Crops' : 'فصلیں',
          ),
        ),
        backgroundColor: Color(0xFF0fa065),
        titleTextStyle: TextStyle(
          color: Colors.white, // Set the title color to white
          fontSize: 20, // Adjust the font size as needed
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back button color to white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 0.7,
          ),
          itemCount: viewModel.crops.length,
            itemBuilder: (context, index) {
              final crop = viewModel.crops[index];
              return CropCard(
                image: crop.imgUrl,
                title: languageModel.selectedLanguage == 'en'
                    ? crop.cropName
                    : crop.cropNameUr,
                description: languageModel.selectedLanguage == 'en'
                    ? crop.description
                    : crop.descriptionUr,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CropDetailPage(
                        titleEn: crop.cropName,      // Pass English title
                        titleUr: crop.cropNameUr,      // Pass Urdu title
                        descriptionEn: crop.description,  // Pass English description
                        descriptionUr: crop.descriptionUr,  // Pass Urdu description
                        image: crop.imgUrl,            // Pass the image URL
                      ),
                    ),
                  );
                },
              );
            }
        ),
      ),
    );
  }
}
