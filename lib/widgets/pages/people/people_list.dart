import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'directions_row.dart';

class PeopleList extends StatefulWidget {
  PeopleList({super.key, required this.callback, required this.searchResults});
  final Function(Map<String, dynamic>) callback;
  String? searchResults;
  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  late final String userId = FirebaseAuth.instance.currentUser!.uid;
  late final Stream<QuerySnapshot> usersStream =
    FirebaseFirestore.instance.collection('users').snapshots();
  late final Future<DocumentSnapshot> userDocFuture =
      FirebaseFirestore.instance.collection('users').doc(userId).get();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userDocFuture,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
        if (userSnapshot.hasError) {
          return Text('Something went wrong');
        }

        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        var userDoc = userSnapshot.data!;

        return  StreamBuilder<QuerySnapshot>(
          stream: usersStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            print("data");
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
            }

            var data = snapshot.data!.docs;
            if (data.isEmpty)  {
              print('data empty');
              return const SizedBox();
            }
            if (widget.searchResults != null && widget.searchResults!.isNotEmpty) {
              print(widget.searchResults);
              var filteredData = data
                  .where((map) => map['name'].toLowerCase().startsWith(widget.searchResults!) as bool)
                  .toList();
              data = filteredData;

            } else {
              print("searchResults is empty");
              
            }
            return ListView.separated(
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (data[index].id == userId) {
                  return const SizedBox();
                }
                List<dynamic> directions = data[index]['directions'];
                return ListTile(
                  trailing: Icon(Icons.chat_outlined, color: Colors.blue[700],),
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        data[index]['imageLink'],
                    ),
                  ),
                  title: Text(data[index]['name']),
                  onTap: (){
                    widget.callback(
                      {
                        'image': data[index]['imageLink'],
                        'name': data[index]['name'],
                        'email': data[index]['email'],
                        'receiverId' : data[index].id
                      }
                    );
                  },
                  subtitle: DirectionRow(directions: directions,)
                );
              }, separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.grey[100],
                height: 2,
              );
            },
            );
          },
        );
      },
    );
  }
}
