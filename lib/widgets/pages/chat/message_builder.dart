
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_buble.dart';

class MessageItemBuilder extends StatelessWidget {
  MessageItemBuilder({super.key, required this.doc, required this.id,required this.imageWidget});

  final DocumentSnapshot doc;
  final String id;
  final Widget imageWidget;

  late Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

  late var aligment = (data['senderId'] == id)
      ? Alignment.centerRight
      : Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only( left: 16),
      alignment: aligment,
      child: Column(
        crossAxisAlignment: (data['senderId'] == id)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: (data['senderId'] == id) ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              imageWidget,
              ChatBubble(message: data['message'], isSenderMessage: (data['senderId'] == id)),
            ],
          ),
          const SizedBox(height: 3,),
        ],
      ),
    );
  }
}