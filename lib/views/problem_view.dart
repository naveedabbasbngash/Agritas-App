import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/language_viewmodel.dart';
import '../viewmodels/problem_viewmodel.dart';
import '../widgets/problem_card.dart';

class ProblemsScreen extends StatefulWidget {
  @override
  _ProblemsScreenState createState() => _ProblemsScreenState();
}

class _ProblemsScreenState extends State<ProblemsScreen> {
  bool _isLoading = true;  // Add a loading state

  @override
  void initState() {
    super.initState();

    // Show loading indicator while loading problems
    Future.microtask(() async {
      final viewModel = Provider.of<ProblemsViewModel>(context, listen: false);
      await viewModel.loadProblems(context);  // Load problems from API
      setState(() {
        _isLoading = false;  // Update loading state
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProblemsViewModel>(context);
    final languageModel = Provider.of<LanguageViewModel>(context);

    // Show loading indicator if still loading
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Color(0xFFE1FDF9),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Show the problem categories
    return Scaffold(
      appBar: AppBar(
        title: Text(
          languageModel.selectedLanguage == 'en' ? 'Problems' : 'مسائل',
        ),
        backgroundColor: Color(0xFF0fa065),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,  // 2 items per row
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 0.7,
          ),
          itemCount: viewModel.problemCategories.length,  // Use data from ViewModel
          itemBuilder: (context, index) {
            final category = viewModel.problemCategories[index];
            return ProblemCard(
              image: category.cat_image_url,
              title: languageModel.selectedLanguage == 'en'
                  ? category.pc_name_en
                  : category.pc_name_ur,
            );
          },
        ),
      ),
    );
  }
}
