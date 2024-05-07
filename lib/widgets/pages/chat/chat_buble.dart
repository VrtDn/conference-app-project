import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/consts.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key, required this.message, required this.isSenderMessage});

  final String message;
  final bool isSenderMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isSenderMessage ? Alignment.centerLeft : Alignment.centerRight,
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.only(
          left: isSenderMessage ? 0 : 10, right: isSenderMessage ? 10 : 0),
      decoration: BoxDecoration(
        color: isSenderMessage ? null : Colors.white,
          boxShadow: isSenderMessage
              ? null
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(10),
            topLeft: const Radius.circular(10),
            bottomLeft: isSenderMessage
                ? const Radius.circular(10)
                : const Radius.circular(0),
            bottomRight: isSenderMessage
                ? const Radius.circular(0)
                : const Radius.circular(10),
          ),
          gradient: isSenderMessage ? const LinearGradient(colors: Consts.mainGradient) : null ),
      child: Text(
        message,
        maxLines: 100,
        style: TextStyle(color: isSenderMessage ? Colors.white :  Colors.black),
      ),
    );
  }
}
