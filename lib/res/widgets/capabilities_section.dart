import 'package:flutter/material.dart';
import 'package:portfolio/res/assets/app_colors.dart';
import 'package:portfolio/res/assets/app_text_styles.dart';
import 'package:portfolio/res/constant/layout_helper.dart';
import 'package:portfolio/res/widgets/split_section.dart';

// Capabilities ka data (CV se). Chaho to portfolio_data.dart mein move kar do.
const String kCapabilitiesIntro =
    'I am always learning and adding new skills to my toolkit. These are '
    'the technologies and practices I use to build responsive, user '
    'friendly mobile and web apps.';

const List<String> kCapabilities = [
  'Flutter',
  'Dart',
  'Cross-Platform Apps',
  'Mobile UI',
  'Responsive Design',
  'API Integration',
  'OOP',
  'C++',
  'SQL',
  'Database Management',
  'Android Studio',
  'App Debugging',
  'App Testing',
  'Troubleshooting',
];

class CapabilitiesSection extends StatelessWidget {
  const CapabilitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SplitSection(
      title: 'MY CAPABILITIES',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kCapabilitiesIntro,
            style: appText(AppTextStyles.bodysRegular, color: AppColors.offWhite),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [for (final c in kCapabilities) _OutlinedChip(c)],
          ),
        ],
      ),
    );
  }
}

class _OutlinedChip extends StatelessWidget {
  final String label;
  const _OutlinedChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.lineColor),
      ),
      child: Text(
        label.toUpperCase(),
        style: appText(AppTextStyles.bodysRegular, color: AppColors.white),
      ),
    );
  }
}