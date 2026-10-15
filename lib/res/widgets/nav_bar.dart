import 'package:flutter/material.dart';
import 'package:portfolio/res/assets/app_colors.dart';
import 'package:portfolio/res/assets/app_text_styles.dart';
import 'package:portfolio/res/constant/layout_helper.dart';
import 'package:portfolio/res/constant/portfolio_data.dart';
import 'package:portfolio/res/widgets/common_widgets.dart';


class NavBar extends StatelessWidget {
  final VoidCallback onWork;
  final VoidCallback onAbout;
  final VoidCallback onContact;
  const NavBar({
    super.key,
    required this.onWork,
    required this.onAbout,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kNavHeight,
      color: AppColors.offBlack,
      child: ContentContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              kName.toUpperCase(),
              style: appText(
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
            style: appText(
              AppTextStyles.bodyRegular,
              color: _hover ? AppColors.primaryYellow : AppColors.offWhite,
            ),
          ),
        ),
      ),
    );
  }
}
