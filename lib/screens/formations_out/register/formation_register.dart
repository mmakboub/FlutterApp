import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:library_app/controllers/formations_controller.dart';
import 'package:library_app/controllers/login_controller.dart';

import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/models/formation.dart';
import 'package:library_app/models/user.dart';
import 'package:library_app/screens/formations/formation_screen.dart';
import 'package:library_app/screens/home_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/screens/widgets/library_text_button.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:library_app/utils/consts.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

enum PaymentMethod { manual, banc }

class FormationRegisterScreenOut extends StatefulWidget {
  final Formation formation;
  final List<Diplome> selectedDiplomas;

  const FormationRegisterScreenOut({
    super.key,
    required this.formation,
    required this.selectedDiplomas,
  });

  @override
  State<FormationRegisterScreenOut> createState() =>
      _FormationRegisterScreenOutState();
}

class _FormationRegisterScreenOutState
    extends State<FormationRegisterScreenOut> {
  PaymentMethod? paymentMethod;

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pswdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _paysController = TextEditingController();
  final TextEditingController _addresseController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _carteNomController = TextEditingController();
  final TextEditingController _carteNumeroController = TextEditingController();
  final TextEditingController _carteDateController = TextEditingController();
  final TextEditingController _carteCvcController = TextEditingController();

  final InputDecoration _inputDecoration = const InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
    filled: true,
    fillColor: white,
    contentPadding: EdgeInsets.symmetric(
      vertical: 0.0,
      horizontal: 25,
    ),
    hintStyle: TextStyle(
      color: Color(0xFFB0B0B0),
      fontSize: 18,
      fontWeight: FontWeight.w300,
    ),
  );

  final InputDecoration _inputDecoration2 = const InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFD1D1D1),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFD1D1D1),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFD1D1D1),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
    filled: true,
    fillColor: Color(0xFFF8F8F8),
    contentPadding: EdgeInsets.symmetric(
      vertical: 0.0,
      horizontal: 10,
    ),
    hintStyle: TextStyle(
      color: Color(0xFFB0B0B0),
      fontSize: 18,
      fontWeight: FontWeight.w300,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<LoginController>(
            builder: (context, loginController, child) {
          return Consumer<FormationsController>(
              builder: (context, formationsController, child) {
            return Stack(
              children: [
                ColoredBox(
                  color: const Color(0xFF3E97FF),
                  child: Expanded(
                    child: Column(
                      children: [
                        LibraryAppBar(
                          title: "S'inscrire",
                          showNotif: false,
                          bgColor: Colors.transparent,
                          titleColor: white,
                          backBgColor: white,
                          backColor: const Color(0xFF3E97FF),
                          onBack: () {
                            // navigationController.navigateTo(const FormationScreen(formation: formation,));
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
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Text(
                                    "S'inscrire en formation",
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  // if (token.isEmpty)
                                  ...[
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
                                        controller: _nomController,
                                        keyboardType: TextInputType.number,
                                        decoration: _inputDecoration.copyWith(
                                          prefixIcon: Image.asset(
                                            Assets.imagify("user"),
                                          ),
                                          hintText: "Nom",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
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
                                        controller: _prenomController,
                                        keyboardType: TextInputType.number,
                                        decoration: _inputDecoration.copyWith(
                                          prefixIcon: Image.asset(
                                            Assets.imagify("user"),
                                          ),
                                          hintText: "Prenom",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
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
                                        controller: _phoneController,
                                        keyboardType: TextInputType.number,
                                        decoration: _inputDecoration.copyWith(
                                          prefixIcon: Image.asset(
                                            Assets.imagify("phone"),
                                          ),
                                          hintText: "Telephone",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
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
                                        keyboardType: TextInputType.number,
                                        decoration: _inputDecoration.copyWith(
                                          prefixIcon: Image.asset(
                                            Assets.imagify("email"),
                                          ),
                                          hintText: "Email",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
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
                                        controller: _pswdController,
                                        keyboardType: TextInputType.number,
                                        decoration: _inputDecoration.copyWith(
                                          prefixIcon: Image.asset(
                                            Assets.imagify("email"),
                                          ),
                                          hintText: "Mot de passe",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
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
                                        controller: _paysController,
                                        keyboardType: TextInputType.number,
                                        decoration: _inputDecoration.copyWith(
                                          prefixIcon: Image.asset(
                                            Assets.imagify("location"),
                                          ),
                                          hintText: "Pays",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
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
                                        controller: _addresseController,
                                        keyboardType: TextInputType.number,
                                        decoration: _inputDecoration.copyWith(
                                          prefixIcon: Image.asset(
                                            Assets.imagify("location"),
                                          ),
                                          hintText: "Addresse",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: paymentMethod.toString() ==
                                            PaymentMethod.manual.toString(),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value!) {
                                              paymentMethod =
                                                  PaymentMethod.manual;
                                            } else {
                                              paymentMethod = null;
                                            }
                                          });
                                        },
                                      ),
                                      const Text("Paiement manuel"),
                                    ],
                                  ),
                                  if (paymentMethod.toString() ==
                                      PaymentMethod.manual.toString())
                                    const Text(
                                      "Veuillez copier le code et le conserver pour effectuer un paiement manuel sur le compte bancaire",
                                      textAlign: TextAlign.center,
                                    ),
                                  if (paymentMethod.toString() ==
                                      PaymentMethod.manual.toString())
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: TextFormField(
                                        enabled: false,
                                        controller: _codeController,
                                        keyboardType: TextInputType.number,
                                        decoration: _inputDecoration2.copyWith(
                                          hintText: "7362901738266292719037134",
                                        ),
                                      ),
                                    ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: paymentMethod.toString() ==
                                            PaymentMethod.banc.toString(),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value!) {
                                              paymentMethod =
                                                  PaymentMethod.banc;
                                            } else {
                                              paymentMethod = null;
                                            }
                                          });
                                        },
                                      ),
                                      const Text("Paiement par carte bancaire"),
                                    ],
                                  ),
                                  if (paymentMethod.toString() ==
                                      PaymentMethod.banc.toString())
                                    Column(
                                      children: [
                                        TextFormField(
                                          controller: _carteNomController,
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              _inputDecoration2.copyWith(
                                            hintText: "Nom",
                                          ),
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                value.length < 8) {
                                              return 'Please enter a valid password!';
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller: _carteNumeroController,
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              _inputDecoration2.copyWith(
                                            hintText: "Numéro de carte",
                                          ),
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                value.length < 8) {
                                              return 'Please enter a valid password!';
                                            }
                                            return null;
                                          },
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    _carteDateController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    _inputDecoration2.copyWith(
                                                  hintText: "MM/YY",
                                                ),
                                                validator: (String? value) {
                                                  if (value == null ||
                                                      value.isEmpty ||
                                                      value.length < 8) {
                                                    return 'Please enter a valid password!';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                controller: _carteCvcController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    _inputDecoration2.copyWith(
                                                  hintText: "CVC",
                                                ),
                                                validator: (String? value) {
                                                  if (value == null ||
                                                      value.isEmpty ||
                                                      value.length < 8) {
                                                    return 'Please enter a valid password!';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  LibraryTextButton(
                                    onPressed: () async {
                                      final response = await http.post(
                                        Uri.parse("$baseUrl/login"),
                                        body: {
                                          "name":
                                              "${_nomController.text} ${_prenomController.text}",
                                          "email": _emailController.text,
                                          "password": _pswdController.text,
                                          "password_confirmation":
                                              "12345678Aa#",
                                          "address": _addresseController.text,
                                          "phone": _phoneController.text,
                                          "country": _paysController.text,
                                        },
                                      );

                                      final decodedResponce =
                                          jsonDecode(response.body);

                                      if (decodedResponce['message'] ==
                                          "user record created") {
                                        bool ans = await loginController.login(
                                            email: _emailController.text,
                                            password: _pswdController.text);

                                        if (ans) {
                                          if (paymentMethod ==
                                              PaymentMethod.manual) {
                                            formationsController
                                                .subscribeAtFormation(
                                              widget.formation.id!,
                                              widget.selectedDiplomas,
                                            )
                                                .then((value) {
                                              if (value) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const RegisterSuccessScreenOut(),
                                                  ),
                                                );
                                              }
                                            });
                                          }
                                        }
                                      }
                                    },
                                    label: "S’inscrire",
                                    labelSize: 24,
                                    width: 200,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 80,
                    ),
                    child: Image.asset("assets/images/man.png"),
                  ),
                ),
              ],
            );
          });
        }),
      ),
    );
  }
}

class RegisterSuccessScreenOut extends StatelessWidget {
  const RegisterSuccessScreenOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: ColoredBox(
            color: mainColor,
            child: Column(children: [
              const LibraryAppBar(
                showNotif: false,
                title: "S'inscrire",
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        const Text(
                          "Félicitations pour avoir franchi avec succès l'étape d'inscription à notre formation !",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          "( Notre équipe vous contactera prochainement pour vous fournir toutes les informations nécessaires)",
                          style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: LibraryTextButton(
                            onPressed: () async {
                              while (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            },
                            label: "D’accord",
                            labelSize: 24,
                            width: double.infinity,
                          ),
                        ),
                      ]),
                ),
              ),
            ]),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 80,
            ),
            child: Image.asset("assets/images/man.png"),
          ),
        ),
      ],
    );
  }
}
