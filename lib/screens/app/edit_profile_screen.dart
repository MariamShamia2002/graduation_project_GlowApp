// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:Glow/controllers/fb_auth_controller.dart';
// import 'package:Glow/controllers/fb_firestore_controller.dart';
// import 'package:Glow/helpers/helpers.dart';
// import 'package:Glow/models/person.dart';
// import 'package:Glow/widgets/custom_button.dart';
// import 'package:Glow/constants.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> with Helpers {
//   late TextEditingController _nameTextController;
//   late TextEditingController _ageTextController;

//   String nameText = '';
//   String skinType = '';
//   String ageText = '';
//   String? skinTypeText;
//   late TextEditingController _skinTypeController;
//   List<String> _skinType = ['Dry', 'Oily', 'Combination', 'Normal'];
//   List<String> concerns = ['Acne', 'Wrinkles', 'Dryness'];

//   // late TextEditingController _nameTextController;

//   @override
//   void initState() {
//     super.initState();
//     _getdata();
//     // _nameTextController.text = nameText;
//     _nameTextController = TextEditingController();
//     _ageTextController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _nameTextController.dispose();
//     _ageTextController.dispose();
//     super.dispose();
//   }

//   User user = FbAuthController().user;
//   @override
// Widget build(BuildContext context) {
//   _nameTextController.text = nameText;
//   _ageTextController.text = ageText;
//   return Scaffold(
//     appBar: AppBar(
//       centerTitle: true,
//       title: const Text(
//         'Edit Profile',
//         style: TextStyle(
//           color: Color(0xff415380),
//         ),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       automaticallyImplyLeading: false,
//       leading: IconButton(
//         icon: const Icon(
//           Icons.arrow_back_ios,
//           color: Color(0xff415380),
//         ),
//         onPressed: () => Navigator.pop(context),
//       ),
//       actions: [
//         IconButton(
//           onPressed: () {},
//           icon: const Icon(
//             Icons.edit,
//             color: Color(0xff415380),
//           ),
//         ),
//       ],
//     ),
//     body: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(
//             bottom: 5,
//             left: 45,
//           ),
//           child: Text(
//             "Name",
//             textAlign: TextAlign.left,
//             style: TextStyle(
//               color: Color(0xff415380),
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(
//             left: 30,
//             right: 30,
//             bottom: 15,
//           ),
//           child: TextField(
//             controller: _nameTextController,
//             style: const TextStyle(
//               color: Color(0XFF415380),
//             ),
//             decoration: InputDecoration(
//               // errorText: _emailError,
//               // hintText: _nameTextController.text,
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: const BorderSide(
//                   color: Colors.grey,
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: const BorderSide(
//                   color: Colors.red,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: const BorderSide(
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.only(
//             bottom: 5,
//             left: 45,
//           ),
//           child: Text(
//             "Age",
//             textAlign: TextAlign.left,
//             style: TextStyle(
//               color: Color(0xff415380),
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
//           child: TextField(
//             controller: _ageTextController,
//             style: const TextStyle(
//               color: Color(0XFF415380),
//             ),
//             decoration: InputDecoration(
//               // errorText: _emailError,
//               // hintText: 'Height',
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: const BorderSide(
//                   color: Colors.grey,
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: const BorderSide(
//                   color: Colors.red,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: const BorderSide(
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.only(
//             bottom: 5,
//             left: 45,
//           ),
//           child: Text(
//             "Weight",
//             textAlign: TextAlign.left,
//             style: TextStyle(
//               color: Color(0xff415380),
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
//           child: TextField(
//             // controller:
//             style: const TextStyle(
//               color: Color(0XFF415380),
//             ),
//             decoration: InputDecoration(
//               // errorText: _emailError,
//               // hintText: '_nameTextController.text!',
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: const BorderSide(
//                   color: Colors.grey,
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: const BorderSide(
//                   color: Colors.red,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: const BorderSide(
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.only(
//             bottom: 5,
//             left: 45,
//           ),
//           child: Text(
//             "Height",
//             textAlign: TextAlign.left,
//             style: TextStyle(
//               color: Color(0xff415380),
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
//           child: TextField(
//             // controller: _heightTextController,
//             style: const TextStyle(
//               color: Color(0XFF415380),
//             ),
//             decoration: InputDecoration(
//               // errorText: _emailError,
//               // hintText: 'Height',
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: const BorderSide(
//                   color: Colors.grey,
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: const BorderSide(
//                   color: Colors.red,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: const BorderSide(
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         GestureDetector(
//           onTap: () async {
//             await performUpdate();
//           },
//           child: Center(
//             child: Container(
//               margin: const EdgeInsets.only(top: 29, left: 0),
//               width: 290,
//               height: 53,
//               padding: const EdgeInsets.only(
//                 left: 15,
//               ),
//               decoration: BoxDecoration(
//                 color: const Color(0xff415380),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const Center(
//                 child: Text(
//                   'Update',
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Glow/controllers/fb_auth_controller.dart';
import 'package:Glow/controllers/fb_firestore_controller.dart';
import 'package:Glow/helpers/helpers.dart';
import 'package:Glow/models/person.dart';
import 'package:Glow/models/routine.dart';
import 'package:Glow/widgets/custom_button.dart';
import 'package:Glow/constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with Helpers {
  late TextEditingController _nameTextController;
  late TextEditingController _ageTextController;

  String nameText = '';
  String ageText = '';
  String? selectedSkinType;
  List<String> skinTypes = [
    'Normal',
    'Dry',
    'Sensitive',
    'Combination',
    'Oily'
  ];

  List<String> allConcerns = [
    'Acne',
    'Sensitivity',
    'Wrinkles',
    'Dark Spots',
    'Dryness'
  ];
  List<String> selectedConcerns = [];

  List<Map<String, dynamic>> skincareRoutines = [];

  @override
  void initState() {
    super.initState();
    _getSkincareRoutines();
    _getData();
    _nameTextController = TextEditingController();
    _ageTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _ageTextController.dispose();
    super.dispose();
  }

  User user = FbAuthController().user;

  @override
  Widget build(BuildContext context) {
    _nameTextController.text = nameText;
    _ageTextController.text = ageText;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'images/buttrfly.jpg',
              width: 20,
              height: 20,
              alignment: Alignment.bottomCenter,
            ),
            const Text(
              'Edit Profile',
              style: TextStyle(color: kTitleColor),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kTitleColor),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'images/background.png', // Add the path to your image asset
              fit: BoxFit.cover,
            ),
          ),
          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kToolbarHeight + 10), // Space for AppBar
                _buildTextField("Name", _nameTextController),
                _buildTextField("Age", _ageTextController),
                _buildDropdown("Skin Type", skinTypes, selectedSkinType,
                    (value) {
                  setState(() => selectedSkinType = value);
                }),
                _buildConcernsSection(),
                _buildSkincareRoutineSection(),

                //  Center(
                //     child: CustomButton(
                //       child: const Text('Save',
                //           style: TextStyle(color: Colors.white, fontSize: 18)),

                //       onTap: () async {
                //         // await performUpdate();
                //         const Text('update',
                //             style: TextStyle(
                //                 color: Color.fromARGB(255, 186, 195, 17),
                //                 fontSize: 18));
                //       },
                //     ),
                //   ),
                GestureDetector(
                  onTap: () async {
                    await performUpdate();
                  },
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 29, left: 0),
                      width: 150,
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
                          'Save',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build Input TextFields
  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          readOnly: false,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kPrimaryColor)),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  // Build Dropdown for Skin Type
  Widget _buildDropdown(String label, List<String> items, String? value,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildConcernsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Concerns",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Wrap(
          spacing: 10,
          children: allConcerns.map((concern) {
            // Check if concern is selected
            bool isSelected = selectedConcerns.contains(concern);
            return ChoiceChip(
              label: Text(
                concern,
                style: TextStyle(
                  color: isSelected ? Colors.white : kTitleColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              selected: isSelected,
              selectedColor: const Color.fromARGB(255, 140, 126, 161),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    if (!selectedConcerns.contains(concern)) {
                      selectedConcerns
                          .add(concern); // Add if not already present
                    }
                  } else {
                    selectedConcerns.remove(concern); // Remove if deselected
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  // Widget _buildSkincareRoutineSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           const Text(
  //             "Skincare Routine",
  //             style: TextStyle(
  //               color: kTitleColor,
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           IconButton(
  //             icon: const Icon(Icons.save, color: kTitleColor, size: 20),
  //             onPressed: () {
  //               // Add your save functionality here
  //             },
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 2), // Smaller space between text and cards
  //       skincareRoutines.isEmpty
  //           ? const Center(
  //               child: Text(
  //                 'No routines saved yet.',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   color: kTitleColor,
  //                 ),
  //               ),
  //             )
  //           : ListView.builder(
  //               shrinkWrap: true,
  //               physics: const NeverScrollableScrollPhysics(),
  //               itemCount: skincareRoutines.length,
  //               itemBuilder: (context, index) {
  //                 final routine = skincareRoutines[index];
  //                 return Card(
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(15),
  //                   ),
  //                   elevation: 3,
  //                   child: ListTile(
  //                     leading: Image.network(
  //                       routine['image'],
  //                       width: 50,
  //                       height: 50,
  //                       fit: BoxFit.cover,
  //                     ),
  //                     title: Text(
  //                       routine['name'],
  //                       style: const TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     subtitle: Text(
  //                       routine['description'] ?? '',
  //                       style: const TextStyle(fontSize: 12),
  //                     ),
  //                     trailing: IconButton(
  //                       icon: const Icon(Icons.delete, color: Colors.red),
  //                       onPressed: () {
  //                         setState(() {
  //                           skincareRoutines.removeAt(index);
  //                         });
  //                       },
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //     ],
  //   );
  // }
  Widget _buildSkincareRoutineSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Skincare Routine",
              style: TextStyle(
                color: kTitleColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.save, color: kTitleColor, size: 20),
              onPressed: () {
                // Add your save functionality here
              },
            ),
          ],
        ),
        const SizedBox(height: 0), // Smaller space between text and cards
        skincareRoutines.isEmpty
            ? const Center(
                child: Text(
                  'No routines saved yet.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kTitleColor,
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: skincareRoutines.length,
                itemBuilder: (context, index) {
                  final routine = skincareRoutines[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: Image.network(
                        routine['image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        routine['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        routine['description'] ?? '',
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            skincareRoutines.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
      ],
    );
  }

  // Fetch user data
  void _getData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .listen((userData) {
      setState(() {
        nameText = userData.data()?['name'] ?? '';
        ageText = userData.data()?['age'].toString() ?? '';
        selectedSkinType = userData.data()?['skinType'];
        selectedConcerns =
            List<String>.from(userData.data()?['skinConcerns'] ?? []);
      });
    });
  }

  // Perform update
  Future<void> performUpdate() async {
    Person person = Person();
    person.id = user.uid;
    person.email = user.email!;
    person.name = _nameTextController.text;
    person.age = int.parse(_ageTextController.text);
    person.skinType = selectedSkinType ?? '';
    person.skinConcerns = selectedConcerns;
    person.savedRoutines = skincareRoutines;
    bool success = await FbFireStoreController().updateUser(person);
    if (mounted) {
      String message = success
          ? "Profile updated successfully"
          : "Update failed. Please try again!";
      showSnackBar(context: context, message: message, error: !success);
      if (success) Navigator.pop(context);
    }
  }

  void _getSkincareRoutines() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .listen((userData) {
      setState(() {
        skincareRoutines = List<Map<String, dynamic>>.from(
          userData.data()?['savedRoutines'] ?? [],
        );
      });
    });
  }
}
