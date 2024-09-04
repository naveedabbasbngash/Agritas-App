import 'package:hive/hive.dart';

part '../providers/problems_providers.g.dart';

@HiveType(typeId: 3)
class ProblemCategory {
  @HiveField(0)
  final String pc_id;

  @HiveField(1)
  final String pc_name_en;

  @HiveField(2)
  final String pc_name_ur;

  @HiveField(3)
  final String cat_image_url;

  @HiveField(4)
  final List<Problem> problems;

  ProblemCategory({
    required this.pc_id,
    required this.pc_name_en,
    required this.pc_name_ur,
    required this.cat_image_url,
    required this.problems,
  });

  // Factory constructor to create a ProblemCategory from JSON
  factory ProblemCategory.fromJson(Map<String, dynamic> json) {
    var problemsFromJson = json['problems'] as List<dynamic>;
    List<Problem> problemList = problemsFromJson.map((problem) => Problem.fromJson(problem)).toList();

    return ProblemCategory(
      pc_id: json['pc_id'] as String,
      pc_name_en: json['pc_name_en'] as String,
      pc_name_ur: json['pc_name_ur'] as String,
      cat_image_url: json['cat_image_url'] as String,
      problems: problemList,
    );
  }
}

@HiveType(typeId: 4)
class Problem {
  @HiveField(0)
  final String problem_id;

  @HiveField(1)
  final String problem_name;

  @HiveField(2)
  final String problem_name_ur;

  @HiveField(3)
  final String description_en;

  @HiveField(4)
  final String description_ur;

  @HiveField(5)
  final String img_url;

  Problem({
    required this.problem_id,
    required this.problem_name,
    required this.problem_name_ur,
    required this.description_en,
    required this.description_ur,
    required this.img_url,
  });

  // Factory constructor to create a Problem from JSON
  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
      problem_id: json['problem_id'] as String,
      problem_name: json['problem_name'] as String,
      problem_name_ur: json['problem_name_ur'] as String,
      description_en: json['description_en'] as String,
      description_ur: json['description_ur'] as String,
      img_url: json['img_url'] as String,
    );
  }
}
