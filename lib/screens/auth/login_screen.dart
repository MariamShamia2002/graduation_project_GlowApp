import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Glow/controllers/fb_auth_controller.dart';
import 'package:Glow/controllers/fb_firestore_controller.dart';
import 'package:Glow/helpers/helpers.dart';
import 'package:Glow/models/firebase_response.dart';
import 'package:Glow/screens/app/home_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({required this.isUser, super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  late bool isUser;
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  String? _emailError;
  String? _passwordError;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = navigateToRegisterScreen;
  }

  void navigateToRegisterScreen() {
    Navigator.pushNamed(context, '/register_screen');
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              "images/background.png"), // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 60),
                    child: Text(
                      "Welcome Back To Glow!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(77, 52, 103, 0.73),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Image.asset(
                    "images/buttrfly4.png",
                    height: 28,
                    width: 25,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 39, left: 60),
                width: 300,
                child: TextField(
                  controller: _emailTextController,
                  decoration: InputDecoration(
                    errorText: _emailError,
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Email Address',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 39,
                  left: 60,
                ),
                width: 300,
                child: TextField(
                  controller: _passwordTextController,
                  obscureText: true,
                  decoration: InputDecoration(
                    errorText: _passwordError,
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 0, left: 160),
                width: 300,
                child: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/forget_password_screen'),
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 60),
                width: 300,
                height: 53,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF918E8E),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () => performLogin(),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.isUser,
                child: const SizedBox(
                  height: 32,
                ),
              ),
              Visibility(
                visible: widget.isUser,
                child: const Center(
                  child: Text(
                    "Or",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(77, 52, 103, 0.73),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.isUser,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(top: 39, left: 60),
                    width: 300,
                    height: 53,
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF918E8E),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/google.png",
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        const Text(
                          'Login with Google',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 130,
              ),
              Visibility(
                visible: widget.isUser,
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Don\'t have an account?',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(text: ' '),
                        TextSpan(
                          recognizer: _tapGestureRecognizer,
                          text: 'Create Now!',
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void performLogin() {
    if (checkData()) login();
  }

  Future<bool> isDermatologist() async {
    return await FbFireStoreController()
        .doesDermatologistExist(_emailTextController.text);
  }

  Future<void> login() async {
    FirebaseResponse response = await FbAuthController().signIn(
        email: _emailTextController.text,
        password: _passwordTextController.text);
    if (response.success) {
      bool isDermatologist = await FbFireStoreController()
          .doesDermatologistExist(_emailTextController.text);
      if (widget.isUser == false) {
        if (isDermatologist) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                  user: FbAuthController().user,
                  isDermatologist: isDermatologist),
            ),
          );
        } else {
          FbAuthController().signOut();
          showSnackBar(
              context: context,
              message: "Sorry! You are not authorized to sign in as a doctor.",
              error: true);
        }
      } else {
        if (isDermatologist) {
          FbAuthController().signOut();
          showSnackBar(
              context: context,
              message: "Sorry! Your email is a doctor's email.",
              error: true);
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                  user: FbAuthController().user,
                  isDermatologist: isDermatologist),
            ),
          );
        }
      }
    } else {
      showSnackBar(
          context: context,
          message: response.message,
          error: !response.success);
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
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
      _passwordError = _passwordTextController.text.isEmpty
          ? 'Enter password, Please!'
          : null;
    });
  }
}
