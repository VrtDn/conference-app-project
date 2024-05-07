import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/consts.dart';

class ProfileCatCard extends StatefulWidget {
    ProfileCatCard(
      {super.key, required this.callback, required this.text, required this.isPicked});

  final bool Function(String) callback;
  final String text;

  bool isPicked;
  @override
  State<ProfileCatCard> createState() => _ProfileCatCardState();
}

class _ProfileCatCardState extends State<ProfileCatCard> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool response = widget.callback(widget.text);
        print('$response, ${widget.text}');
        setState(() {
          widget.isPicked = response;
        });
      },
      child: AnimatedContainer(
        padding: const EdgeInsets.only(left: 6, right: 6, top: 4, bottom: 4),
        margin: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
        decoration: BoxDecoration(
            gradient: widget.isPicked ? const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: Consts.mainGradient,
            ) : null,
            border: Border.all(
              width: 1.5,
                color: widget.isPicked ? Colors.transparent : Colors.blue[700]!),
            borderRadius: BorderRadius.circular(15)),
        duration: const Duration(milliseconds: 300),
        child: Text(
          widget.text,
          style: TextStyle(
              color: widget.isPicked ? Colors.white.withAlpha(450) : Colors.blue[700]!,
              fontSize: 18
          ),
        ),
      ),
    );
  }
}
