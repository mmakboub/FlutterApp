import 'package:flutter/material.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/controllers/offers_controller.dart';
import 'package:library_app/models/offer.dart';
import 'package:library_app/screens/my_formations/zoom_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/screens/widgets/library_text_button.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';

class OfferScreen extends StatelessWidget {
  final Offer offer;

  const OfferScreen({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Consumer<OffersController>(
        builder: (context, offersController, child) {
      return Consumer<NavigationController>(
        builder: (context, navigationController, child) {
          return Column(
            children: [
              LibraryAppBar(
                title: "Offre de stage et emploi",
                bgColor: const Color(0xFFFEFEFE),
                titleColor: const Color(0xFF424B53),
                onBack: () {
                  navigationController
                      .navigateTo(navigationController.screens.first, index: 0);
                },
                backColor: white,
                backBgColor: const Color(0xFF545454),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInImage.assetNetwork(
                            image: "${offer.image}",
                            placeholder: "${offer.image}",
                            imageErrorBuilder: (context, _, __) => Image.asset(
                              Assets.imagify("fly"),
                              fit: BoxFit.fitHeight,
                              height: 70,
                            ),
                            fit: BoxFit.fitWidth,
                            height: 70,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${offer.title}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${offer.company}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: black,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                "${offer.city}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: black,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Salaire",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ),
                              ),
                              Text(
                                "${offer.salary}",
                                // "4 000,00DH - 7 000,00DH par mois",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Type de poste",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ),
                              ),
                              Text(
                                "${offer.contract}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Divider(
                          height: 8,
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            const Text(
                              "Missions du poste",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "${offer.missions}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Profil demandé",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "${offer.skills}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Expérience",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "${offer.experience}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xFFFCFCFC),
                  boxShadow: [
                    BoxShadow(
                      blurStyle: BlurStyle.solid,
                      color: Color(0x20000000),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LibraryTextButton(
                      width: 140,
                      height: 40,
                      radius: 20,
                      label: "Postuler",
                      onPressed: () {
                        navigationController.navigateTo(const ZoomScreen(),
                            index: 2);
                      },
                      color: const Color(0xFF3881D7),
                    ),
                    InkWell(
                      onTap: () {
                        if (!offer.is_favor!) {
                          offersController.addToFavorites(offer.id!);
                        } else {
                          offersController.deleteFromFavorites(offer.id!);
                        }
                      },
                      child: Icon(
                        !offer.is_favor!
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 30,
                        color: grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
