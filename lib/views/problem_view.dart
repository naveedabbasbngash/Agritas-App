import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/language_viewmodel.dart';
import '../viewmodels/problem_viewmodel.dart';
import '../widgets/problem_card.dart';
import 'cat_problems_list.dart';

class ProblemsScreen extends StatefulWidget {
  @override
  _ProblemsScreenState createState() => _ProblemsScreenState();
}

class _ProblemsScreenState extends State<ProblemsScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Load problems asynchronously
    Future.microtask(() async {
      final viewModel = Provider.of<ProblemsViewModel>(context, listen: false);
      await viewModel.loadProblems(context);
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProblemsViewModel>(context);
    final languageModel = Provider.of<LanguageViewModel>(context);

    if (_isLoading) {
      return Scaffold(
        backgroundColor: Color(0xFFE1FDF9),
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 0.7,
          ),
          itemCount: viewModel.problemCategories.length,
          itemBuilder: (context, index) {
            final category = viewModel.problemCategories[index];

            return ProblemCard(
              image: category.cat_image_url,
              title: languageModel.selectedLanguage == 'en'
                  ? category.pc_name_en
                  : category.pc_name_ur,
              onTap: () {
                if (category.problems.isNotEmpty) {
                  // Navigate to ProblemsListScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProblemsListScreen(
                        problems: category.problems,
                        categoryTitle: languageModel.selectedLanguage == 'en'
                            ? category.pc_name_en
                            : category.pc_name_ur,
                      ),
                    ),
                  );
                } else {
                  // Show a SnackBar if there are no problems available
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('No problems available for this category')),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
