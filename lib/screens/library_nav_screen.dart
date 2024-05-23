import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LibraryNavScreen extends StatelessWidget {
  const LibraryNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
      builder: (context, navigationController, child) {
        return PopScope(
          canPop: false,
          onPopInvoked: (result) {
            navigationController.navigateTo(
              navigationController.screens[2],
              index: 2,
            );
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: bgColor,
              body: Column(
                children: [
                  //! Content
                  Expanded(
                    child: navigationController.currentScreen,
                  ),
                  //! Nav Bar
                  Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 75,
                    color: const Color(0xFFEAEEF4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        navigationController.screens.length,
                        (index) => Expanded(
                          child: InkWell(
                            onTap: () {
                              navigationController.navigateTo(
                                navigationController.screens[index],
                                index: index,
                              );
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    navigationController.currentIndex == index
                                        ? Assets.iconify(
                                            navigationController.icons[index] +
                                                "_bold")
                                        : Assets.iconify(
                                            navigationController.icons[index]),
                                    height: 30,
                                    width: 30,
                                    color: navigationController.currentIndex ==
                                            index
                                        ? mainColor
                                        : grey,
                                  ),
                                  Text(
                                    navigationController.labels[index],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          navigationController.currentIndex ==
                                                  index
                                              ? mainColor
                                              : grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
