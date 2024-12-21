import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Glow/models/routine.dart';
import 'package:Glow/widgets/custom_button.dart';
import 'package:Glow/widgets/my_drawer.dart';
import 'package:Glow/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class RoutineScreen extends StatefulWidget {
  RoutineScreen(
      {required this.routine, required this.isDermatologist, super.key});

  @override
  State<RoutineScreen> createState() => RoutineScreenState();
  routines routine;
  bool isDermatologist;
}

class RoutineScreenState extends State<RoutineScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kTitleColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.routine.name,
          style: const TextStyle(
            color: kTitleColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      drawer: MyDrawer(
          isDermatologist: widget.isDermatologist, currentPage: 'Routine'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              widget.routine.urlImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            const SizedBox(height: 5),
            Text(
              "Description :",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.routine.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Row(children: [
              Text(
                "Skin Type :",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.routine.skinType,
                style: const TextStyle(fontSize: 16),
              ),
            ]),
            const SizedBox(height: 5),
            Row(children: [
              Text(
                "Skin Concerns :",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.routine.skinConcerns.join(', '),
                style: const TextStyle(fontSize: 16),
              ),
            ]),
            const SizedBox(height: 5),
            Text(
              "Steps :",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.routine.steps,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                if (!widget.isDermatologist)
                  GestureDetector(
                    onTap: () async {
                      await saveRoutineToUserProfile(widget.routine);
                    },
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 29, left: 8),
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
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Future<void> saveRoutineToUserProfile(routines routine) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add routine to user's profile
      await firestore.collection('users').doc(user.uid).update({
        'savedRoutines': FieldValue.arrayUnion([
          {
            'name': routine.name,
            'image': routine.urlImage,
            'description': routine.description,
          }
        ]),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Routine saved successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save routine: $e')),
        );
      }
    }
  }
}
