import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:library_app/controllers/chat/chat_controller.dart';
import 'package:library_app/controllers/chat/conversation_controller.dart';
import 'package:library_app/controllers/login_controller.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/models/chat/message.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:library_app/utils/months.dart';
import 'package:provider/provider.dart';

class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({super.key});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  final TextEditingController _messageController = TextEditingController();

  final InputDecoration _inputDecoration = const InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
    filled: true,
    fillColor: white,
    contentPadding: EdgeInsets.symmetric(
      vertical: 0.0,
      horizontal: 25,
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
      builder: (context, navigationController, child) {
        return Consumer<LoginController>(
            builder: (context, loginController, child) {
          return Consumer<ConvesationController>(
              builder: (context, conversationController, child) {
            return Column(
              children: [
                LibraryAppBar(
                  title: "${conversationController.convesation.name}",
                  bgColor: const Color(0xFF3E97FF),
                  showNotif: false,
                  titleColor: white,
                  onBack: () {
                    navigationController
                        .navigateTo(navigationController.screens[3], index: 3);
                  },
                  backColor: const Color(0xFF3E97FF),
                  backBgColor: white,
                ),
                Expanded(
                  child: FutureBuilder<List<Message>>(
                    future: conversationController.getAllMessages(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          return Container(
                            color: const Color(0xFFF1F6FF),
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                    conversationController.messages.length,
                                    (index) {
                                  return DiscussionItem(
                                    // isSent: user.id ==
                                    //     conversationController
                                    //         .messages[index].userid,
                                    isSent: false,
                                    message:
                                        conversationController.messages[index],
                                  );
                                }),
                              ),
                            ),
                          );
                        default:
                          return const Center();
                      }
                    },
                  ),
                ),
                Container(
                  height: 80,
                  padding: const EdgeInsets.all(20),
                  color: white,
                  child: TextFormField(
                    controller: _messageController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration.copyWith(
                      prefixIcon: InkWell(
                        onTap: () {
                          conversationController.sendMessage(
                              content: _messageController.text);
                          _messageController.clear();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                            backgroundColor: mainColor,
                            child: SvgPicture.asset(
                              Assets.iconify("plus_bold"),
                              height: 30,
                              width: 30,
                              color: mainColor,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                Assets.iconify("voice"),
                                height: 30,
                                width: 30,
                                color: Colors.black,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () {},
                              child: Image.asset(
                                Assets.imagify("imogy"),
                                color: black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
        });
      },
    );
  }
}

class DiscussionItem extends StatelessWidget {
  const DiscussionItem({
    super.key,
    required this.message,
    required this.isSent,
  });

  final Message message;
  final bool isSent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment:
            isSent ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection: isSent ? TextDirection.ltr : TextDirection.rtl,
            children: [
              Padding(
                padding: isSent
                    ? const EdgeInsets.fromLTRB(10, 0, 0, 2)
                    : const EdgeInsets.fromLTRB(0, 0, 10, 2),
                child: CircleAvatar(
                    radius: 17,
                    foregroundImage:
                        NetworkImage(message.userimage.toString())),
              ),
              MessageBox(isSent: isSent, message: message),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                left: isSent ? 10.0 : 0.0, right: isSent ? 0.0 : 10.0),
            child: Text(
              "${message.username}  ${message.createAt!.isAfter(DateTime.now().subtract(const Duration(days: 1))) ? "" : message.createAt!.day} ${message.createAt!.isAfter(DateTime.now().subtract(const Duration(days: 1))) ? "" : months[message.createAt!.month - 1]}, ${message.createAt!.hour}:${message.createAt!.minute}",
              style: const TextStyle(
                color: Color(0xFFB4B4B4),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.message,
    required this.isSent,
  });

  final Message message;
  final bool isSent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width * .6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(32),
          topRight: const Radius.circular(32),
          bottomLeft: Radius.circular(isSent ? 0 : 32),
          bottomRight: Radius.circular(isSent ? 32 : 0),
        ),
        color: isSent ? mainColor : white,
      ),
      child: Text(
        "${message.body}",
        textAlign: isSent ? TextAlign.left : TextAlign.right,
        style: TextStyle(
          color: isSent ? white : black,
          fontSize: 20,
        ),
      ),
    );
  }
}
