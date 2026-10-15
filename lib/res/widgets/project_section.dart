import 'package:flutter/material.dart';
import 'package:portfolio/models/projct_model.dart';
import 'package:portfolio/res/assets/app_colors.dart';
import 'package:portfolio/res/assets/app_text_styles.dart';
import 'package:portfolio/res/constant/layout_helper.dart';
import 'package:portfolio/res/widgets/common_widgets.dart';
import 'package:portfolio/utils/url_helper.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = isWideScreen(context);

    return ContentContainer(
      padding: EdgeInsets.symmetric(vertical: isWide ? 64 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('FEATURED PROJECTS'),
          const SizedBox(height: 8),
          Text(
            'Here are some of the selected projects that showcase my '
            'passion for Flutter development.',
            style: appText(AppTextStyles.bodyRegular, color: AppColors.offWhite),
          ),
          SizedBox(height: isWide ? 56 : 32),
          for (int i = 0; i < kProjects.length; i++) ...[
            _ProjectCard(project: kProjects[i]),
            if (i != kProjects.length - 1) SizedBox(height: isWide ? 72 : 48),
          ],
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;
  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final preview = _ProjectPreview(project: project);
    final info = _ProjectInfo(project: project);

    if (isWideScreen(context)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 5, child: preview),
          const SizedBox(width: 48),
          Expanded(flex: 5, child: info),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [preview, const SizedBox(height: 24), info],
    );
  }
}

/// Box jis mein project ki saari screens Figma design jaisi dikhti hain
class _ProjectPreview extends StatelessWidget {
  final ProjectModel project;
  const _ProjectPreview({required this.project});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (project.images.isNotEmpty)
          _PhoneMockups(images: project.images)
        else
          Container(
            height: 360,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(
                Icons.phone_android,
                color: Color(0xFF5A5A5A),
                size: 48,
              ),
            ),
          ),
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.chipColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.lineColor),
            ),
            child: Text(
              project.tag,
              style: appText(AppTextStyles.bodysRegular, color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }
}

/// Figma design jaisa: light blue background, ek row mein kai phone screens,
/// halka sa upar-neeche (staggered) alignment, rounded corners + shadow.
class _PhoneMockups extends StatelessWidget {
  final List<String> images;
  const _PhoneMockups({required this.images});

  /// Screenshots ka aspect ratio (720 x 1600)
  static const double _ratio = 0.45;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFE3F1FD),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // Figma jaisi soft circles
          Positioned(
            top: -70,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: const BoxDecoration(
                color: Color(0x66FFFFFF),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -30,
            child: Container(
              width: 130,
              height: 130,
              decoration: const BoxDecoration(
                color: Color(0x55FFFFFF),
                shape: BoxShape.circle,
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, cons) {
              const hPad = 20.0;
              const gap = 12.0;
              const stagger = 22.0;

              final n = images.length;
              final innerWidth = cons.maxWidth - hPad * 2;
              final phoneW =
                  ((innerWidth - gap * (n - 1)) / n).clamp(40.0, 130.0);
              final phoneH = phoneW / _ratio;

              return Padding(
                // upar 52 chhoda hai taake tag chip phones par na aaye
                padding: const EdgeInsets.fromLTRB(hPad, 52, hPad, 28),
                child: SizedBox(
                  height: phoneH + stagger,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < n; i++)
                        Padding(
                          padding: EdgeInsets.only(
                            left: i == 0 ? 0 : gap,
                            top: i.isEven ? stagger : 0,
                          ),
                          child: _PhoneFrame(
                            path: images[i],
                            width: phoneW,
                            height: phoneH,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PhoneFrame extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  const _PhoneFrame({
    required this.path,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          path,
          fit: BoxFit.cover,
          cacheWidth: 360, // chhota decode = smooth scroll
          errorBuilder: (context, error, stackTrace) => Container(
            color: const Color(0xFFD0E4F7),
            child: const Icon(Icons.image_not_supported_outlined),
          ),
        ),
      ),
    );
  }
}

class _ProjectInfo extends StatelessWidget {
  final ProjectModel project;
  const _ProjectInfo({required this.project});

  @override
  Widget build(BuildContext context) {
    final hasLinks = project.liveUrl != null || project.githubUrl != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          project.title,
          style: appText(AppTextStyles.headingBold, color: AppColors.white),
        ),
        const SizedBox(height: 12),
        Text(
          project.description,
          style: appText(AppTextStyles.bodyRegular, color: AppColors.offWhite),
        ),
        const SizedBox(height: 28),
        Text(
          'PROJECT INFO',
          style: appText(AppTextStyles.bodies12Bold, color: AppColors.white),
        ),
        const SizedBox(height: 10),
        InfoRow(label: 'Role', value: project.role),
        InfoRow(label: 'Tech Stack', value: project.techStack),
        if (hasLinks) ...[
          const SizedBox(height: 24),
          Wrap(
            spacing: 24,
            runSpacing: 12,
            children: [
              if (project.liveUrl != null)
                LinkText(
                  label: 'LIVE DEMO',
                  icon: Icons.north_east,
                  onTap: () => openUrl(project.liveUrl!),
                ),
              if (project.githubUrl != null)
                LinkText(
                  label: 'SEE ON GITHUB',
                  icon: Icons.code,
                  onTap: () => openUrl(project.githubUrl!),
                ),
            ],
          ),
        ],
      ],
    );
  }
}