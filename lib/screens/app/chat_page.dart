import 'package:Glow/chat_widgets/messages_widget.dart';
import 'package:Glow/chat_widgets/new_message_widget.dart';
import 'package:Glow/chat_widgets/profile_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:Glow/models/chat_user.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  final ChatUser user;
  bool isDermatologist;

  ChatPage({
    required this.user,
    required this.isDermatologist,
    super.key,
  });
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFFE8DEF8),
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(
                user: widget.user,
                isDermatologist: widget.isDermatologist,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: MessagesWidget(
                    id: widget.user.id,
                    isDermatologist: widget.isDermatologist,
                  ),
                ),
              ),
              NewMessageWidget(
                  id: widget.user.id, isDermatologist: widget.isDermatologist)
            ],
          ),
        ),
      );
}
