import 'package:flutter/material.dart';
import 'package:portfolio/res/assets/app_colors.dart';
import 'package:portfolio/res/assets/app_text_styles.dart';
import 'package:portfolio/res/constant/layout_helper.dart';

/// Content ko center + max width + side padding deta hai
class ContentContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const ContentContainer({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w < 600 ? 20 : 40) + padding,
          child: child,
        ),
      ),
    );
  }
}

/// Section ka bada title (FEATURED PROJECTS, ABOUT ME...)
class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: appText(
        AppTextStyles.headExtraBold,
        color: AppColors.white,
        size: isWideScreen(context) ? 44 : 30,
        height: 1.1,
      ),
    );
  }
}

/// Chhota yellow heading (EXPERIENCE, EDUCATION...)
class SubHeading extends StatelessWidget {
  final String text;
  const SubHeading(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: appText(
          AppTextStyles.tag12BoldUppercase,
          color: AppColors.primaryYellow,
        ),
      ),
    );
  }
}

/// Label left, value right, upar line wali row
class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.lineColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: appText(AppTextStyles.bodysRegular, color: AppColors.white),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: appText(
                AppTextStyles.bodysRegular,
                color: AppColors.offWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Yellow underlined link (LIVE DEMO, SEE ON GITHUB)
class LinkText extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const LinkText({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 2),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.primaryYellow, width: 1),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: appText(
                AppTextStyles.tag12BoldUppercase,
                color: AppColors.primaryYellow,
              ),
            ),
            const SizedBox(width: 6),
            Icon(icon, size: 13, color: AppColors.primaryYellow),
          ],
        ),
      ),
    );
  }
}

/// Yellow dot ke sath bullet text
class BulletText extends StatelessWidget {
  final String text;
  const BulletText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7, right: 10),
          child: Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: AppColors.primaryYellow,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: appText(AppTextStyles.bodyRegular, color: AppColors.offWhite),
          ),
        ),
      ],
    );
  }
}

/// Skill pill
class SkillChip extends StatelessWidget {
  final String label;
  const SkillChip(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.lineColor),
      ),
      child: Text(
        label,
        style: appText(AppTextStyles.bodysRegular, color: AppColors.white),
      ),
    );
  }
}