import 'package:flutter/material.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/controllers/offers_controller.dart';
import 'package:library_app/models/offer.dart';
import 'package:library_app/screens/offres_emploi_stage/stage_emploi_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
      builder: (context, navigationController, child) {
        return Consumer<OffersController>(
            builder: (context, offersController, child) {
          return Container(
            color: const Color(0xFF3E97FF),
            child: Column(
              children: [
                LibraryAppBar(
                  title: "Offre de stage et emploi",
                  bgColor: Colors.transparent,
                  titleColor: white,
                  onBack: () {
                    navigationController.navigateTo(
                        navigationController.screens.first,
                        index: 0);
                  },
                  backColor: const Color(0xFF3E97FF),
                  backBgColor: white,
                ),
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(9),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.0,
                          color: red,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(9),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.0,
                          color: mainColor,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(9),
                        ),
                      ),
                      filled: true,
                      fillColor: white,
                      hintText: "Recherche",
                      hintStyle: TextStyle(
                        color: Color(0xFF9B9696),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0.0,
                        horizontal: 15,
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF3E97FF),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          offersController.selectParam("job");
                        },
                        child: Container(
                          // height: 50,
                          width: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: offersController.selectedParam == "job"
                                ? Colors.white
                                : const Color(0xFFC9D3DC),
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(20)),
                          ),
                          child: const Center(
                            child: Text(
                              'Stage',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          offersController.selectParam("internship");
                        },
                        child: Container(
                          // height: 50,
                          width: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                offersController.selectedParam == "internship"
                                    ? Colors.white
                                    : const Color(0xFFC9D3DC),
                          ),
                          child: const Center(
                            child: Text(
                              'Emploi',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          offersController.selectParam("favorites");
                        },
                        child: Container(
                          // height: 50,
                          width: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: offersController.selectedParam == "favorites"
                                ? Colors.white
                                : const Color(0xFFC9D3DC),
                            borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(20)),
                          ),
                          child: const Center(
                            child: Text(
                              'Favoris',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE7ECF0),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      child: offersController.selectedParam == "favorites"
                          ? FutureBuilder<List<Offer>>(
                              future: offersController.getFavoritesOffers(),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.done:
                                    List<Offer> offers = snapshot.data!;
                                    return ListView(
                                      children: List.generate(
                                        offers.length,
                                        (index) => StageCard(
                                          offer: offers[index],
                                        ),
                                      ),
                                    );
                                  default:
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                }
                              },
                            )
                          : FutureBuilder<List<Offer>>(
                              future: offersController.getOffers(),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.done:
                                    List<Offer> offers = snapshot.data!;
                                    return ListView(
                                      children: List.generate(
                                        offers.length,
                                        (index) => StageCard(
                                          offer: offers[index],
                                        ),
                                      ),
                                    );
                                  default:
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                }
                              },
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

class StageCard extends StatelessWidget {
  final Offer offer;
  const StageCard({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
        builder: (context, navigationController, child) {
      return InkWell(
        onTap: () {
          navigationController.navigateTo(
              OfferScreen(
                offer: offer,
              ),
              index: 0);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          margin: const EdgeInsets.only(bottom: 15),
          decoration: const BoxDecoration(
            color: white,
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFCDDADF),
                width: 1,
              ),
            ),
          ),
          child: Row(
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
                    "${offer.company}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: grey,
                    ),
                  ),
                  Text(
                    "Post: ${offer.title}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF9FAAB9),
                    ),
                  ),
                  Text(
                    "Type de stage: ${offer.type}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF9FAAB9),
                    ),
                  ),
                  Text(
                    "La durée: ${offer.periode} ${offer.unit}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF9FAAB9),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF9FAAB9),
              ),
            ],
          ),
        ),
      );
    });
  }
}
