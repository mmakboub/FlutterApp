import 'package:flutter/material.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/screens/my_formations/certificates/certificate_request_screen.dart';
import 'package:library_app/screens/my_formations/certificates/formation_end_popup.dart';
import 'package:library_app/screens/my_formations/courses_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/screens/widgets/library_text_button.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ZoomScreen extends StatelessWidget {
  const ZoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
      builder: (context, navigationController, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LibraryAppBar(
              title: "Marketing Niveau moyen",
              bgColor: white,
              titleColor: const Color(0xFF414243),
              onBack: () {
                navigationController.navigateTo(navigationController.screens[1],
                    index: 1);
              },
              backColor: white,
              backBgColor: const Color(0xFF414243),
            ),
            const Spacer(),
            Image.asset(
              Assets.imagify('zoom'),
            ),
            const SizedBox(height: 20),
            LibraryTextButton(
              width: 240,
              label: "Lancement de live",
              radius: 25,
              labelSize: 22,
              height: 50,
              onPressed: () async {
                final Uri uri = Uri.parse("https://www.zoom.com");
                if (await canLaunchUrl(uri)) {
                  try {
                    await launchUrl(
                      uri,
                      mode: LaunchMode.externalNonBrowserApplication,
                    );
                  } catch (e) {
                    await launchUrl(
                      uri,
                      mode: LaunchMode.externalApplication,
                    );
                  }
                }
              },
              color: mainColor,
            ),
            const Spacer(),
            Container(
              height: 72,
              color: const Color(
                0xFFDEE4EB,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Objectif : 85%",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  LibraryTextButton(
                    width: 150,
                    label: "Continuer >",
                    onPressed: () {
                      navigationController.navigateTo(
                        CertificateRequestScreen(),
                        index: 1,
                      );
                      showDialog(
                        context: context,
                        builder: (context) => const FormationEndPopUp(),
                      );
                    },
                    color: const Color(0xFF35383D),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
