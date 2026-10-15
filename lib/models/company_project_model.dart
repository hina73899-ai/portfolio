import 'package:portfolio/res/assets/app_assets.dart';

/// phones  = mobile app screens (lambay phone cards, Figma jaisa)
/// screens = web app screens (chaure desktop/browser cards, 2 columns)
enum MockupStyle { phones, screens }

class CompanyProjectModel {
  final String tag;
  final String title;
  final String description;
  final String role;
  final String platform;
  final String techStack;
  final List<String> images;
  final MockupStyle style;

  const CompanyProjectModel({
    required this.tag,
    required this.title,
    required this.description,
    required this.role,
    required this.platform,
    required this.techStack,
    required this.images,
    required this.style,
  });
}

const List<CompanyProjectModel> kCompanyProjects = [
  CompanyProjectModel(
    tag: 'Android App',
    title: 'Crave Dash Chef App',
    description:
        'An Android app built with Flutter while working with the company '
        'team. Customer data is saved when they log in, orders can be placed '
        'for home delivery or for the restaurant, and users can log out '
        'whenever they want. Restaurant staff can also see incoming orders '
        'and accept or reject them.',
    role: 'Flutter Developer',
    platform: 'Android',
    techStack: 'Flutter, Dart',
    // Order: splash, login (new password), main (orders)
    images: [
      AppAssets.piriSplash,
      AppAssets.piriLogin,
      AppAssets.piriMain,
    ],
    style: MockupStyle.phones,
  ),
  CompanyProjectModel(
    tag: 'Web App',
    title: 'Crave Dash Chef Web App',
    description:
        'The web version of the chef app, made for restaurant terminals. '
        'Users sign in, their data is saved, and they can place orders for '
        'home or for the restaurant. It includes staff check-in with a PIN '
        'and a point-of-sale screen with products, cart and billing, plus '
        'a simple log out.',
    role: 'Flutter Developer',
    platform: 'Web',
    techStack: 'Flutter, Dart',
    // Order: splash, sign in, staff check-in (otp/pin), main (POS)
    images: [
      AppAssets.webSplash,
      AppAssets.webSignin,
      AppAssets.webOtp,
      AppAssets.webOrder, // file: web_main.png
    ],
    style: MockupStyle.screens,
  ),
];