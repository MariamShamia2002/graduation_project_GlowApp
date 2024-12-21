import 'package:flutter/material.dart';
import 'package:Glow/controllers/fb_auth_controller.dart';
import 'package:Glow/controllers/fb_firestore_controller.dart';
import 'package:Glow/helpers/helpers.dart';
import 'package:Glow/models/firebase_response.dart';
import 'package:Glow/models/person.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  String? _emailError;
  String? _passwordError;
  String? _nameError;
  // String? _concernError;
  String? _ageError;
  String? _skinTypeError;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _nameTextController;
  String? _selectedSkinType;
  late TextEditingController _ageTextController;
  final List<String> _skinConcerns = [
    'Wrinkles',
    'Sensitivity',
    'Acne',
    'Dryness',
    'Dark Spots',
  ];
  final Map<String, bool> _selectedConcerns = {
    'Wrinkles': false,
    'Sensitivity': false,
    'Acne': false,
    'Dryness': false,
    'Dark Spots': false,
  };

  @override
  void initState() {
    // TODO: implement initState
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _nameTextController = TextEditingController();
    _ageTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _nameTextController.dispose();
    _ageTextController.dispose();
    // _selectedConcerns.clear();
    // _selectedSkinType=null;
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
        backgroundColor:
            Colors.transparent, // Make Scaffold background transparent
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 60,
                      top: 20,
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 25,
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
                margin: const EdgeInsets.only(top: 20, left: 60),
                width: 300,
                child: TextField(
                  keyboardType: TextInputType.name,
                  controller: _nameTextController,
                  decoration: InputDecoration(
                    errorText: _nameError,
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Full name',
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
                margin: const EdgeInsets.only(top: 20, left: 60),
                width: 300,
                child: TextField(
                  controller: _ageTextController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.date_range),
                    hintText: 'Age',
                    errorText: _ageError,
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

              // Skin type dropdown
              Container(
                margin: const EdgeInsets.only(top: 20, left: 60),
                width: 300,
                child: DropdownButtonFormField<String>(
                  value: _selectedSkinType, // The currently selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSkinType = newValue; // Update the selected value
                    });
                  },
                  items: <String>[
                    'Dry',
                    'Oily',
                    'Combination',
                    'Normal',
                    'Sensitive'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    errorText: _skinTypeError,
                    prefixIcon: const Icon(Icons.face),
                    hintText: 'Skin Type',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 60),
                width: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Primary Skin Concerns',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 3.0, // Horizontal spacing between checkboxes
                      runSpacing: 1.0, // Vertical spacing between rows
                      children: _skinConcerns.map((concern) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: _selectedConcerns[concern],
                              onChanged: (bool? value) {
                                setState(() {
                                  _selectedConcerns[concern] = value ?? false;
                                });
                              },
                            ),
                            Text(
                              concern,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 20, left: 60),
                width: 300,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
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
                margin: const EdgeInsets.only(top: 20, left: 60),
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
                margin: const EdgeInsets.only(top: 39, left: 60),
                width: 300,
                height: 53,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF918E8E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  onPressed: () async {
                    performRegister();
                  },
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Row(
              //   children: [
              //     Text('Do you have an account?'),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> performRegister() async {
    if (checkData()) await register();
  }

  // Future<void> register() async {
  // FirebaseResponse response = await FbAuthController().createAccount(
  //       email: _emailTextController.text,
  //       password: _passwordTextController.text,
  //       name: _nameTextController.text);
  //   Person person = Person();
  //   person.id = response.credential!.user!.uid;
  //   person.name = _nameTextController.text;
  //   person.email = _emailTextController.text;
  //   person.age = int.parse(_ageTextController.text);
  //   person.skinType = _selectedSkinType.toString();
  //   person.skinConcerns =
  //       _selectedConcerns.keys.where((key) => _selectedConcerns[key]!).toList();
  //   Future<bool> fireStoreResult = FbFireStoreController()
  //       .createUser(person)
  //       .then((value) => true)
  //       .catchError((e) => false);
  //   String fireStoreResponse = fireStoreResult.toString();
  //   print("hiii");
  //   if (response.credential != null && fireStoreResponse == 'true') {
  //     Navigator.pop(context);
  //     clearData();
  //     showSnackBar(context: context, message: "User created successfully");
  //   } else {
  //     showSnackBar(
  //         context: context,
  //         message: response.message,
  //         error: !response.success);
  //   }
  // }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _nameTextController.text.isNotEmpty &&
        _ageTextController.text.isNotEmpty &&
        _selectedSkinType != null &&
        _selectedConcerns.containsValue(true)) {
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
      _nameError =
          _nameTextController.text.isEmpty ? 'Enter username, Please!' : null;
      _ageError =
          _ageTextController.text.isEmpty ? 'Enter your age, please!' : null;
      // _concernError = _selectedConcerns.containsValue(false)
      //     ? 'Please select at least one skin concern!'
      //     : null;
      _skinTypeError =
          _selectedSkinType == null ? 'Please select a skin type!' : null;
    });
  }

  Future<void> register() async {
    // Create the user in Firebase Authentication
    FirebaseResponse response = await FbAuthController().createAccount(
      email: _emailTextController.text,
      password: _passwordTextController.text,
      name: _nameTextController.text,
    );

    if (response.credential != null) {
      // Prepare the user data
      Person person = Person();
      person.id = response.credential!.user!.uid;
      person.name = _nameTextController.text;
      person.email = _emailTextController.text;
      person.age = int.parse(_ageTextController.text);
      person.skinType = _selectedSkinType.toString();
      person.skinConcerns = _selectedConcerns.keys
          .where((key) => _selectedConcerns[key]!)
          .toList();
      print(person);
      // Save the user data to Firestore
      bool fireStoreResult = await FbFireStoreController().createUser(person);

      if (fireStoreResult) {
        Navigator.pop(context);
        clearData();
        showSnackBar(context: context, message: "User created successfully");
      } else {
        showSnackBar(
            context: context, message: "Failed to save user data", error: true);
      }
    } else {
      showSnackBar(
        context: context,
        message: response.message,
        error: !response.success,
      );
    }
  }

  void clearData() {
    _emailTextController.text = '';
    _nameTextController.text = '';
    _passwordTextController.text = '';
    _ageTextController.text = '';
    _selectedSkinType = null;
    _selectedConcerns.forEach((key, value) {
      _selectedConcerns[key] = false;
    });
  }
}
