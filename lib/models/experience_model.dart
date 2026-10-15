class ExperienceModel {
  final String role;
  final String? company; // yellow color mein dikhega
  final String period;
  final String description;

  const ExperienceModel({
    required this.role,
    this.company,
    required this.period,
    required this.description,
  });
}

/// Naya experience add karna ho to bas list mein ek aur item daal do.
const List<ExperienceModel> kExperiences = [
  ExperienceModel(
    role: 'Mobile Application Developer',
    company: 'International SOS',
    period: '6 months',
    description:
        'Worked together with the company team on many projects, building '
        'both web apps and mobile apps using Flutter and Dart. Turned '
        'requirements into responsive, user-friendly interfaces, implemented '
        'features with clean object-oriented code, and helped debug and '
        'troubleshoot issues across the development lifecycle.',
  ),
];