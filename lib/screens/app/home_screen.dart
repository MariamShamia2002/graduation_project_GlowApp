import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Glow/controllers/fb_auth_controller.dart';
import 'package:Glow/controllers/fb_firestore_controller.dart';
import 'package:Glow/models/routine.dart';
import 'package:Glow/screens/app/profile_screen.dart';
import 'package:Glow/screens/app/routine_screen.dart';
import 'package:Glow/constants.dart';
import 'package:Glow/widgets/my_drawer.dart';
import 'package:Glow/widgets/custom_button.dart';
import 'package:Glow/widgets/routine_item.dart';
import 'chats_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({required this.user, required this.isDermatologist, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  User user;
  bool isDermatologist;
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _searchTextController;
  final List<String> skinType = <String>[
    'Normal',
    'Combination',
    'Oily',
    'Dry',
    'Sensitive',
    'All',
  ];
  bool wrinkles = false;
  bool sensitivity = false;
  bool acne = false;
  bool dryness = false;
  bool darkSpot = false;
  var selectedType;
  bool _isFilterDrawerOpen = false;
  User user = FbAuthController().user;
  List<routines> filteredRoutines = [];
  List<routines> allRoutines = [];

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  void filterRoutines() {
    List<routines> tempRoutines = allRoutines;
    List<String> concerns = [];

    if (wrinkles) concerns.add("Wrinkles");
    if (sensitivity) concerns.add("Sensitivity");
    if (acne) concerns.add("Acne");
    if (dryness) concerns.add("Dryness");
    if (darkSpot) concerns.add("Dark Spots");

    if (selectedType != null && selectedType != 'All') {
      tempRoutines = tempRoutines
          .where((routine) =>
              routine.skinType.toLowerCase() == selectedType.toLowerCase())
          .toList();
    }

    if (concerns.isNotEmpty) {
      tempRoutines = tempRoutines
          .where((routine) => concerns
              .every((concern) => routine.skinConcerns.contains(concern)))
          .toList();
    }

    setState(() {
      filteredRoutines = tempRoutines.isEmpty ? [] : tempRoutines;
    });
  }

  void clearFilters() {
    setState(() {
      selectedType = null;
      wrinkles = false;
      sensitivity = false;
      acne = false;
      dryness = false;
      darkSpot = false;
      filteredRoutines = allRoutines;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(
            color: kTitleColor,
            fontSize: 24,
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
              Icons.notifications_none,
              color: kTitleColor,
            ),
          ),
        ],
      ),
      drawer: MyDrawer(
          isDermatologist: widget.isDermatologist, currentPage: '/home_screen'),
      body: Stack(
        children: [
          Image.asset(
            'images/background.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'filter',
                    style: TextStyle(
                      fontSize: 18,
                      color: kTitleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isFilterDrawerOpen = true;
                      });
                    },
                    icon: const Icon(
                      Icons.filter_alt_outlined,
                      color: kBackgroundColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot<routines>>(
                  stream: FbFireStoreController().readRoutine(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      );
                    }

                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      // Get all routines from Firestore
                      allRoutines =
                          snapshot.data!.docs.map((doc) => doc.data()).toList();

                      // Apply the filter logic (assuming filterRoutines has been executed)
                      filteredRoutines = filteredRoutines.isNotEmpty
                          ? filteredRoutines
                          : allRoutines;

                      // Show either the filtered routines or the "no routines" message
                      return ListView.builder(
                        itemCount: filteredRoutines.isEmpty
                            ? 1
                            : filteredRoutines.length,
                        itemBuilder: (context, index) {
                          if (filteredRoutines.isEmpty) {
                            return const Center(
                              child: Text(
                                'No routines matched the filter criteria.',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          }
                          return RoutineItem(
                            routine: filteredRoutines[index],
                            isDermatologist: widget.isDermatologist,
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'NO DATA',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 45,
                          ),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
          if (_isFilterDrawerOpen)
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 250,
                height: double.infinity,
                color: Colors.grey.shade200,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'filter',
                            style: TextStyle(
                              fontSize: 18,
                              color: kTitleColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isFilterDrawerOpen = false;
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                              color: kBackgroundColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        items: skinType
                            .map(
                              (value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    color: kTitleColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        decoration: InputDecoration(
                          hintText: 'Skin Type',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: kTitleColor),
                          ),
                        ),
                        onChanged: (selected) {
                          setState(() => selectedType = selected);
                        },
                        value: selectedType,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Skin Concerns:'),
                          CheckboxListTile(
                            value: wrinkles,
                            onChanged: (value) {
                              setState(() => wrinkles = value!);
                            },
                            title: const Text('Wrinkles'),
                          ),
                          CheckboxListTile(
                            value: sensitivity,
                            onChanged: (value) {
                              setState(() => sensitivity = value!);
                            },
                            title: const Text('Sensitivity'),
                          ),
                          CheckboxListTile(
                            value: acne,
                            onChanged: (value) {
                              setState(() => acne = value!);
                            },
                            title: const Text('Acne'),
                          ),
                          CheckboxListTile(
                            value: dryness,
                            onChanged: (value) {
                              setState(() => dryness = value!);
                            },
                            title: const Text('Dryness'),
                          ),
                          CheckboxListTile(
                            value: darkSpot,
                            onChanged: (value) {
                              setState(() => darkSpot = value!);
                            },
                            title: const Text('Dark Spots'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () async {
                          filterRoutines();
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
                                'Filter',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          clearFilters();
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
                                'Clear',
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
              ),
            ),
        ],
      ),
    );
  }
}
