import 'package:flutter/material.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/screens/home_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/screens/widgets/library_text_button.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';

class CertificateRequestSuccessScreen extends StatelessWidget {
  const CertificateRequestSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
        builder: (context, navigationController, child) {
      return Expanded(
        child: ColoredBox(
          color: mainColor,
          child: Column(children: [
            LibraryAppBar(
              title: "Demande de Certificat",
              bgColor: Colors.transparent,
              titleColor: white,
              backBgColor: white,
              backColor: mainColor,
              onBack: () {
                navigationController.navigateTo(const HomeScreen(), index: 0);
              },
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xFF47CF1B),
                        child: Icon(
                          Icons.check,
                          color: white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Félicitations, votre demande a été dûment enregistrée. Votre certificat vous sera délivré dans un délai de 15 jours",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      LibraryTextButton(
                        onPressed: () async {
                          navigationController.navigateTo(const HomeScreen());
                        },
                        label: "D’accord",
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
                    ]),
              ),
            ),
          ]),
        ),
      );
    });
  }
}
