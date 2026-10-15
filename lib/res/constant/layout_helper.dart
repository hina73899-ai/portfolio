import 'package:flutter/material.dart';
import 'package:portfolio/res/assets/app_assets.dart';

const double kMaxContentWidth = 1200;
const double kWideBreakpoint = 900;
const double kNavHeight = 72;

/// Screen wide (desktop/laptop) hai ya nahi
bool isWideScreen(BuildContext context) =>
    MediaQuery.of(context).size.width >= kWideBreakpoint;

/// AppTextStyles + Poppins + optional color/size/height override
TextStyle appText(
  TextStyle base, {
  Color? color,
  double? size,
  double? height,
}) {
  return base.copyWith(
    fontFamily: AppAssets.fonts,
    color: color,
    fontSize: size,
    height: height,
  );
}
