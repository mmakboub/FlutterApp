// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:library_app/controllers/sessions_controller.dart';
import 'package:library_app/models/session.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';

import 'package:library_app/controllers/navigation_controller.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int week = 1;
  @override
  Widget build(BuildContext context) {
    return Consumer<SessionsController>(
        builder: (context, sessionsController, child) {
      return Consumer<NavigationController>(
        builder: (context, navigationController, child) {
          return Column(
            children: [
              LibraryAppBar(
                title: "Emploi du temps",
                bgColor: const Color(0xFFF2F7FA),
                // titleColor: const Color(0xFF1D6974),
                onBack: () {
                  navigationController
                      .navigateTo(navigationController.screens.first, index: 0);
                },
                backColor: white,
                backBgColor: const Color(0xFF545454),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (week > 1) {
                            week--;
                          }
                        });
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(0x661D6974),
                        size: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Sem$week",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0x661D6974),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (week < 10) {
                            week++;
                          }
                        });
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0x661D6974),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Session>>(
                  future: sessionsController.getSessions('week_$week'),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        List<Session> sessions = snapshot.data!;
                        return ListView(
                          children: List.generate(
                            sessions.length,
                            (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DateItem(
                                  date:
                                      "${sessions[index].day![0].toUpperCase() + sessions[index].day!.substring(1)} ${sessions[index].date!.day}-${sessions[index].date!.month}-${sessions[index].date!.year}",
                                ),
                                ScheduleCard(
                                  session: sessions[index],
                                  color: colors[index % colors.length],
                                ),
                              ],
                            ),
                          ),
                        );
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        return const Center();
                    }
                  },
                ),
              ),
            ],
          );
        },
      );
    });
  }
}

class DateItem extends StatelessWidget {
  final String date;
  const DateItem({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 0, 10),
      child: Text(
        date,
        style: const TextStyle(
          fontSize: 20,
          color: Color(0xFF1D6974),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final Session session;
  final Color color;
  const ScheduleCard({
    super.key,
    required this.session,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.withAlpha(102),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          VerticalDivider(
            width: 8,
            color: color,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${session.formationTitle}",
                      style: const TextStyle(
                        fontSize: 20,
                        color: grey,
                      ),
                    ),
                    Text(
                      "${session.start!.substring(0, session.start!.length - 3)} - ${session.end!.substring(0, session.end!.length - 3)}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: grey,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${session.group}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: grey,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "${session.teache}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: grey,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<Color> colors = [
  const Color(0xFFEAB93D),
  const Color(0xFF893DEA),
  const Color(0xFF3DCBEA),
  const Color(0xFF3DEA59),
];
