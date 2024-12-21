import 'package:Glow/screens/app/chat_page.dart';
import 'package:flutter/material.dart';

import '../models/chat_user.dart';

// ignore: must_be_immutable
class ChatBodyWidget extends StatelessWidget {
  final List<ChatUser> users;
  bool isDermatologist;

  ChatBodyWidget({
    required this.users,
    required this.isDermatologist,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: buildChats()),
      );

  Widget buildChats() => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 75,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ChatPage(user: user, isDermatologist: isDermatologist),
                  ));
                },
                leading: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('images/anime-boy.jpg'),
                ),
                title: Text(user.name),
              ),
            ),
          );
        },
        itemCount: users.length,
      );
}
