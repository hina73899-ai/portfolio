import 'package:flutter/material.dart';
import 'package:portfolio/res/assets/app_colors.dart';
import 'package:portfolio/res/constant/layout_helper.dart';
import 'package:portfolio/res/widgets/about_section.dart';
import 'package:portfolio/res/widgets/capabilities_section.dart';
import 'package:portfolio/res/widgets/contact_section.dart';
import 'package:portfolio/res/widgets/experince_section.dart';
import 'package:portfolio/res/widgets/footer.dart';
import 'package:portfolio/res/widgets/hero_section.dart';
import 'package:portfolio/res/widgets/nav_bar.dart';
import 'package:portfolio/res/widgets/project_section.dart';

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
          NavBar(
            onWork: () => _scrollTo(_workKey),
            onAbout: () => _scrollTo(_aboutKey),
            onContact: () => _scrollTo(_contactKey),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  HeroSection(
                    minHeight: screenHeight - kNavHeight,
                    onContact: () => _scrollTo(_contactKey),
                  ),
                  Container(height: 1, color: AppColors.lineColor),
                  ProjectsSection(key: _workKey),
                  Container(height: 1, color: AppColors.lineColor),
                  AboutSection(key: _aboutKey),
                  Container(height: 1, color: AppColors.lineColor),
                  // ── Naye sections (Contact se pehle) ──
                  const CapabilitiesSection(),
                  Container(height: 1, color: AppColors.lineColor),
                  ExperienceSection(),
                  Container(height: 1, color: AppColors.lineColor),
                  ContactSection(key: _contactKey),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
