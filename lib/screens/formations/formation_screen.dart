import 'package:flutter/material.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/models/formation.dart';
import 'package:library_app/screens/formations/formations_screen.dart';
import 'package:library_app/screens/my_formations/zoom_screen.dart';
import 'package:library_app/screens/formations/register/formation_register.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/screens/widgets/library_text_button.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';

class FormationScreen extends StatefulWidget {
  final Formation formation;

  const FormationScreen({super.key, required this.formation});

  @override
  State<FormationScreen> createState() => _FormationScreenState();
}

class _FormationScreenState extends State<FormationScreen> {
  final List<Diplome> selectedDiplomas = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
      builder: (context, navigationController, child) {
        return Column(
          children: [
            LibraryAppBar(
              title: "Formation",
              bgColor: const Color(0xFFE8EFFA),
              titleColor: const Color(0xFF414243),
              onBack: () {
                navigationController.navigateTo(const FormationsScreen(),
                    index: 1);
              },
              backColor: white,
              backBgColor: const Color(0xFF414243),
            ),
            SizedBox(
              height: 220,
              width: double.infinity,
              child: FadeInImage.assetNetwork(
                image: "${widget.formation.image}",
                placeholder: "${widget.formation.image}",
                imageErrorBuilder: (context, _, __) => Image.asset(
                  Assets.imagify("web"),
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                color: const Color(0xFFF8F0FB),
                child: ListView(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${widget.formation.title}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          "${widget.formation.price} DH",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "La Durée : ${widget.formation.period} Mois",
                          style: const TextStyle(
                            fontSize: 13,
                            color: grey,
                          ),
                        ),
                        const Text(
                          "Etudiants: 73",
                          style: TextStyle(
                            fontSize: 13,
                            color: grey,
                          ),
                        ),
                        const Text(
                          "Avis: 42",
                          style: TextStyle(
                            fontSize: 13,
                            color: grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Type de certificat que vous souhaitez:",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      "(Vous pouvez cocher les deux options pour recevoir les deux types)",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    ...widget.formation.additionalDiplomas
                        .map(
                          (diploma) => Row(
                            children: [
                              Text(
                                "${diploma.diploma} (+${diploma.price} dh)",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                height: 30.0,
                                width: 30.0,
                                child: Checkbox(
                                  value: selectedDiplomas.contains(diploma),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        selectedDiplomas.add(diploma);
                                      } else {
                                        selectedDiplomas.remove(diploma);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                    const SizedBox(height: 10),
                    Center(
                      child: LibraryTextButton(
                        color: const Color(0xFFF573A4),
                        height: 40,
                        width: 155,
                        onPressed: () {
                          navigationController.navigateTo(
                            FormationRegisterScreen(
                              formation: widget.formation,
                              selectedDiplomas: selectedDiplomas,
                            ),
                            index: 0,
                          );
                        },
                        label: "S'inscrire",
                        labelSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Description :",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "${widget.formation.description}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Programe:",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      "Resume de schema",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Text(
                      "Methode de communication",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
