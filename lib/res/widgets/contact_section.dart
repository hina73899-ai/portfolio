import 'package:flutter/material.dart';
import 'package:portfolio/res/assets/app_colors.dart';
import 'package:portfolio/res/assets/app_text_styles.dart';
import 'package:portfolio/res/constant/layout_helper.dart';
import 'package:portfolio/res/constant/portfolio_data.dart';

import 'package:portfolio/res/widgets/app_button.dart';
import 'package:portfolio/res/widgets/common_widgets.dart';
import 'package:portfolio/utils/url_helper.dart';


class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = isWideScreen(context);

    return ContentContainer(
      padding: EdgeInsets.symmetric(vertical: isWide ? 64 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle("LET'S WORK TOGETHER"),
          const SizedBox(height: 12),
          Text(
            'Have a project in mind or an opportunity to share? '
            'I would love to hear about it.',
            style: appText(AppTextStyles.bodyRegular, color: AppColors.offWhite),
          ),
          const SizedBox(height: 24),
          AppButton(
            text: 'SAY HELLO',
            height: 44,
            onPressed: () => openUrl('mailto:$kEmail'),
            icon: const Icon(Icons.north_east, size: 16, color: AppColors.black),
          ),
          const SizedBox(height: 40),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              children: [
                _ContactRow(
                  label: 'Email',
                  value: kEmail,
                  onTap: () => openUrl('mailto:$kEmail'),
                ),
                _ContactRow(
                  label: 'LinkedIn',
                  value: 'hina-bibi',
                  onTap: () => openUrl(kLinkedIn),
                ),
                _ContactRow(
                  label: 'GitHub',
                  value: 'hina73899-ai',
                  onTap: () => openUrl(kGitHub),
                ),
                const _ContactRow(label: 'Location', value: kLocation),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onTap;
  const _ContactRow({required this.label, required this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    final row = Container(
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: appText(
                  AppTextStyles.bodysRegular,
                  color: onTap != null
                      ? AppColors.primaryYellow
                      : AppColors.offWhite,
                ),
              ),
              if (onTap != null) ...[
                const SizedBox(width: 6),
                const Icon(
                  Icons.north_east,
                  size: 13,
                  color: AppColors.primaryYellow,
                ),
              ],
            ],
          ),
        ],
      ),
    );

    if (onTap == null) return row;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: row,
      ),
    );
  }
}
