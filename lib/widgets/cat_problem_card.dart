import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/problems.dart';
import '../viewmodels/language_viewmodel.dart';
import '../views/problem_detail_view.dart';

class ProblemDetailCard extends StatelessWidget {
  final Problem problem;

  const ProblemDetailCard({
    required this.problem,
  });

  @override
  Widget build(BuildContext context) {
    final languageModel = Provider.of<LanguageViewModel>(context);
    String problemTitle = languageModel.selectedLanguage == 'en'
        ? problem.problem_name
        : problem.problem_name_ur;
    String problemDescription = languageModel.selectedLanguage == 'en'
        ? problem.description_en
        : problem.description_ur;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProblemDetailsView(problem: problem),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: CachedNetworkImage(
                imageUrl: "http://agritas.com.pk/" + problem.img_url,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withOpacity(0.7),
                      Colors.green.withOpacity(0.7),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          problemTitle,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          problemDescription,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.chevron_right),
                      color: Colors.black54,
                      onPressed: () {
                        // You can also keep this to handle navigation if the icon is clicked
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProblemDetailsView(problem: problem),
                          ),
                        );
                      },
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
