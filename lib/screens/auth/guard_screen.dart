import 'package:flutter/material.dart';
import 'package:Glow/screens/auth/login_screen.dart';
import 'package:Glow/constants.dart';

class GuardScreen extends StatefulWidget {
  const GuardScreen({super.key});

  @override
  State<GuardScreen> createState() => _GuardScreenState();
}

class _GuardScreenState extends State<GuardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          Center(
            child: Image.asset(
              'images/screen2.png',
              width: 350,
              height: 350,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              'Login as a ..',
              style: TextStyle(
                  color: Color.fromRGBO(77, 52, 103, 0.73), fontSize: 25),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        isUser: true,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
                  width: 150,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFF918E8E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'User',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        isUser: false,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
                  width: 150,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFF918E8E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_hospital,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Dermatologist',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Center(
  //           child: Image.asset(
  //             'images/screen2.png',
  //             width: 350,
  //             height: 350,
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         const Center(
  //           child: Text(
  //             'Login as a ..',
  //             style: TextStyle(color: kTitleColor, fontSize: 25),
  //           ),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             GestureDetector(
  //               onTap: () async {
  //                 await Navigator.of(context).push(
  //                   MaterialPageRoute(
  //                     builder: (context) => LoginScreen(
  //                       isUser: true,
  //                     ),
  //                   ),
  //                 );
  //               },
  //               child: Container(
  //                 alignment: Alignment.center,
  //                 padding: const EdgeInsets.symmetric(horizontal: 10),
  //                 margin:
  //                     const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
  //                 width: 140,
  //                 height: 60,
  //                 decoration: BoxDecoration(
  //                   color: kBackgroundColor,
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 child: const Text(
  //                   'User',
  //                   style: TextStyle(color: Colors.white, fontSize: 22),
  //                 ),
  //               ),
  //             ),
  //             GestureDetector(
  //               onTap: () async {
  //                 await Navigator.of(context).push(
  //                   MaterialPageRoute(
  //                     builder: (context) => LoginScreen(
  //                       isUser: false,
  //                     ),
  //                   ),
  //                 );
  //               },
  //               child: Container(
  //                 alignment: Alignment.center,
  //                 padding: const EdgeInsets.symmetric(horizontal: 10),
  //                 margin:
  //                     const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
  //                 width: 140,
  //                 height: 60,
  //                 decoration: BoxDecoration(
  //                   color: kBackgroundColor,
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 child: const Text(
  //                   'Dermatologist',
  //                   style: TextStyle(color: Colors.white, fontSize: 18),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

