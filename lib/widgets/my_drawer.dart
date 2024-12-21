// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:Glow/constants.dart';
// import 'package:Glow/screens/app/home_screen.dart';
// import 'package:Glow/screens/app/profile_screen.dart';
// import 'package:Glow/controllers/fb_auth_controller.dart';
// import 'package:Glow/screens/app/chats_page.dart'; // Add this import for ChatsPage

// class MyDrawer extends StatelessWidget {
//   final bool isDermatologist;
//   final User user = FirebaseAuth.instance.currentUser!;
//   MyDrawer({super.key, required this.isDermatologist});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: kPrimaryColor,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           SizedBox(
//             width: double.infinity,
//             height: 250,
//             child: Image.asset(
//               'images/side_bar.jpg',
//               fit: BoxFit.fill,
//             ),
//           ),
//           Visibility(
//             visible: !isDermatologist,
//             child: ListTile(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => ProfileScreen(),
//                   ),
//                 );
//               },
//               trailing: const Icon(
//                 Icons.person_2_outlined,
//                 color: kTitleColor,
//               ),
//               title: const Text(
//                 'My profile',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: kTitleColor,
//                 ),
//               ),
//             ),
//           ),
//           ListTile(
//             onTap: () async {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       ChatsPage(isDermatologist: isDermatologist),
//                 ),
//               );
//             },
//             trailing: const Icon(
//               Icons.chat_bubble_outline,
//               color: kTitleColor,
//             ),
//             title: const Text(
//               'Dermatologist chat',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: kTitleColor,
//               ),
//             ),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.pushNamed(context, '/contact_screen');
//             },
//             trailing: const Icon(
//               Icons.email_outlined,
//               color: kTitleColor,
//             ),
//             title: const Text(
//               'Connect with us',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: kTitleColor,
//               ),
//             ),
//           ),
//           ListTile(
//             onTap: () async {
//               await FbAuthController().signOut();
//               Navigator.pushReplacementNamed(context, '/guard_screen');
//             },
//             trailing: const Icon(
//               Icons.logout,
//               color: kTitleColor,
//             ),
//             title: const Text(
//               'Logout',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: kTitleColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Glow/constants.dart';
import 'package:Glow/screens/app/home_screen.dart';
import 'package:Glow/screens/app/profile_screen.dart';
import 'package:Glow/controllers/fb_auth_controller.dart';
import 'package:Glow/screens/app/chats_page.dart';

class MyDrawer extends StatelessWidget {
  final bool isDermatologist;
  final String currentPage;
  final User user = FirebaseAuth.instance.currentUser!;

  MyDrawer(
      {super.key, required this.isDermatologist, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kPrimaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: Image.asset(
              'images/side_bar.jpg',
              fit: BoxFit.fill,
            ),
          ),
          _buildDrawerItem(
            context,
            title: 'Home',
            icon: Icons.home_outlined,
            route: '/home_screen',
            isActive: currentPage == '/home_screen',
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          isDermatologist: isDermatologist,
                          user: user,
                        )),
              );
            },
          ),
          Visibility(
            visible: !isDermatologist,
            child: _buildDrawerItem(
              context,
              title: 'My profile',
              icon: Icons.person_2_outlined,
              route: '/profile_screen',
              isActive: currentPage == '/profile_screen',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ),
          _buildDrawerItem(
            context,
            title: 'Dermatologist chat',
            icon: Icons.chat_bubble_outline,
            route: '/chats_page',
            isActive: currentPage == '/chats_page',
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>
                      ChatsPage(isDermatologist: isDermatologist),
                ),
              );
            },
          ),
          _buildDrawerItem(
            context,
            title: 'Connect with us',
            icon: Icons.email_outlined,
            route: '/contact_screen',
            isActive: currentPage == '/contact_screen',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/contact_screen');
            },
          ),
          _buildDrawerItem(
            context,
            title: 'Logout',
            icon: Icons.logout,
            route: '/guard_screen',
            isActive: false, // Logout doesn't need a highlight
            onTap: () async {
              await FbAuthController().signOut();
              Navigator.pushReplacementNamed(context, '/guard_screen');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String route,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      trailing: Icon(
        icon,
        color: isActive ? Colors.white : kTitleColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: isActive ? Colors.white : kTitleColor,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: isActive ? kTitleColor.withOpacity(0.2) : Colors.transparent,
    );
  }
}
