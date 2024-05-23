import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/screens/my_formations/certificates/formation_end_popup.dart';
import 'package:library_app/screens/notifications/notifications_screen.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';

class LibraryAppBar extends StatelessWidget {
  final String title;
  final Color? backColor;
  final Color? backBgColor;
  final Color? bgColor, titleColor;
  final bool showNotif;
  final Function()? onBack;
  const LibraryAppBar({
    super.key,
    required this.title,
    required this.bgColor,
    this.showNotif = true,
    this.titleColor,
    this.backColor = Colors.white,
    this.backBgColor = const Color(0xFF459FF2),
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
        builder: (context, navigationController, child) {
      return Container(
        height: 70,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: bgColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (onBack != null)
              InkWell(
                onTap: onBack,
                child: SvgPicture.asset(
                  Assets.iconify("arrow_back_bold"),
                  height: 35,
                  width: 35,
                  color: Colors.black,
                  fit: BoxFit.contain,
                ),
              ),
            const SizedBox(
              width: 15,
            ),
            if (onBack == null) const Center(),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 24,
                  color: titleColor ?? mainColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (showNotif)
              SizedBox(
                width: 40,
                child: InkWell(
                  onTap: () {
                    navigationController.navigateTo(
                      const NotificationsScreen(),
                    );
                  },
                  child: SvgPicture.asset(
                    Assets.iconify("notification_bold"),
                    height: 30,
                    width: 30,
                    color: Colors.black,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            if (!showNotif) const Center()
          ],
        ),
      );
    });
  }
}
