import 'package:flutter/material.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/screens/my_formations/certificates/certificate_request_success_screen.dart';
import 'package:library_app/screens/widgets/library_text_button.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';

class CertificateRequestScreen extends StatelessWidget {
  CertificateRequestScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _addresseController = TextEditingController();
  final _dobController = TextEditingController();
  final _cinController = TextEditingController();
  final InputDecoration _inputDecoration = const InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(25),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.0,
        color: red,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(25),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.0,
        color: mainColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(25),
      ),
    ),
    filled: true,
    fillColor: white,
    contentPadding: EdgeInsets.symmetric(
      vertical: 0.0,
      horizontal: 15,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
      builder: (context, navigationController, child) {
        return Scaffold(
          body: Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFD5DFED),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          Assets.imagify(
                            "certify_bg",
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      "Demande de Certificat ",
                      style: TextStyle(
                        fontSize: 26,
                        color: Color(0xFF363636),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                      ),
                      // width: 400,
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Nom:",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF4A4A4A),
                                ),
                              ),
                              const SizedBox(height: 7),
                              TextFormField(
                                controller: _nomController,
                                decoration: _inputDecoration,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 7),
                              const Text(
                                "Prenom:",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF4A4A4A),
                                ),
                              ),
                              const SizedBox(height: 7),
                              TextFormField(
                                controller: _prenomController,
                                decoration: _inputDecoration,
                              ),
                              const SizedBox(height: 7),
                              const Text(
                                "Telephone:",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF4A4A4A),
                                ),
                              ),
                              const SizedBox(height: 7),
                              TextFormField(
                                controller: _telephoneController,
                                decoration: _inputDecoration,
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(height: 7),
                              const Text(
                                "Adresse complète:",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF4A4A4A),
                                ),
                              ),
                              const SizedBox(height: 7),
                              TextFormField(
                                controller: _addresseController,
                                decoration: _inputDecoration,
                              ),
                              const SizedBox(height: 7),
                              const Text(
                                "Date de naissance:",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF4A4A4A),
                                ),
                              ),
                              const SizedBox(height: 7),
                              TextFormField(
                                controller: _dobController,
                                keyboardType: TextInputType.datetime,
                                decoration: _inputDecoration,
                              ),
                              const SizedBox(height: 7),
                              const Text(
                                "Numéro de carte d'identité (CIN):",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF4A4A4A),
                                ),
                              ),
                              const SizedBox(height: 7),
                              TextFormField(
                                controller: _cinController,
                                keyboardType: TextInputType.number,
                                decoration: _inputDecoration,
                              ),
                              const SizedBox(height: 40),
                              Center(
                                child: LibraryTextButton(
                                  color: const Color(0xFF296DAD),
                                  height: 40,
                                  width: 155,
                                  onPressed: () async {
                                    navigationController.navigateTo(
                                      const CertificateRequestSuccessScreen(),
                                      index: 1,
                                    );
                                  },
                                  label: "Demander",
                                  labelSize: 20,
                                ),
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
