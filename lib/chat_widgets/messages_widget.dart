import 'package:firebase_auth/firebase_auth.dart';
import 'package:Glow/controllers/firebase_api.dart';
import 'package:Glow/models/message.dart';
import 'package:Glow/chat_widgets/message_widget.dart';
import 'package:flutter/material.dart';
import '../controllers/fb_auth_controller.dart';

class MessagesWidget extends StatelessWidget {
  final String id;
  User user = FbAuthController().user;
  bool isDermatologist;

  MessagesWidget({
    required this.id,
    required this.isDermatologist,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
        stream: FirebaseApi.getMessages(isDermatologist, id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final messages = snapshot.data;

                return messages!.isEmpty
                    ? buildText('Say Hi..')
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          print(message.toJson());
                          return MessageWidget(
                            message: message,
                            isMe: message.id == user.uid,
                          );
                        },
                      );
              }
          }
        },
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      );
}
