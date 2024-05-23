import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/screens/auth/login_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/screens/widgets/library_text_button.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:library_app/utils/consts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final TextEditingController _passwordController = TextEditingController(),
      _confirmPasswordController = TextEditingController(),
      _currentPasswordController = TextEditingController();
  final InputDecoration _inputDecoration = InputDecoration(
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
    filled: true,
    fillColor: white,
    contentPadding: const EdgeInsets.symmetric(
      vertical: 0.0,
      horizontal: 25,
    ),
    hintStyle: const TextStyle(
      color: Color(0xFFB0B0B0),
      fontSize: 18,
      fontWeight: FontWeight.w300,
    ),
    prefixIcon: Image.asset(
      "assets/images/user.png",
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
        builder: (context, navigationController, child) {
      return Column(
        children: [
          LibraryAppBar(
            title: "Changer le mot de passe",
            bgColor: const Color(0xFFF2F7FA),
            titleColor: mainColor,
            onBack: () {
              navigationController.navigateTo(navigationController.screens[4],
                  index: 4);
            },
            backColor: white,
            backBgColor: const Color(0xFF545454),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: grey.withAlpha(100),
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: _currentPasswordController,
                      decoration: _inputDecoration.copyWith(
                        hintText: "Mot de passe courant",
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: grey.withAlpha(100),
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: _inputDecoration.copyWith(
                        hintText: "Nouveau mot de passe",
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: grey.withAlpha(100),
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      decoration: _inputDecoration.copyWith(
                        hintText: "Mot de passe",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: LibraryTextButton(
                      onPressed: () async {
                        final responce = await http.post(
                            Uri.parse("$baseUrl/update_password"),
                            headers: {
                              "Authorization": "Bearer $token"
                            },
                            body: {
                              "old_password": _currentPasswordController.text,
                              "password": _passwordController.text,
                              "password_confirmation":
                                  _confirmPasswordController.text,
                            });
                        print(responce.statusCode);
                        print(responce.body);
                        if (responce.statusCode == 200) {
                          navigationController.navigateTo(
                              navigationController.screens[4],
                              index: 4);
                        }
                      },
                      label: "Changer le mot de passe",
                      labelSize: 18,
                      // width: 360,
                      height: 58,
                      radius: 29,
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xFF2475D3),
                          Color(0xFF3E97FF),
                        ], // Adjust gradient colors as needed
                      ),
                    ),
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
