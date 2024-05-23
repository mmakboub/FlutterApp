import 'package:library_app/controllers/chat/chat_controller.dart';
import 'package:library_app/controllers/chat/conversation_controller.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:library_app/models/chat/conversation.dart';
import 'package:library_app/screens/chat/discussion_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
      builder: (context, navigationController, child) {
        return Column(
          children: [
            // LibraryAppBar(
            //   title: "Messages",
            //   bgColor: mainColor,
            //   titleColor: white,
            //   onBack: () {
            //     navigationController
            //         .navigateTo(navigationController.screens.first, index: 0);
            //   },
            //   backColor: mainColor,
            //   backBgColor: white,
            // ),
            LibraryAppBar(
              title: "Messages",
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
              child: Consumer<ChatController>(
                builder: (context, chatController, child) {
                  return FutureBuilder<List<Conversation>>(
                    future: chatController.getConversations(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          List<Conversation> conversations = snapshot.data!;
                          return ListView(
                            children: List.generate(
                              conversations.length,
                              (index) => ConversationCard(
                                conversation: conversations[index],
                                onClick: () {
                                  navigationController.navigateTo(
                                    ChangeNotifierProvider<
                                        ConvesationController>(
                                      create: (context) =>
                                          ConvesationController(
                                        convesation: conversations[index],
                                      ),
                                      child: const DiscussionScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        default:
                          return const Center();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class ConversationCard extends StatelessWidget {
  final Conversation conversation;
  final Function()? onClick;
  const ConversationCard({
    super.key,
    required this.conversation,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child:
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          //   decoration: BoxDecoration(
          //     color: white,
          //     border: const Border(
          //       bottom: BorderSide(
          //         color: Color(0xFFCDDADF),
          //         width: 1,
          //       ),
          //     ),
          //     boxShadow: [
          //       BoxShadow(
          //         blurStyle: BlurStyle.solid,
          //         color: Colors.black.withOpacity(.15),
          //         spreadRadius: 0,
          //         blurRadius: 10,
          //         offset: const Offset(0, 0), // Adjust shadow position as needed
          //       ),
          //     ],
          //   ),
          Container(
        decoration: BoxDecoration(
            border: const Border(
              bottom: BorderSide(
                width: 1,
                color: grey,
              ),
            ),
            color: white,
            borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 35,
              foregroundImage: NetworkImage(
                "${conversation.image}",
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${conversation.name}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: grey,
                          ),
                        ),
                      ),
                      const CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xFF36A8FA),
                        child: Center(
                          child: Text(
                            "1",
                            style: TextStyle(
                              fontSize: 16,
                              color: white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "nabil : c’est la regle de 1/3",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF9FAAB9),
                        ),
                      ),
                      Text(
                        "1:34 PM",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9FAAB9),
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
