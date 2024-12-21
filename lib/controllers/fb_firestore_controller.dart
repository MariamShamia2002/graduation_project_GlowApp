import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Glow/models/routine.dart';
import 'package:Glow/models/person.dart';

class FbFireStoreController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  static FbFireStoreController? _instance;

  FbFireStoreController._();

  factory FbFireStoreController() {
    return _instance ??= FbFireStoreController._();
  }

  //Create User Method
  Future<bool> createUser(Person person) {
    return _fireStore
        .collection('users')
        .doc(person.id)
        .set(person.toMap())
        .then((value) => true)
        .catchError((e) => false);
  }

  // Update User Method
  Future<bool> updateUser(Person person) {
    return _fireStore
        .collection('users')
        .doc(person.id)
        .update(person.toMap())
        .then((value) => true)
        .catchError((e) => false);
  }

  Stream<QuerySnapshot<Person>> readUsers() async* {
    yield* _fireStore
        .collection('users')
        .withConverter<Person>(
          fromFirestore: (snapshot, options) =>
              Person.fromMap(snapshot.data()!),
          toFirestore: (value, options) => value.toMap(),
        )
        .snapshots();
  }

  // Read method
  Stream<QuerySnapshot<routines>> readRoutine() async* {
    yield* _fireStore
        .collection('routines')
        .withConverter<routines>(
          fromFirestore: (snapshot, options) =>
              routines.fromMap(snapshot.data()!),
          toFirestore: (value, options) => value.toMap(),
        )
        .snapshots();
  }

  Future<bool> doesDermatologistExist(String email) async {
    try {
      return await _fireStore
          .collection('Dermatologists')
          .where('email', isEqualTo: email)
          .get()
          .then((value) => value.size > 0 ? true : false)
          .catchError((e) => false);
    } catch (e) {
      return Future(() => false);
    }
  }

  Future<bool> isDermatologist(String email) async =>
      await FbFireStoreController().doesDermatologistExist(email);
}
