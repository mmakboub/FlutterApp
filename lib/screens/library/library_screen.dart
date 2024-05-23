import 'package:flutter/material.dart';
import 'package:library_app/controllers/books_controller.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/screens/library/book_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final TextEditingController _searchController = TextEditingController();

  String name = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
        builder: (context, navigationController, child) {
      return Consumer<BooksController>(
          builder: (context, booksController, child) {
        return Column(
          children: [
            // LibraryAppBar(
            //   title: "Bibliotheque",
            //   bgColor: const Color(0xFFD5DFED),
            //   titleColor: const Color(0xFF424B53),
            //   onBack: () {
            //     navigationController.navigateTo(
            //       navigationController.screens.first,
            //       index: 0,
            //     );
            //   },
            //   backColor: const Color(0xFFD5DFED),
            //   backBgColor: const Color(0xFF545454),
            // ),
            LibraryAppBar(
              title: "Bibliotheque",
              bgColor: const Color(0xFFF2F7FA),
              titleColor: mainColor,
              onBack: () {
                navigationController
                    .navigateTo(navigationController.screens.first, index: 0);
              },
              backColor: white,
              backBgColor: const Color(0xFF545454),
            ),
            Container(
              height: 75,
              color: const Color(0xFFC1CCDC),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(9),
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.0,
                            color: red,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(9),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
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
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 15,
                        ),
                        prefixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              name = "";
                              _searchController.clear();
                            });
                          },
                          child: Icon(
                            name == "" ? Icons.search : Icons.close,
                            color: grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        name = _searchController.text;
                      });
                    },
                    child: const Text(
                      "Recherche",
                      style: TextStyle(
                        color: Color(0xFF118EE8),
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 11,
              color: const Color(0xFFD5DFED),
            ),
            FutureBuilder<List<Book>>(
              future: booksController.showBooks(name),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    List<Book> books = snapshot.data!;
                    return Expanded(
                      child: ListView(
                        children: List.generate(
                          books.length,
                          (index) => BookCard(
                            book: books[index],
                            onTap: () {
                              navigationController.navigateTo(
                                  BookScreen(book: books[index]),
                                  index: 0);
                            },
                          ),
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
          ],
        );
      });
    });
  }
}

class BookCard extends StatelessWidget {
  final Function()? onTap;
  final Book book;
  const BookCard({
    super.key,
    required this.book,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFCDDADF),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Image.network(
              book.image!,
              height: 78,
              width: 80,
              fit: BoxFit.contain,
              errorBuilder: (context, object, stackTrace) {
                return const SizedBox(
                  height: 78,
                  width: 80,
                );
              },
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${book.title}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: grey,
                  ),
                ),
                Text(
                  "${book.author}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF9FAAB9),
                  ),
                ),
                Text(
                  "${book.domain}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF9FAAB9),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
