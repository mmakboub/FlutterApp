import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:library_app/controllers/courses_controller.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/models/formation.dart';
import 'package:library_app/screens/my_formations/zoom_screen.dart';
import 'package:library_app/screens/notifications/notifications_screen.dart';
import 'package:library_app/screens/widgets/library_text_button.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// class CoursesScreen extends StatefulWidget {
//   final Formation formation;
//   const CoursesScreen({super.key, required this.formation});

//   @override
//   State<CoursesScreen> createState() => _CoursesScreenState();
// }

// class _CoursesScreenState extends State<CoursesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<CoursesController>(
//       create: (context) => CoursesController(),
//       child: Consumer<CoursesController>(
//           builder: (context, coursesController, child) {
//         return Consumer<NavigationController>(
//             builder: (context, navigationController, child) {
//           return Expanded(
//             child: FutureBuilder<List<Map<String, dynamic>>>(
//               future: coursesController.loadCourses(widget.formation.id!),
//               builder: (context, snapshot) {
//                 return const Column(
//                   children: [],
//                 );
//               },
//             ),
//           );
//         });
//       }),
//     );
//   }
// }

class MyFormationScreen extends StatelessWidget {
  final Formation formation;
  const MyFormationScreen({super.key, required this.formation});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? course = formation.course;

    return Consumer<NavigationController>(
      builder: (context, navigationController, child) {
        return Column(
          children: [
            Consumer<NavigationController>(
                builder: (context, navigationController, child) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFE6EFF9),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        Assets.iconify("arrow_back_bold"),
                        height: 35,
                        width: 35,
                        color: Colors.black,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Center(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${formation.title}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 24,
                              color: black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Objectif: ${formation.progress}%",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 14,
                              color: black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
                          color: Colors.black,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(
              height: 220,
              width: double.infinity,
              child: FadeInImage.assetNetwork(
                image: "${course!['image']}",
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                color: const Color(0xFFF8F0FB),
                child: ListView(
                  children: [
                    Text(
                      "${course["title"]}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Description :",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "${course["description"]}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Documents :",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    ...List.generate(
                      course['pdf'].length,
                      (index) => InkWell(
                        onTap: () async {
                          Uri uri = Uri.parse(course['pdf'][index]['name']);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        },
                        child: Row(
                          children: [
                            Image.asset('assets/images/book_icon.png'),
                            Text(
                              "${course['pdf'][index]["name"]}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 72,
              color: const Color(
                0xFFDEE4EB,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LibraryTextButton(
                    width: 150,
                    label: "< Precedent",
                    onPressed: () {
                      navigationController.navigateTo(const ZoomScreen(),
                          index: 1);
                    },
                    color: const Color(0xFF35383D),
                  ),
                  // Text(
                  //   "Objectif : ${formation.progress}%",
                  //   style: const TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.w200,
                  //   ),
                  // ),
                  LibraryTextButton(
                    width: 150,
                    label: "Suivant >",
                    onPressed: () {
                      navigationController.navigateTo(const ZoomScreen(),
                          index: 1);
                    },
                    color: const Color(0xFF35383D),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ObjectiveIndicator extends StatelessWidget {
  final double progress;
  const ObjectiveIndicator({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: const Color(
        0xFFDEE4EB,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Objectif : ${progress.toInt()}%",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          LibraryTextButton(
            label: "Continuer",
            onPressed: () {},
            color: const Color(0xFF35383D),
          ),
        ],
      ),
    );
  }
}
