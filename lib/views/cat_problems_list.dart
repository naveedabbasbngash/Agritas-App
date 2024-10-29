import 'package:flutter/material.dart';
import '../models/problems.dart';
import '../widgets/cat_problem_card.dart'; // Import the Problem model

class ProblemsListScreen extends StatelessWidget {
  final List<Problem> problems;  // List of problems passed from the category
  final String categoryTitle;    // The category title (based on the selected language)

  const ProblemsListScreen({
    required this.problems,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),  // Set the title to the category name
        backgroundColor: Color(0xFF0fa065),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: problems.length,
          itemBuilder: (context, index) {

            final problem = problems[index];
            return ProblemDetailCard(
              problem: problem,  // Pass each problem to the card
            );
          },
        ),
      ),
    );
  }
}
