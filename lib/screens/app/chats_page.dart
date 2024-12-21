import 'package:Glow/chat_widgets/chat_body_widget.dart';
import 'package:Glow/controllers/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:Glow/models/chat_user.dart';
import 'package:Glow/screens/app/home_screen.dart';
import 'package:Glow/screens/app/profile_screen.dart';
import 'package:Glow/constants.dart';
import '../../controllers/fb_auth_controller.dart';
import '../../widgets/my_drawer.dart';

// ignore: must_be_immutable
class ChatsPage extends StatelessWidget {
  bool isDermatologist;

  ChatsPage({required this.isDermatologist, super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 65,
          title: const Text(
            'Dermatologist chat',
            style: TextStyle(
              color: kTitleColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              if (!scaffoldKey.currentState!.isDrawerOpen) {
                scaffoldKey.currentState!.openDrawer();
              }
            },
            icon: const Icon(
              Icons.menu,
              color: kTitleColor,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: kTitleColor,
              ),
            ),
          ],
        ),
        drawer: MyDrawer(
            isDermatologist: isDermatologist, currentPage: '/chats_page'),
        body: SafeArea(
          child: Stack(
            children: [
              Image.asset(
                'images/background.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              StreamBuilder<List<ChatUser>>(
                stream: FirebaseApi.getUsers(isDermatologist),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(color: kPrimaryColor),
                      );
                    default:
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return buildText('Something Went Wrong Try later');
                      } else {
                        final users = snapshot.data;

                        if (users!.isEmpty) {
                          return buildText('No Users Found');
                        } else {
                          return Column(
                            children: [
                              ChatBodyWidget(
                                  users: users,
                                  isDermatologist: isDermatologist)
                            ],
                          );
                        }
                      }
                  }
                },
              ),
            ],
          ),
        ),
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, color: kPrimaryColor),
        ),
      );
}
