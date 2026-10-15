import 'package:flutter/material.dart';
import 'package:portfolio/models/company_project_model.dart';
import 'package:portfolio/res/assets/app_colors.dart';
import 'package:portfolio/res/assets/app_text_styles.dart';
import 'package:portfolio/res/constant/layout_helper.dart';
import 'package:portfolio/res/widgets/common_widgets.dart';

/// Box ka background (Crave Dash ke orange ke sath match karta halka peach)
const Color _boxColor = Color(0xFFFFEDE0);

class CompanyProjectsSection extends StatelessWidget {
  const CompanyProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = isWideScreen(context);

    return ContentContainer(
      padding: EdgeInsets.symmetric(vertical: isWide ? 64 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('COMPANY PROJECTS'),
          const SizedBox(height: 8),
          Text(
            'Projects I built together with my team at the company.',
            style: appText(AppTextStyles.bodyRegular, color: AppColors.offWhite),
          ),
          SizedBox(height: isWide ? 56 : 32),
          for (int i = 0; i < kCompanyProjects.length; i++) ...[
            _CompanyProjectCard(project: kCompanyProjects[i]),
            if (i != kCompanyProjects.length - 1)
              SizedBox(height: isWide ? 72 : 48),
          ],
        ],
      ),
    );
  }
}

class _CompanyProjectCard extends StatelessWidget {
  final CompanyProjectModel project;
  const _CompanyProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final preview = _Preview(project: project);
    final info = _Info(project: project);

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

// ───────────────────────── PREVIEW BOX ─────────────────────────

class _Preview extends StatelessWidget {
  final CompanyProjectModel project;
  const _Preview({required this.project});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        project.style == MockupStyle.phones
            ? _PhoneMockups(images: project.images)
            : _ScreenMockups(images: project.images),
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

/// Peach box + soft circles. Andar ka content child se aata hai.
class _MockupFrame extends StatelessWidget {
  final Widget child;
  const _MockupFrame({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _boxColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
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
          child,
        ],
      ),
    );
  }
}

/// Mobile screens: ek row mein phones, halka sa upar-neeche (staggered)
class _PhoneMockups extends StatelessWidget {
  final List<String> images;
  const _PhoneMockups({required this.images});

  static const double _ratio = 0.46;

  @override
  Widget build(BuildContext context) {
    return _MockupFrame(
      child: LayoutBuilder(
        builder: (context, cons) {
          const hPad = 20.0;
          const gap = 14.0;
          const stagger = 22.0;

          final n = images.length;
          final innerWidth = cons.maxWidth - hPad * 2;
          final phoneW = ((innerWidth - gap * (n - 1)) / n).clamp(50.0, 150.0);
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
                      child: _Card(
                        path: images[i],
                        width: phoneW,
                        height: phoneH,
                        radius: 14,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Web screens: 2 columns, dusre column ko thoda neeche rakha hai (collage)
class _ScreenMockups extends StatelessWidget {
  final List<String> images;
  const _ScreenMockups({required this.images});

  static const double _ratio = 1.9;

  @override
  Widget build(BuildContext context) {
    final left = <String>[];
    final right = <String>[];
    for (int i = 0; i < images.length; i++) {
      (i.isEven ? left : right).add(images[i]);
    }

    return _MockupFrame(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 52, 20, 28),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _ScreenColumn(paths: left, ratio: _ratio)),
            const SizedBox(width: 14),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 22),
                child: _ScreenColumn(paths: right, ratio: _ratio),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScreenColumn extends StatelessWidget {
  final List<String> paths;
  final double ratio;
  const _ScreenColumn({required this.paths, required this.ratio});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < paths.length; i++) ...[
          if (i != 0) const SizedBox(height: 14),
          AspectRatio(
            aspectRatio: ratio,
            child: _Card(path: paths[i], radius: 10, cacheWidth: 700),
          ),
        ],
      ],
    );
  }
}

/// Ek screenshot ka card: white border + shadow + rounded corners
class _Card extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final double radius;
  final int cacheWidth;
  const _Card({
    required this.path,
    this.width,
    this.height,
    required this.radius,
    this.cacheWidth = 400,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
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
        borderRadius: BorderRadius.circular(radius - 2),
        child: Image.asset(
          path,
          fit: BoxFit.cover,
          cacheWidth: cacheWidth, // chhota decode = smooth scroll
          errorBuilder: (context, error, stackTrace) => Container(
            color: const Color(0xFFFFD9BF),
            child: const Icon(Icons.image_not_supported_outlined),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── INFO ─────────────────────────

class _Info extends StatelessWidget {
  final CompanyProjectModel project;
  const _Info({required this.project});

  @override
  Widget build(BuildContext context) {
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
        InfoRow(label: 'Platform', value: project.platform),
        InfoRow(label: 'Tech Stack', value: project.techStack),
      ],
    );
  }
}