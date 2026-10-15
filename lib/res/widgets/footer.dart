import 'package:flutter/material.dart';
import 'package:portfolio/res/assets/app_colors.dart';
import 'package:portfolio/res/assets/app_text_styles.dart';
import 'package:portfolio/res/constant/layout_helper.dart';
import 'package:portfolio/res/constant/portfolio_data.dart';
import 'package:portfolio/res/widgets/common_widgets.dart';


class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 1, color: AppColors.lineColor),
        ContentContainer(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '© 2026 $kName. All rights reserved.',
              style: appText(AppTextStyles.bodysRegular, color: AppColors.offWhite),
            ),
          ),
        ),
      ],
    );
  }
}
