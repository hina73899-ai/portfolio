import 'package:flutter/material.dart';
import 'package:portfolio/res/assets/app_assets.dart';
import 'package:portfolio/res/assets/app_colors.dart';
import 'package:portfolio/views/portfolio_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hina | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: AppAssets.fonts, // Poppins
        scaffoldBackgroundColor: AppColors.offBlack,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryYellow,
          brightness: Brightness.dark,
        ),
      ),
      home: const PortfolioScreen(),
    );
  }
}