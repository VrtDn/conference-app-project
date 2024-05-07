import 'package:conference_app/services/message_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/consts.dart';
import 'chat_list.dart';

class ChatView extends StatefulWidget {
  const ChatView(
      {super.key, required this.data, required this.returnToPeopleList});

  final Map<String, dynamic> data;
  final Function() returnToPeopleList;

  @override
  State<ChatView> createState() => _ChatViewState();
}

InputDecoration _buildInputDecoration(String label) {
  return InputDecoration(
      labelStyle: const TextStyle(color: Colors.grey),
      suffixStyle: const TextStyle(color: Colors.grey),
      fillColor: Colors.white,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      filled: true,
      labelText: label,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(35),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(35),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(35),
        borderSide: const BorderSide(width: 0.0, color: Colors.blue),
      ));
}

class _ChatViewState extends State<ChatView> {
  final ChatService chatService = ChatService();
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40),
              width: double.infinity,
              height: 135,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: Consts.mainGradient)),
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                          child: IconButton(
                              onPressed: () {
                                widget.returnToPeopleList();
                                print('iii');
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        widget.data['name'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w500),
                      )),
                    ],
                  ),
                ],
              ),
            ),
            ChatList(
              imageLink: widget.data['image'],
              receiverID: widget.data['receiverId'],
            ),
            Container(
              height: 62,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(color: Colors.blue),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: textEditingController,
                        // controller: _textController,
                        decoration:
                        _buildInputDecoration("enter your message..."),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Color(0xff6b00d7),
                        ),
                        child: IconButton(
                            onPressed: () async {
                              print('send message');
                              if (textEditingController.text.isNotEmpty) {
                                await chatService.sendMessage(widget.data['receiverId'], textEditingController.text);
                                textEditingController.clear();
                              }
                            },
                            icon: Icon(
                              Icons.send,
                              color: Colors.white,
                            )))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
