import 'package:flutter/material.dart';
class AppTextStyles {
  AppTextStyles._();

  /// 24 / 32 / ExtraBold(800), ls 0
  static const TextStyle headExtraBold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    height: 32 / 24,
    letterSpacing: 0,
  );

  /// 20 / 28 / ExtraBold(800), ls 0
  static const TextStyle headingExtraBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    height: 28 / 20,
    letterSpacing: 0,
  );

  /// 20 / 28 / Bold(700), ls 0
  static const TextStyle headingBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 28 / 20,
    letterSpacing: 0,
  );

  /// 16 / 24 / ExtraBold(800), ls 0
  static const TextStyle headingsExtraBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    height: 24 / 16,
    letterSpacing: 0,
  );

  /// 16 / 24 / Bold(700), ls 0
  static const TextStyle headingsBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 24 / 16,
    letterSpacing: 0,
  );

  /// 14 / 20 / Regular(400), ls 0 — default body text
  static const TextStyle bodyRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    letterSpacing: 0,
  );

  /// 14 / 100% (tight) / Regular(400), ls 0
  static const TextStyle bodiesRegularTight = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0,
  );

  /// 14 / 20 / SemiBold(600), ls 0
  static const TextStyle bodySemiBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 20 / 14,
    letterSpacing: 0,
  );

  /// 12 / 16 / Regular(400), ls 0
  static const TextStyle bodysRegular = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    letterSpacing: 0,
  );

  /// 12 / 16 / Bold(700), ls 0
  static const TextStyle bodies12Bold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 16 / 12,
    letterSpacing: 0,
  );

  /// 14 / 100% (tight) / Bold(700), ls 0 — button labels
  /// (this already matches what AppButton was hardcoding)
  static const TextStyle buttonBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.0,
    letterSpacing: 0,
  );

  /// 12 / 16 / Bold(700), ls 0.3, UPPERCASE — status tags / badges / pills
  static const TextStyle tag12BoldUppercase = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 16 / 12,
    letterSpacing: 0.3,
  );
}