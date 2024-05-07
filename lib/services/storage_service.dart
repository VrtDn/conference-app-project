
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class StorageData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
//Create a reference to the location you want to upload to in firebase
    final reference = _firebaseStorage.ref().child("images/${_firebaseAuth.currentUser!.uid}/");

//Upload the file to firebase
    final uploadTask = reference.putData(file);
    print('start');
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => print('complited'));
    print('end');
// Waits till the file is uploaded then stores the download url
    return await taskSnapshot.ref.getDownloadURL();
  }

}
