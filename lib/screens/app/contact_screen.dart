import 'package:flutter/material.dart';
import 'package:Glow/constants.dart';
import 'package:Glow/widgets/custom_button.dart';
import 'package:Glow/widgets/my_drawer.dart';

class ContactScreen extends StatelessWidget {
  final bool isDermatologist;
  const ContactScreen({super.key, this.isDermatologist = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100),
              child: Image.asset(
                'images/buttrfly.jpg',
                width: 20,
                height: 20,
                alignment: Alignment.bottomCenter,
              ),
            ),
            const Text(
              'Contact Us',
              style: TextStyle(color: kTitleColor),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true, // Ensure the drawer icon appears
      ),
      drawer: MyDrawer(
        isDermatologist: isDermatologist,
        currentPage: '/contact_screen',
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "images/facebook.png",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      const Text(
                        'Facebook',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/home_screen');
                  },
                ),
                CustomButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "images/instagram.png",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      const Text(
                        'Instagram',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/home_screen');
                  },
                ),
                CustomButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "images/whatsapp.png",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      const Text(
                        'Whatsapp',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/home_screen');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
