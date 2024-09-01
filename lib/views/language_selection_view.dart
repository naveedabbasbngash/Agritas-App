import 'package:agritas_app/views/dashboard_view.dart';
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
          _buildBackgroundImage(),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/language_bg.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Consumer<LanguageViewModel>(
        builder: (context, model, child) {
          return Column(
            children: [
              _buildLogo(context),
              SizedBox(height: 50),
              _buildLanguageSelectionBox(context, model),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    // Get the height of the screen
    final double screenHeight = MediaQuery.of(context).size.height;

    // Calculate a responsive top padding, for example, 20% of the screen height
    final double topPadding = screenHeight * 0.2;

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Center(
        child: Image.asset(
          'assets/images/language_top_logo.png',
          height: 120,
        ),
      ),
    );
  }

  Widget _buildLanguageSelectionBox(
      BuildContext context, LanguageViewModel model) {
    final isUrdu = model.selectedLanguage == 'ur';

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLanguageSelectionTitle(isUrdu),
          SizedBox(height: 8),
          _buildLanguageOptions(model),
          SizedBox(height: 20),
          _buildNextButton(context, isUrdu),
        ],
      ),
    );
  }

  Widget _buildLanguageSelectionTitle(bool isUrdu) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        isUrdu
            ? "براہ کرم اپنی زبان منتخب کریں!!"
            : "Please, Select your language!!",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLanguageOptions(LanguageViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRadioOption(
          label: "English",
          value: "en",
          groupValue: model.selectedLanguage,
          onChanged: (value) => model.selectLanguage(value!),
        ),
        _buildRadioOption(
          label: "اردو",
          value: "ur",
          groupValue: model.selectedLanguage,
          onChanged: (value) => model.selectLanguage(value!),
        ),
      ],
    );
  }

  Widget _buildRadioOption({
    required String label,
    required String value,
    required String groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: RadioListTile<String>(
        activeColor: Colors.green,
        contentPadding: EdgeInsets.zero,
        title: Transform.translate(
          offset: Offset(-10, 0),
          child: Text(label),
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildNextButton(BuildContext context, bool isUrdu) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardView()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF0fa065),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 30.0),
          child: Text(
            isUrdu ? "اگلا" : "Next",
            style: TextStyle(fontSize: 18,color:Colors.white),
          ),
        ),
      ),
    );
  }
}
