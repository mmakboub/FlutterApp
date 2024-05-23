import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/screens/auth/login_screen.dart';
import 'package:library_app/screens/settings/change_password.dart';
import 'package:library_app/screens/settings/profile_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/screens/widgets/library_text_button.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:library_app/utils/consts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
        builder: (context, navigationController, child) {
      return Column(
        children: [
          LibraryAppBar(
            title: "Parametres",
            bgColor: const Color(0xFFF2F7FA),
            titleColor: mainColor,
            onBack: () {
              navigationController.navigateTo(navigationController.screens[0],
                  index: 0);
            },
            backColor: white,
            backBgColor: const Color(0xFF545454),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  notificationItem(
                    title: "Parametres de compte",
                    icon: "profile_bold",
                    onClick: () {
                      navigationController.navigateTo(
                        const ProfileScreen(),
                        index: 4,
                      );
                    },
                  ),
                  notificationItem(
                    title: "Changer le mot de passe",
                    icon: "profile_bold",
                    onClick: () {
                      navigationController.navigateTo(
                        ChangePasswordScreen(),
                        index: 4,
                      );
                    },
                  ),
                  notificationItem(
                    title: "Se deconnecter",
                    icon: "logout",
                    color: red,
                    onClick: () async {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 50.0, horizontal: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Vous etes sur vous voulez vous deconnecter?",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                LibraryTextButton(
                                  label: "Annuler",
                                  width: 200,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                LibraryTextButton(
                                    label: "Se deconnecter",
                                    width: 200,
                                    color: red,
                                    onPressed: () async {
                                      final responce = await http.post(
                                        Uri.parse("$baseUrl/logout"),
                                        headers: {
                                          "Authorization": "Bearer $token"
                                        },
                                      );
                                      if (responce.statusCode == 200) {
                                        while (Navigator.canPop(context)) {
                                          Navigator.pop(context);
                                        }
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class notificationItem extends StatelessWidget {
  final String title;
  final String icon;
  final Color color;
  final void Function()? onClick;
  const notificationItem({
    super.key,
    this.color = mainColor,
    required this.title,
    required this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
            border: const Border(
              bottom: BorderSide(
                width: 1,
                color: grey,
              ),
            ),
            color: white,
            borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            SvgPicture.asset(
              Assets.iconify(icon),
              height: 30,
              width: 30,
              color: color,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
