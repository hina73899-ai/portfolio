
import 'package:portfolio/res/assets/app_assets.dart';

class ProjectModel {
  final String tag;
  final String title;
  final String description;
  final String role;
  final String techStack;

  /// App screens ki images. Sab ek hi box mein phone mockups ki tarah
  /// (Figma design jaisi) dikhengi. Khali ho to placeholder dikhega.
  final List<String> images;
  final String? liveUrl; // null ho to button hide
  final String? githubUrl; // null ho to button hide

  const ProjectModel({
    required this.tag,
    required this.title,
    required this.description,
    required this.role,
    required this.techStack,
    this.images = const [],
    this.liveUrl,
    this.githubUrl,
  });
}

const List<ProjectModel> kProjects = [
  ProjectModel(
    tag: 'Mobile App',
    title: 'Shopping App',
    description:
        'A mobile shopping application built with Flutter and Dart. '
        'It integrates APIs to fetch and display product data in a clean, '
        'responsive and easy to browse interface.',
    role: 'Flutter Developer',
    techStack: 'Flutter, Dart, API',
    // Order: splash, login, new arrivals, jewelry
    images: [
      AppAssets.splash,
      AppAssets.login,
      AppAssets.all,
      AppAssets.jewlery,
    ],
    // githubUrl: 'https://github.com/hina73899-ai/your-repo',
  ),
  ProjectModel(
    tag: 'Mobile App',
    title: 'Weather Forecast App',
    description:
        'A mobile weather application built with Flutter and Dart. '
        'It integrates a weather API to show current conditions and '
        'forecasts with a simple, user friendly design.',
    role: 'Flutter Developer',
    techStack: 'Flutter, Dart, API',
    images: [
      AppAssets.weather,
      AppAssets.weatherImg,
      AppAssets.weatherData,
    ],
    // githubUrl: 'https://github.com/hina73899-ai/your-repo',
  ),
];

const List<String> kExperienceBullets = [
  'Developed cross-platform mobile applications using Flutter and Dart, '
      'translating requirements into responsive, user-friendly interfaces.',
  'Implemented features in Dart using object-oriented programming '
      'principles, resulting in clean and maintainable code.',
  'Identified and resolved application issues, supporting '
      'troubleshooting throughout the development lifecycle.',
  'Collaborated with senior developers on real-world mobile projects, '
      'applying industry-standard practices.',
];

const Map<String, List<String>> kSkills = {
  'Mobile Development': [
    'Flutter',
    'Dart',
    'Cross-Platform Apps',
    'Mobile UI',
    'Responsive Design',
  ],
  'Programming': ['Dart', 'C++', 'OOP'],
  'Databases': ['SQL', 'Database Management'],
  'Tools': ['Android Studio'],
  'Quality & Support': ['App Debugging', 'App Testing', 'Troubleshooting'],
};

const List<String> kStrengths = [
  'Problem solving: identifying and resolving application issues.',
  'Teamwork: collaborating with senior developers on real projects.',
  'Continuous learning: strengthening Flutter, Dart, C++ and databases.',
];