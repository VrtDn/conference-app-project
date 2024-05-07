import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Db {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(data) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await users
        .doc(userId)
        .set(data)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUser(data) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await users
        .doc(userId)
        .update(data)
        .then((value) => print("User updated"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Stream<DocumentSnapshot<Object?>> getUserData () {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return users
        .doc(userId)
        .snapshots();
  }
}