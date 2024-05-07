import 'package:conference_app/services/message_service.dart';
import 'package:conference_app/widgets/pages/chat/message_builder.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatList extends StatefulWidget {
  const ChatList(
      {super.key, required this.receiverID, required this.imageLink});

  final String receiverID;
  final String? imageLink;

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final String defaultImageLink =
      "https://www.kindpng.com/picc/m/207-2074624_white-gray-circle-avatar-png-transparent-png.png";
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: chatService.getMessages(
            _firebaseAuth.currentUser!.uid, widget.receiverID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text("error"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading ..."));
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              print('hello, index now is $index');
              if(index < snapshot.data!.docs.length) {
                late Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                Map<String, dynamic>? nextData;
                if (index < snapshot.data!.docs.length-1) {
                  print('now next index will be ${index+1} and length is ${snapshot.data!.docs.length}, but limit is ${snapshot.data!.docs.length-1}');
                    nextData = snapshot.data!.docs[index+1].data() as Map<String, dynamic>;
                    print('done');
                }
                bool isReceiver = data['senderId'] != _firebaseAuth.currentUser!.uid;
                bool isNextReceiver = nextData != null ?  nextData['senderId'] !=  _firebaseAuth.currentUser!.uid : false;
                print("$isReceiver ${!isNextReceiver}");
                Widget profilePhoto = (isReceiver  && !isNextReceiver)
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(
                            (widget.imageLink == null)
                            ? defaultImageLink
                            : widget.imageLink!),
                      )
                    : const SizedBox(
                        width: 38,
                        height:
                            48);

                return MessageItemBuilder(
                    doc: snapshot.data!.docs[index],
                    id: _firebaseAuth.currentUser!.uid,
                    imageWidget: profilePhoto);
              }
              else {
                return SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
