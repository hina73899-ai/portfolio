import 'package:flutter/material.dart';
import 'package:portfolio/models/experience_model.dart';
import 'package:portfolio/res/assets/app_colors.dart';
import 'package:portfolio/res/assets/app_text_styles.dart';
import 'package:portfolio/res/constant/layout_helper.dart';
import 'package:portfolio/res/widgets/split_section.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SplitSection(
      title: 'MY EXPERIENCE',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < kExperiences.length; i++) ...[
            _ExperienceItem(item: kExperiences[i]),
            if (i != kExperiences.length - 1) const SizedBox(height: 36),
          ],
        ],
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final ExperienceModel item;
  const _ExperienceItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                item.role,
                style: appText(AppTextStyles.bodySemiBold, color: AppColors.white),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              item.period,
              style: appText(AppTextStyles.bodysRegular, color: AppColors.offWhite),
            ),
          ],
        ),
        if (item.company != null) ...[
          const SizedBox(height: 4),
          Text(
            item.company!,
            style: appText(
              AppTextStyles.bodysRegular,
              color: AppColors.primaryYellow,
            ),
          ),
        ],
        const SizedBox(height: 12),
        Text(
          item.description,
          style: appText(AppTextStyles.bodysRegular, color: AppColors.offWhite),
        ),
      ],
    );
  }
}