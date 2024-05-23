import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/screens/library/library_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';

class BookScreen extends StatelessWidget {
  final Book book;
  const BookScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
        builder: (context, navigationController, child) {
      return Column(
        children: [
          LibraryAppBar(
            title: "${book.title}",
            bgColor: const Color(0xFFF3F6F9),
            titleColor: const Color(0xFF424B53),
            onBack: () {
              navigationController.navigateTo(
                const LibraryScreen(),
                index: 0,
              );
            },
            backColor: const Color(0xFFF3F6F9),
            backBgColor: const Color(0xFF545454),
          ),
          Expanded(
            child: const PDF(
              fitEachPage: false,
              preventLinkNavigation: false,
              // swipeHorizontal: true,
            ).cachedFromUrl(
              "${book.pdf}",
              placeholder: (progress) => Center(child: Text('$progress %')),
              errorWidget: (error) => Center(child: Text(error.toString())),
            ),
          ),
        ],
      );
    });
  }
}
