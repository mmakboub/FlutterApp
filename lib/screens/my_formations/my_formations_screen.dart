import 'package:library_app/controllers/my_formations_controller.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:library_app/models/formation.dart';
import 'package:library_app/screens/my_formations/courses_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';

class MyFormationsScreen extends StatefulWidget {
  const MyFormationsScreen({super.key});

  @override
  State<MyFormationsScreen> createState() => _MyFormationsScreenState();
}

class _MyFormationsScreenState extends State<MyFormationsScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
      builder: (context, navigationController, child) {
        return Consumer<MyFormationsController>(
            builder: (context, myFormationsController, child) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFDBE7FF),
                  Color(0x59E2C6F9),
                ], // Adjust gradient colors as needed
              ),
            ),
            child: Column(
              children: [
                LibraryAppBar(
                  title: "Mes Formations",
                  bgColor: Colors.transparent,
                  onBack: () {
                    navigationController.navigateTo(
                        navigationController.screens.first,
                        index: 0);
                  },
                  backColor: white,
                  // backBgColor: const Color(0xFF545454),
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: black,
                      fontSize: 20,
                    ),
                    children: [
                      TextSpan(
                        text: 'Bienvenue',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' KHERROUBI OUSSAMA',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedTab = 0;
                          });
                        },
                        child: Container(
                          // height: 50,
                          width: 140,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: selectedTab == 0
                                ? Colors.white
                                : const Color(0xFFC9D3DC),
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(20)),
                          ),
                          child: const Center(
                            child: Text(
                              'En cours',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedTab = 1;
                          });
                        },
                        child: Container(
                          // height: 50,
                          width: 140,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: selectedTab == 1
                                ? Colors.white
                                : const Color(0xFFC9D3DC),
                            borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(20)),
                          ),
                          child: const Center(
                            child: Text(
                              'Termine',
                              style: TextStyle(
                                fontSize: 24,
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
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFA4A8B9),
                      border: Border(
                        left: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                        right: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                        top: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: FutureBuilder(
                        future: selectedTab == 0
                            ? myFormationsController
                                .loadMyFormationsInProgress()
                            : myFormationsController.loadMyFormationsFinished(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.done:
                              List<Formation> formations = snapshot.data!;
                              return SingleChildScrollView(
                                child: Center(
                                  child: Column(
                                    children: List.generate(
                                      formations.length,
                                      (index) => MyFormationCard(
                                        // isFinished: selectedTab == 1,
                                        formation: formations[index],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            // return const Center();
                            default:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                          }
                        }),
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

class MyFormationCard extends StatelessWidget {
  final Formation formation;
  const MyFormationCard({
    super.key,
    required this.formation,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
        builder: (context, navigationController, child) {
      return InkWell(
        onTap: () {
          navigationController.navigateTo(
              MyFormationScreen(
                formation: formation,
              ),
              index: 1);
        },
        child: Container(
          height: 130,
          margin: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          width: MediaQuery.of(context).size.width - 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(15),
                  ),
                  child: Container(
                    height: 130,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(30),
                      ),
                    ),
                    child: FadeInImage.assetNetwork(
                      image: "${formation.image}",
                      placeholder: "${formation.image}",
                      imageErrorBuilder: (context, _, __) => Image.asset(
                        Assets.imagify("web"),
                        fit: BoxFit.cover,
                        height: 110,
                      ),
                      fit: BoxFit.cover,
                      height: 110,
                    ),
                  ),
                ),
              ),
              Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${formation.title}",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${formation.domain}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            const Text(
                              "En cours",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                color: const Color(0xFF3D91CE),
                                value: int.parse(formation.progress!) * .01,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "${formation.progress}%",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF687C8A),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "la durée: ${formation.period} ${formation.units}",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF687C8A),
                              ),
                            ),
                            const Text(
                              "Restant: 2 Mois",
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF687C8A),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
    });
  }
}
