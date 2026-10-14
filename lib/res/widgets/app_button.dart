import 'package:flutter/material.dart';
import 'package:portfolio/res/assets/app_colors.dart';
import 'package:portfolio/res/assets/app_text_styles.dart';

// Apne project ke mutabiq imports adjust kar lena
// import 'app_colors.dart';
// import 'app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? icon; // Optional icon
  final double? width; // Optional width
  final double height;
  final Color backgroundColor;
  final Color textColor;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.width,
    this.height = 48.0, // Standard button height, apne design ke mutabiq change kar sakti ho
    this.backgroundColor = AppColors.primaryYellow,
    this.textColor = AppColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Agar width null hogi to content ke hisab se adjust ho ga
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // Fully rounded pill shape
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppTextStyles.buttonBold.copyWith(color: textColor),
            ),
            if (icon != null) ...[const SizedBox(width: 8), icon!],
          ],
        ),
      ),
    );
  }
}
