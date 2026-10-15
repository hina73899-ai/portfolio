import 'package:flutter/material.dart';
import 'package:portfolio/res/assets/app_colors.dart';
import 'package:portfolio/res/assets/app_text_styles.dart';
import 'package:portfolio/res/constant/layout_helper.dart';
import 'package:portfolio/res/constant/portfolio_data.dart';
import 'package:portfolio/res/widgets/common_widgets.dart';


class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = isWideScreen(context);

    return ContentContainer(
      padding: EdgeInsets.symmetric(vertical: isWide ? 64 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('ABOUT ME'),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              kAboutSummary,
              style: appText(AppTextStyles.bodyRegular, color: AppColors.offWhite),
            ),
          ),
          SizedBox(height: isWide ? 56 : 36),
          if (isWide)
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _ExperienceAndEducation()),
                SizedBox(width: 64),
                Expanded(child: _SkillsAndStrengths()),
              ],
            )
          else ...const [
            _ExperienceAndEducation(),
            SizedBox(height: 36),
            _SkillsAndStrengths(),
          ],
        ],
      ),
    );
  }
}

class _ExperienceAndEducation extends StatelessWidget {
  const _ExperienceAndEducation();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SubHeading('EXPERIENCE'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 16),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.lineColor)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kJobTitle,
                style: appText(AppTextStyles.headingsBold, color: AppColors.white),
              ),
              const SizedBox(height: 4),
              Text(
                kJobMeta,
                style: appText(
                  AppTextStyles.bodysRegular,
                  color: AppColors.offWhite,
                ),
              ),
              const SizedBox(height: 14),
              for (final b in kExperienceBullets)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: BulletText(b),
                ),
            ],
          ),
        ),
        const SizedBox(height: 36),
        const SubHeading('EDUCATION'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 16),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.lineColor)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kDegree,
                style: appText(AppTextStyles.headingsBold, color: AppColors.white),
              ),
              const SizedBox(height: 4),
              Text(
                kDegreeMeta,
                style: appText(
                  AppTextStyles.bodysRegular,
                  color: AppColors.offWhite,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkillsAndStrengths extends StatelessWidget {
  const _SkillsAndStrengths();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SubHeading('TECHNICAL SKILLS'),
        for (final entry in kSkills.entries)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.lineColor)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: appText(
                    AppTextStyles.bodySemiBold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [for (final s in entry.value) SkillChip(s)],
                ),
              ],
            ),
          ),
        const SizedBox(height: 22),
        const SubHeading('STRENGTHS'),
        for (final s in kStrengths)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: BulletText(s),
          ),
      ],
    );
  }
}
