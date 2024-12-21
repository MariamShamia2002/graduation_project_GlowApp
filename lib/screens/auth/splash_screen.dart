import 'package:flutter/material.dart';
import 'package:Glow/controllers/fb_auth_controller.dart';
import 'package:Glow/controllers/fb_firestore_controller.dart';
import 'package:Glow/screens/app/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isDermatologist = false;
  void changeVal() async {
    isDermatologist = await FbFireStoreController()
        .doesDermatologistExist(FbAuthController().user.email!);
  }

  @override
  void initState() {
    // TODO: implement initState
    changeVal();
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        bool isLoggedIn = FbAuthController().loggedIn;
        if (isLoggedIn) {
          // User user = FbAuthController().user;
          // print(FbFireStoreController().readUser(user!.uid).);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                  user: FbAuthController().user,
                  isDermatologist: isDermatologist),
            ),
          );
        } else {
          Navigator.pushReplacementNamed(context, '/guard_screen');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'images/Glow-logo.png',
        ),
      ),
    );
  }
}
