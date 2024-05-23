import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
        builder: (context, navigationController, child) {
      return Column(
        children: [
          LibraryAppBar(
            title: "Notifications",
            bgColor: const Color(0xFFF2F7FA),
            titleColor: mainColor,
            onBack: () {
              navigationController
                  .navigateTo(navigationController.screens.first, index: 0);
            },
            backColor: white,
            backBgColor: const Color(0xFF545454),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: const [
                  notificationItem(
                    isVisited: false,
                  ),
                  notificationItem(
                    isVisited: false,
                  ),
                  notificationItem(
                    isVisited: false,
                  ),
                  notificationItem(),
                  notificationItem(),
                  notificationItem(),
                  notificationItem(),
                  notificationItem(),
                  notificationItem(),
                  notificationItem(),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class notificationItem extends StatelessWidget {
  final bool isVisited;
  const notificationItem({
    super.key,
    this.isVisited = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            border: const Border(
              bottom: BorderSide(
                width: 1,
                color: grey,
              ),
            ),
            color: isVisited ? white : grey.withOpacity(.15),
            borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            SvgPicture.asset(
              Assets.iconify("doc_bold"),
              height: 30,
              width: 30,
              color: mainColor,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              width: 15,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Une formation a ete ajoutee",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
                Text(
                  "10 Oct 2023",
                  style: TextStyle(
                    fontSize: 13,
                    color: grey,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
