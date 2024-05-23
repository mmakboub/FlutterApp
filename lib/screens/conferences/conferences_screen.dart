// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:library_app/controllers/conferences_controller.dart';
import 'package:library_app/models/workshop.dart';
import 'package:provider/provider.dart';

import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/screens/conferences/conference_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/utils/colors.dart';
import 'package:library_app/utils/months.dart';

class ConferencesScreen extends StatelessWidget {
  const ConferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
      builder: (context, navigationController, child) {
        return Consumer<WorkshopsController>(
            builder: (context, workshopsController, child) {
          return Column(
            children: [
              LibraryAppBar(
                title: "Conferences et Workshops",
                bgColor: const Color(0xFFAAC8EB),
                // titleColor: const Color(0xFF424B53),
                onBack: () {
                  navigationController.navigateTo(
                    navigationController.screens.first,
                    index: 0,
                  );
                },
                backColor: const Color(0xFFAAC8EB),
                backBgColor: const Color(0xFF545454),
              ),
              Container(
                height: 80,
                margin: const EdgeInsets.only(
                  bottom: 10,
                ),
                color: white,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CalendarItem(
                        upText: "2023", downText: "OCT", isSelected: true),
                    CalendarItem(
                        upText: "DIM", downText: "15", isSelected: false),
                    CalendarItem(
                        upText: "LUN", downText: "16", isSelected: false),
                    CalendarItem(
                        upText: "MAR", downText: "17", isSelected: true),
                    CalendarItem(
                        upText: "MER", downText: "18", isSelected: false),
                    CalendarItem(
                        upText: "JEU", downText: "19", isSelected: false),
                    CalendarItem(
                        upText: "VEN", downText: "20", isSelected: false),
                    CalendarItem(
                        upText: "SAM", downText: "21", isSelected: false),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFFAAC8EB),
                  child: FutureBuilder<List<Workshop>>(
                    future: workshopsController.getWorkshops(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          List<Workshop> workshops = snapshot.data!;
                          return SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                workshops.length,
                                (index) => ConferenceCard(
                                  item: workshops[index],
                                  onTap: () {
                                    navigationController.navigateTo(
                                      ConferenceScreen(
                                        item: workshops[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        default:
                          return const Center();
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }
}

class CalendarItem extends StatelessWidget {
  final String upText, downText;
  final bool isSelected;

  const CalendarItem({
    Key? key,
    required this.upText,
    required this.downText,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: isSelected
              ? const BorderSide(
                  color: Color(0xFF5CBBFF),
                  width: 2,
                )
              : const BorderSide(),
        ),
      ),
      child: Column(
        children: [
          Text(
            upText,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w300,
              color: const Color(0xFF54708B),
              fontSize: 20,
            ),
          ),
          Text(
            downText,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w300,
              color: const Color(0xFF54708B),
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class ConferenceCard extends StatelessWidget {
  final Workshop item;
  final Function()? onTap;
  const ConferenceCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Text(
              "${item.beginDate!.day}-${item.endDate!.day}\n ${months[item.endDate!.month - 1]}",
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF57687C),
                fontWeight: FontWeight.w300,
              ),
            ),
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: const VerticalDivider(
                width: 8,
                color: Color(0xFF7DC0F0),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title!,
                    style: const TextStyle(
                      fontSize: 20,
                      color: grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/male.png"),
                          Text(
                            item.participants_count.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF9FAAB9),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Prix: ${item.isFree! ? 'Gratuit' : item.price}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF9FAAB9),
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
      ),
    );
  }
}
