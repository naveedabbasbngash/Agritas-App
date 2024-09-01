import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/crops_viewmodel.dart';
import '../viewmodels/language_viewmodel.dart';
import '../widgets/crops_card.dart';

class CropView extends StatefulWidget {
  @override
  _CropViewState createState() => _CropViewState();
}

class _CropViewState extends State<CropView> {
  @override
  void initState() {
    super.initState();

    // Ensure loadCrops is called on initialization
    Future.microtask(() async {
      final viewModel = Provider.of<CropsViewModel>(context, listen: false);
      await viewModel.loadCrops(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CropsViewModel>(context);
    final languageModel = Provider.of<LanguageViewModel>(context);

    if (viewModel.crops.isEmpty) {
      return Scaffold(
        backgroundColor: Color(0xFFE1FDF9),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(languageModel.selectedLanguage == 'en' ? 'Crops' : 'فصلیں'),
        backgroundColor: Color(0xFF0fa065),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
        GridView.builder(
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
              image: crop.imgUrl, // This should be the relative URL part
              title: languageModel.selectedLanguage == 'en'
                  ? crop.cropName
                  : crop.cropNameUr,
              description: languageModel.selectedLanguage == 'en'
                  ? crop.description
                  : crop.descriptionUr,
            );
          },
        ),
      ),
    );
  }
}
