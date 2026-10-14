import 'package:flutter/material.dart';
import 'package:portfolio/models/projct_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/res/assets/app_assets.dart';
import 'package:portfolio/res/assets/app_colors.dart';
import 'package:portfolio/res/assets/app_text_styles.dart';
import 'package:portfolio/res/widgets/app_button.dart';

// ───────────────────────── CONSTANTS ─────────────────────────

const double _maxContentWidth = 1200;
const double _wideBreakpoint = 900;
const double _navHeight = 72;

/// Personal info (CV se)
const String kName = 'Hina Bibi';
const String kEmail = 'hina73899@gmail.com';
const String kLinkedIn = 'https://www.linkedin.com/in/hina-bibi-821944395';
const String kGitHub = 'https://github.com/hina73899-ai';
const String kLocation = 'Lahore, Pakistan';

/// AppTextStyles + Poppins + optional color/size override
TextStyle _t(TextStyle base, {Color? color, double? size, double? height}) {
  return base.copyWith(
    fontFamily: AppAssets.fonts,
    color: color,
    fontSize: size,
    height: height,
  );
}

/// Link open karta hai (web par new tab mein)
/// Gmail/email ke liye: _open('mailto:hina73899@gmail.com')
Future<void> _open(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri, webOnlyWindowName: '_blank');
}

// ───────────────────────── DATA ─────────────────────────


// ───────────────────────── SCREEN ─────────────────────────

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();

  // Navbar se scroll karne ke liye section keys
  final GlobalKey _workKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.offBlack,
      body: Column(
        children: [
          // Fixed navbar
          _NavBar(
            onWork: () => _scrollTo(_workKey),
            onAbout: () => _scrollTo(_aboutKey),
            onContact: () => _scrollTo(_contactKey),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _HeroSection(
                    minHeight: screenHeight - _navHeight,
                    onContact: () => _scrollTo(_contactKey),
                  ),
                  Container(height: 1, color: AppColors.lineColor),
                  _ProjectsSection(key: _workKey),
                  Container(height: 1, color: AppColors.lineColor),
                  _AboutSection(key: _aboutKey),
                  Container(height: 1, color: AppColors.lineColor),
                  _ContactSection(key: _contactKey),
                  const _Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Content ko center + max width + side padding deta hai
class _Constrained extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const _Constrained({required this.child, this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxContentWidth),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: w < 600 ? 20 : 40) + padding,
          child: child,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= _wideBreakpoint;
    return Text(
      text,
      style: _t(
        AppTextStyles.headExtraBold,
        color: AppColors.white,
        size: isWide ? 44 : 30,
        height: 1.1,
      ),
    );
  }
}

// ───────────────────────── NAVBAR ─────────────────────────

class _NavBar extends StatelessWidget {
  final VoidCallback onWork;
  final VoidCallback onAbout;
  final VoidCallback onContact;
  const _NavBar({
    required this.onWork,
    required this.onAbout,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _navHeight,
      color: AppColors.offBlack,
      child: _Constrained(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              kName.toUpperCase(),
              style: _t(
                AppTextStyles.headingExtraBold,
                color: AppColors.offWhite,
                size: 20,
              ),
            ),
            Row(
              children: [
                _NavLink(label: 'Work', onTap: onWork),
                _NavLink(label: 'About', onTap: onAbout),
                _NavLink(label: 'Contact', onTap: onContact),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.only(left: 28),
          child: Text(
            widget.label,
            style: _t(
              AppTextStyles.bodyRegular,
              color: _hover ? AppColors.primaryYellow : AppColors.offWhite,
            ),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── HERO ─────────────────────────

class _HeroSection extends StatelessWidget {
  final double minHeight;
  final VoidCallback onContact;
  const _HeroSection({required this.minHeight, required this.onContact});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= _wideBreakpoint;

    final textBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'HI, I AM\n${kName.toUpperCase()}.',
          style: _t(
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
            'A Lahore based Mobile Application Developer passionate about '
            'building responsive, user friendly Flutter apps.',
            style: _t(AppTextStyles.bodyRegular, color: AppColors.offWhite),
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
            // LinkedIn
            _SocialCircle(
              onTap: () => _open(kLinkedIn),
              child: Text(
                'in',
                style: _t(
                  AppTextStyles.headingsExtraBold,
                  color: AppColors.primaryYellow,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // GitHub
            _SocialCircle(
              onTap: () => _open(kGitHub),
              child: const Icon(
                Icons.code,
                color: AppColors.primaryYellow,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            // Gmail
            _SocialCircle(
              onTap: () => _open('mailto:$kEmail'),
              child: const Icon(
                Icons.mail_outline,
                color: AppColors.primaryYellow,
                size: 20,
              ),
            ),
          ],
        ),
      ],
    );

    // Aapki picture: AppAssets.image = 'assets/images/image.jpeg'
    final photo = CircleAvatar(
      radius: 250,
      backgroundColor: Colors.black,
      child: Image.asset(
        AppAssets.image,
        fit: BoxFit.fitHeight,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(Icons.person, size: 64, color: AppColors.black),
        ),
      ),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight < 560 ? 560 : minHeight),
      child: _Constrained(
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

// ───────────────────────── PROJECTS ─────────────────────────

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= _wideBreakpoint;

    return _Constrained(
      padding: EdgeInsets.symmetric(vertical: isWide ? 64 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('FEATURED PROJECTS'),
          const SizedBox(height: 8),
          Text(
            'Here are some of the selected projects that showcase my '
            'passion for Flutter development.',
            style: _t(AppTextStyles.bodyRegular, color: AppColors.offWhite),
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
    final isWide = MediaQuery.of(context).size.width >= _wideBreakpoint;
    final preview = _ProjectPreview(project: project);
    final info = _ProjectInfo(project: project);

    if (isWide) {
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
              style: _t(AppTextStyles.bodysRegular, color: AppColors.white),
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
          style: _t(AppTextStyles.headingBold, color: AppColors.white),
        ),
        const SizedBox(height: 12),
        Text(
          project.description,
          style: _t(AppTextStyles.bodyRegular, color: AppColors.offWhite),
        ),
        const SizedBox(height: 28),
        Text(
          'PROJECT INFO',
          style: _t(AppTextStyles.bodies12Bold, color: AppColors.white),
        ),
        const SizedBox(height: 10),
        _InfoRow(label: 'Role', value: project.role),
        _InfoRow(label: 'Tech Stack', value: project.techStack),
        if (hasLinks) ...[
          const SizedBox(height: 24),
          Wrap(
            spacing: 24,
            runSpacing: 12,
            children: [
              if (project.liveUrl != null)
                _LinkText(
                  label: 'LIVE DEMO',
                  icon: Icons.north_east,
                  onTap: () => _open(project.liveUrl!),
                ),
              if (project.githubUrl != null)
                _LinkText(
                  label: 'SEE ON GITHUB',
                  icon: Icons.code,
                  onTap: () => _open(project.githubUrl!),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

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
            style: _t(AppTextStyles.bodysRegular, color: AppColors.white),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: _t(AppTextStyles.bodysRegular, color: AppColors.offWhite),
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkText extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _LinkText({
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
              style: _t(
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

// ───────────────────────── ABOUT ─────────────────────────

class _AboutSection extends StatelessWidget {
  const _AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= _wideBreakpoint;

    final leftColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SubHeading('EXPERIENCE'),
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
                'Mobile Application Developer',
                style: _t(AppTextStyles.headingsBold, color: AppColors.white),
              ),
              const SizedBox(height: 4),
              Text(
                'International SOS · Lahore, Pakistan · 6 months',
                style: _t(
                  AppTextStyles.bodysRegular,
                  color: AppColors.offWhite,
                ),
              ),
              const SizedBox(height: 14),
              for (final b in kExperienceBullets)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _BulletText(b),
                ),
            ],
          ),
        ),
        const SizedBox(height: 36),
        const _SubHeading('EDUCATION'),
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
                'Bachelor of Computer Science',
                style: _t(AppTextStyles.headingsBold, color: AppColors.white),
              ),
              const SizedBox(height: 4),
              Text(
                'University of the Punjab · Lahore, Pakistan\n'
                '2024 - 2028 (expected)',
                style: _t(
                  AppTextStyles.bodysRegular,
                  color: AppColors.offWhite,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final rightColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SubHeading('TECHNICAL SKILLS'),
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
                  style: _t(AppTextStyles.bodySemiBold, color: AppColors.white),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [for (final s in entry.value) _SkillChip(s)],
                ),
              ],
            ),
          ),
        const SizedBox(height: 22),
        const _SubHeading('STRENGTHS'),
        for (final s in kStrengths)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _BulletText(s),
          ),
      ],
    );

    return _Constrained(
      padding: EdgeInsets.symmetric(vertical: isWide ? 64 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('ABOUT ME'),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'Mobile Application Developer with 6 months of professional '
              'experience building cross-platform applications using Flutter '
              'and Dart at International SOS. I turn application requirements '
              'into responsive, user-friendly interfaces and implement '
              'features with object-oriented programming principles. '
              'Currently pursuing a Bachelor of Computer Science with a solid '
              'foundation in C++, SQL and database management.',
              style: _t(AppTextStyles.bodyRegular, color: AppColors.offWhite),
            ),
          ),
          SizedBox(height: isWide ? 56 : 36),
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: leftColumn),
                const SizedBox(width: 64),
                Expanded(child: rightColumn),
              ],
            )
          else ...[
            leftColumn,
            const SizedBox(height: 36),
            rightColumn,
          ],
        ],
      ),
    );
  }
}

class _SubHeading extends StatelessWidget {
  final String text;
  const _SubHeading(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: _t(
          AppTextStyles.tag12BoldUppercase,
          color: AppColors.primaryYellow,
        ),
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  final String text;
  const _BulletText(this.text);

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
            style: _t(AppTextStyles.bodyRegular, color: AppColors.offWhite),
          ),
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip(this.label);

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
        style: _t(AppTextStyles.bodysRegular, color: AppColors.white),
      ),
    );
  }
}

// ───────────────────────── CONTACT ─────────────────────────

class _ContactSection extends StatelessWidget {
  const _ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= _wideBreakpoint;

    return _Constrained(
      padding: EdgeInsets.symmetric(vertical: isWide ? 64 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle("LET'S WORK TOGETHER"),
          const SizedBox(height: 12),
          Text(
            'Have a project in mind or an opportunity to share? '
            'I would love to hear about it.',
            style: _t(AppTextStyles.bodyRegular, color: AppColors.offWhite),
          ),
          const SizedBox(height: 24),
          AppButton(
            text: 'SAY HELLO',
            height: 44,
            onPressed: () => _open('mailto:$kEmail'),
            icon: const Icon(
              Icons.north_east,
              size: 16,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 40),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              children: [
                _ContactRow(
                  label: 'Email',
                  value: kEmail,
                  onTap: () => _open('mailto:$kEmail'),
                ),
                _ContactRow(
                  label: 'LinkedIn',
                  value: 'hina-bibi',
                  onTap: () => _open(kLinkedIn),
                ),
                _ContactRow(
                  label: 'GitHub',
                  value: 'hina73899-ai',
                  onTap: () => _open(kGitHub),
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
            style: _t(AppTextStyles.bodysRegular, color: AppColors.white),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: _t(
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

// ───────────────────────── FOOTER ─────────────────────────

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 1, color: AppColors.lineColor),
        _Constrained(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '© 2026 $kName. All rights reserved.',
              style: _t(AppTextStyles.bodysRegular, color: AppColors.offWhite),
            ),
          ),
        ),
      ],
    );
  }
}
