import 'package:flutter/material.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/models/workshop.dart';
import 'package:library_app/screens/conferences/conferences_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/screens/widgets/library_text_button.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:library_app/utils/months.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ConferenceScreen extends StatelessWidget {
  final Workshop item;
  const ConferenceScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
      builder: (context, navigationController, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFD2ECFF),
                Color(0xFFFFFFFF),
              ], // Adjust gradient colors as needed
            ),
          ),
          child: Column(
            children: [
              LibraryAppBar(
                title: "Conference et Workshop",
                bgColor: Colors.transparent,
                titleColor: const Color(0xFF414243),
                onBack: () {
                  navigationController.navigateTo(
                    navigationController.screens.first,
                    index: 0,
                  );
                },
                backColor: const Color(0xFFD2ECFF),
                backBgColor: const Color(0xFF545454),
              ),
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      item.image!,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.title!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            "${item.isFree! ? 'Gratuit' : item.price}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Date: ${item.beginDate!.day} - ${item.endDate!.day} ${months[item.endDate!.month - 1]}",
                              style: const TextStyle(
                                fontSize: 11,
                                color: grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Participants: ${item.participants_count}",
                              style: const TextStyle(
                                fontSize: 11,
                                color: grey,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Emplacement :",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${item.address}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // const Text(
                      //   "Description:",
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //   ),
                      // ),
                      // Text(
                      //   "${item.description}",
                      //   style: const TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w300,
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      const Text(
                        "À propos de cet événement:",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${item.about}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Container(
                height: 66,
                color: const Color(
                  0xFFE0E5ED,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LibraryTextButton(
                      height: 40,
                      width: 200,
                      label: "En savoir plus",
                      labelSize: 18,
                      color: const Color(0xFF459FF2),
                      onPressed: () async {
                        final Uri url = Uri.parse(item.link!);
                        try {
                          await launchUrl(url);
                        } catch (e) {}
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
