// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:library_app/controllers/login_controller.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/screens/formations/formations_screen.dart';
import 'package:library_app/screens/formations_out/formations_screen.dart';

import 'package:library_app/screens/library_nav_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/screens/widgets/library_text_button.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _emailController =
      TextEditingController(text: "student@mail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "123456789");

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
    return Consumer<LoginController>(
        builder: (context, loginController, child) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: mainColor,
          body: Stack(
            children: [
              Column(
                children: [
                  const LibraryAppBar(
                    title: "Se Connecter",
                    showNotif: false,
                    bgColor: Colors.transparent,
                    titleColor: white,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(50),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                        color: white,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Se Connecter",
                            style: TextStyle(
                              color: black,
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
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
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: _inputDecoration.copyWith(
                                hintText: "Email / phone",
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
                              keyboardType: TextInputType.emailAddress,
                              decoration: _inputDecoration.copyWith(
                                hintText: "Mot de passe",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: LibraryTextButton(
                              onPressed: () async {
                                bool response = await loginController.login(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                if (response) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LibraryNavScreen(),
                                    ),
                                  );
                                }
                              },
                              label: "Se Connecter",
                              labelSize: 24,
                              width: 241,
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
                          ItemCard(
                            title: "Tous les formations",
                            image: "all_formations",
                            onClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SafeArea(
                                    child: Scaffold(
                                      body: FormationsScreenOut(),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 80,
                  ),
                  child: Image.asset("assets/images/profile.png"),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ItemCard extends StatelessWidget {
  final Function()? onClick;
  final String title, image;

  const ItemCard({
    Key? key,
    required this.onClick,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        height: 140,
        width: 155,
        decoration: BoxDecoration(
          color: Colors.black26,
          border: Border.all(
            color: const Color(0xFFDDDDDD),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB8D9FF), Color(0xFFF1FAFF)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imagify(image),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF363636),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
