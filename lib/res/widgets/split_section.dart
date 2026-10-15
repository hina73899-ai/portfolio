import 'package:flutter/material.dart';
import 'package:portfolio/res/constant/layout_helper.dart';
import 'package:portfolio/res/widgets/common_widgets.dart';

/// Left side title, right side content (Capabilities / Experience jaisa layout).
/// Chhoti screen par title upar aur content neeche aa jata hai.
class SplitSection extends StatelessWidget {
  final String title;
  final Widget child;
  const SplitSection({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final isWide = isWideScreen(context);

    return ContentContainer(
      padding: EdgeInsets.symmetric(vertical: isWide ? 64 : 40),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4, child: SectionTitle(title)),
                const SizedBox(width: 40),
                Expanded(flex: 6, child: child),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(title),
                const SizedBox(height: 24),
                child,
              ],
            ),
    );
  }
}