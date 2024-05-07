import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String senderEmail;
  final String receiverId;
  final String senderId;
  final Timestamp timestamp;

  Message(
      {required this.message,
      required this.senderEmail,
      required this.receiverId,
      required this.senderId,
      required this.timestamp});

  Map<String, dynamic> get map{
    return {
      'senderId':senderId,
      'senderEmail':senderEmail,
      'receiverId':receiverId,
      'message':message,
      'timestamp':timestamp,
    };
  }
}
