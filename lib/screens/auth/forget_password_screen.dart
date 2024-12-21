import 'package:flutter/material.dart';
import 'package:Glow/controllers/fb_auth_controller.dart';
import 'package:Glow/helpers/helpers.dart';
import 'package:Glow/models/firebase_response.dart';
import 'package:Glow/widgets/custom_button.dart';
import 'package:Glow/widgets/custom_text_field.dart';
import 'package:Glow/constants.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with Helpers {
  late TextEditingController _emailTextController;
  String? _emailError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Image.asset("images/background.png"),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // Row(
                  //   children: [
                  //     IconButton(
                  //       onPressed: () => Navigator.pop(context),
                  //       icon: const Icon(Icons.arrow_back, color: Colors.black),
                  //     ),
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Find your account",
                          style: TextStyle(
                            fontSize: 30,
                            color: kTitleColor,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: const Text(
                            'Enter your email, please. We will send you a verification link to get your account back!',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 20),
                          child: CustomTextField(
                            controller: _emailTextController,
                            errorText: _emailError,
                            hintText: 'Email Address',
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            performPasswordReset();
                          },
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 29, left: 0),
                              width: 250,
                              height: 60,
                              padding: const EdgeInsets.only(
                                left: 15,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF918E8E),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: const Center(
                                child: Text(
                                  'Send Verification Code',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "OR",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Create a new account?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pushReplacementNamed(
                                context,
                                '/register_screen',
                              ),
                              child: const Text(
                                'Sign up!',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
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
          ],
        ),
      ),
    );
  }

  Future<void> performPasswordReset() async {
    if (checkData()) await passwordReset();
  }

  Future<void> passwordReset() async {
    FirebaseResponse response = await FbAuthController()
        .forgetPassword(email: _emailTextController.text);
    if (response.success) {
      Navigator.pop(context);
      showSnackBar(context: context, message: response.message);
    } else {
      showSnackBar(
          context: context,
          message: response.message,
          error: !response.success);
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty) {
      controlError();
      return true;
    }
    controlError();
    showSnackBar(
        context: context, message: "Enter required data!", error: true);
    return false;
  }

  void controlError() {
    setState(() {
      _emailError = _emailTextController.text.isEmpty
          ? 'Enter email address, Please!'
          : null;
    });
  }
}
