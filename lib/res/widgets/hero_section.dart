import 'package:flutter/material.dart';
import 'package:portfolio/res/assets/app_assets.dart';
import 'package:portfolio/res/assets/app_colors.dart';
import 'package:portfolio/res/assets/app_text_styles.dart';
import 'package:portfolio/res/constant/layout_helper.dart';
import 'package:portfolio/res/constant/portfolio_data.dart';
import 'package:portfolio/res/widgets/app_button.dart';
import 'package:portfolio/res/widgets/common_widgets.dart';
import 'package:portfolio/utils/url_helper.dart';

class HeroSection extends StatelessWidget {
  final double minHeight;
  final VoidCallback onContact;
  const HeroSection({
    super.key,
    required this.minHeight,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = isWideScreen(context);

    final textBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'HI, I AM\n${kName.toUpperCase()}.',
          style: appText(
            AppTextStyles.headExtraBold,
            color: AppColors.white,
            size: isWide ? 60 : 40,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Text(
            kHeroBio,
            style: appText(AppTextStyles.bodyRegular, color: AppColors.offWhite),
          ),
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              text: 'CONTACT ME',
              height: 44,
              onPressed: onContact,
              icon: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 12),
            _SocialCircle(
              onTap: () => openUrl(kLinkedIn),
              child: Text(
                'in',
                style: appText(
                  AppTextStyles.headingsExtraBold,
                  color: AppColors.primaryYellow,
                ),
              ),
            ),
            const SizedBox(width: 12),
            _SocialCircle(
              onTap: () => openUrl(kGitHub),
              child: const Icon(
                Icons.code,
                color: AppColors.primaryYellow,
                size: 20,
              ),
            ),
          ],
        ),
      ],
    );

    final photo = ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        color: AppColors.offWhite,
        child: AspectRatio(
          aspectRatio: 0.86,
          child: Image.asset(AppAssets.image, fit: BoxFit.cover),
        ),
      ),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight < 560 ? 560 : minHeight),
      child: ContentContainer(
        padding: EdgeInsets.symmetric(vertical: isWide ? 40 : 28),
        child: isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: textBlock),
                  const SizedBox(width: 40),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 440),
                        child: photo,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [photo, const SizedBox(height: 32), textBlock],
              ),
      ),
    );
  }
}

class _SocialCircle extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const _SocialCircle({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.cardColor,
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}
