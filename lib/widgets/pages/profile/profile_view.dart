import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:conference_app/services/storage_service.dart';
import 'package:conference_app/utils/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../services/auth_service.dart';
import '../../../services/database_service.dart';
import '../../../utils/consts.dart';
import 'profile_categories_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final String userId = FirebaseAuth.instance.currentUser!.uid;
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  List<dynamic> selectedDirection = [];
  String? downloadedImage;
  Uint8List? image;
  final db = Db();
  final StorageData storageData = StorageData();
  String email = '';

  void onData(QuerySnapshot<dynamic> event) {
    var data = event.docs;
    if (data.isNotEmpty)  {
      print(data);
      for (var user in data) {
        if (user.id == userId) {
          setState(() {
            nameController.text = user['name'];
            bioController.text = user['bio'];
            email = user['email'];
            selectedDirection = user['directions'];
            downloadedImage = user['imageLink'];
          });
          break;
        }
      }
    }
    else print('data empty');
  }

  Future<void> _selectImage() async {
    Uint8List? img = await ImagePickerUtil().pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        image = img;
      });
    }
  }

  Future<void> _submitEdit() async {
    print('Name: ${nameController.text}');
    print('Bio: ${bioController.text}');
    print('Direction: ${selectedDirection.toString()}');
    if (image != null) {
      print('image is not null');
      String res =
          await storageData.uploadImageToStorage('ptofileImage', image!);
      print('res got: $res');
      await db.updateUser({
        'name': nameController.text,
        'bio': bioController.text,
        'directions': selectedDirection,
        'imageLink': res
      });
    }
  }

  Future<void> _logout() async {
    final authService = AuthService();
    await authService.logoutUser(context);

  }

  @override
  void initState() {
    super.initState();

    late final Stream<QuerySnapshot> usersStream =
    FirebaseFirestore.instance.collection('users').snapshots();
    usersStream.listen((event) {onData(event); });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: double.infinity,
                  height: 160,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: Consts.mainGradient
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 100),
                      child: GestureDetector(
                        onTap: _selectImage,
                        child: Center(
                          child: (downloadedImage != null)
                              ? CircleAvatar(
                                  foregroundColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                  radius: 80,
                                  backgroundImage: ( image == null ? NetworkImage(downloadedImage!) : MemoryImage(image!) as ImageProvider<Object>?))
                              : const CircleAvatar(
                                  foregroundColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                  radius: 80,
                                  backgroundImage: NetworkImage(
                                      'https://i.pinimg.com/736x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg'),
                                ),
                        ),
                      ),
                    ),
                     Text(
                      email,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                      alignment: Alignment.topRight,
                      onPressed: _logout,
                      icon: const Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                        size: 35,
                      )),
                ),
              ],
            ),
            Container(
              color: Colors.grey[200],
              width: double.infinity,
              height: 1.5,
              margin:
                  const EdgeInsets.only(bottom: 16, left: 8, right: 8, top: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Name:'),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.edit),
                      border: InputBorder.none,
                      hintText: 'Enter your name',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text('Bio:'),
                  TextField(
                    controller: bioController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.edit),
                      border: InputBorder.none,
                      hintText: 'Enter your bio',
                    ),
                  ),
                  Container(
                    color: Colors.grey[200],
                    width: double.infinity,
                    height: 1.5,
                    margin: const EdgeInsets.only(bottom: 16),
                  ),
                  const Text('Direction: '),
                  const SizedBox(height: 8.0),
                  SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: ProfileCategoriesWidget(
                        list: selectedDirection,
                        callback: (List<dynamic> list) {
                          print(list);
                          setState(() {
                            selectedDirection = list;
                          });
                        },
                      )),
                  const SizedBox(height: 16.0),
                  Container(
                    color: Colors.grey[200],
                    width: double.infinity,
                    height: 1.5,
                    margin:
                    const EdgeInsets.only(bottom: 16, top: 8),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff6b00d7)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                      onPressed: _submitEdit,
                      child: const Text(
                        'Edit profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
