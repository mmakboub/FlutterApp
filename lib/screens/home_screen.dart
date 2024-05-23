import 'package:flutter_svg/svg.dart';
import 'package:library_app/controllers/login_controller.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:library_app/models/offer.dart';
import 'package:library_app/screens/auth/login_screen.dart';
import 'package:library_app/screens/conferences/conference_screen.dart';
import 'package:library_app/screens/conferences/conferences_screen.dart';
import 'package:library_app/screens/formations/formations_screen.dart';
import 'package:library_app/screens/library/library_screen.dart';
import 'package:library_app/screens/my_formations/certificates/certificate_request_screen.dart';
import 'package:library_app/screens/my_formations/my_formations_screen.dart';
import 'package:library_app/screens/notifications/notifications_screen.dart';
import 'package:library_app/screens/offres_emploi_stage/offre_emploi_stage_screen.dart';
import 'package:library_app/screens/schedules/schedule_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
      builder: (context, navigationController, child) {
        return Consumer<LoginController>(
            builder: (context, loginController, child) {
          return Container(
            color: mainColor,
            child: Column(
              children: [
                // const LibraryAppBar(
                //   title: "Accueil",
                //   bgColor: Color(0xFF2985F1),
                //   titleColor: white,
                // ),
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: const BoxDecoration(
                    color: mainColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage(
                          Assets.imagify("profile"),
                        ),
                        foregroundImage: const NetworkImage(
                          "{user.image}",
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          "Accueil",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 24,
                            color: white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: InkWell(
                          onTap: () {
                            navigationController.navigateTo(
                              const NotificationsScreen(),
                            );
                          },
                          child: SvgPicture.asset(
                            Assets.iconify("notification_bold"),
                            height: 30,
                            width: 30,
                            color: white,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          30,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 35,
                            top: 0.0,
                            bottom: 10,
                          ),
                          child: Text(
                            "Menu",
                            style: TextStyle(
                              fontSize: 26,
                              color: Color(0xFFBBB9B9),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ItemCard(
                                  title: "Mes formations",
                                  image: "formations",
                                  onClick: () {
                                    navigationController.navigateTo(
                                      const MyFormationsScreen(),
                                      index: 1,
                                    );
                                  },
                                ),
                                ItemCard(
                                  title: "Toutes\nles formations",
                                  image: "all_formations",
                                  onClick: () {
                                    navigationController.navigateTo(
                                      const FormationsScreen(),
                                      index: 0,
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ItemCard(
                                  title: "Conferences et Workshops",
                                  image: "conferences",
                                  onClick: () {
                                    navigationController.navigateTo(
                                      const ConferencesScreen(),
                                      index: 0,
                                    );
                                  },
                                ),
                                ItemCard(
                                  title: "Offres de Stage et Emploi",
                                  image: "offre",
                                  onClick: () {
                                    navigationController.navigateTo(
                                      const OffersScreen(),
                                      index: 0,
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ItemCard(
                                  title: "L'emploi du temps",
                                  image: "timer",
                                  onClick: () {
                                    navigationController.navigateTo(
                                      const ScheduleScreen(),
                                      index: 2,
                                    );
                                  },
                                ),
                                ItemCard(
                                  title: "Bibliotheque",
                                  image: "biblioteques",
                                  onClick: () {
                                    navigationController.navigateTo(
                                      const LibraryScreen(),
                                      index: 0,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
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
