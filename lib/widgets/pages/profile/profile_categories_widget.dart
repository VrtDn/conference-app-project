import 'package:conference_app/widgets/pages/profile/profile_card.dart';
import 'package:flutter/material.dart';

class ProfileCategoriesWidget extends StatefulWidget {
  

  ProfileCategoriesWidget({super.key, required this.callback, required List<dynamic> this.list});
  List<dynamic> list;
  final Function(List<dynamic>) callback;
  @override
  State<ProfileCategoriesWidget> createState() =>
      _ProfileCategoriesWidgetState();
}

class _ProfileCategoriesWidgetState extends State<ProfileCategoriesWidget> {
  final List<String> directions = [
    "AI",
    "Cybersecurity",
    "Data Science",
    "DevOps",
    "Blockchain",
    "IoT",
    "ML",
    "AR",
    "Quantum Computing",
    "Software Engineering",
    "UX",
    "E-commerce",
  ];

  bool _setDirection(String s) {
    if (widget.list.contains(s)) {
      widget.list.remove(s);
      widget.callback(widget.list);
      return false;
    }
    if (widget.list.length >= 3) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("You can pick only 3"),
              content: Text("please remove unnecessary directions"),
            );
          });
      return false;
    }

    widget.list.add(s);
    widget.callback(widget.list);
    return true;

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCatCard(callback: _setDirection, text: directions[0], isPicked: widget.list.contains(directions[0]),),
            ProfileCatCard(callback: _setDirection, text: directions[1], isPicked:  widget.list.contains(directions[1]),),
            ProfileCatCard(callback: _setDirection, text: directions[2], isPicked:  widget.list.contains(directions[2]),),
            ProfileCatCard(callback: _setDirection, text: directions[3], isPicked:  widget.list.contains(directions[3]),),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCatCard(callback: _setDirection, text: directions[4], isPicked:  widget.list.contains(directions[4]),),
            ProfileCatCard(callback: _setDirection, text: directions[5], isPicked:  widget.list.contains(directions[5]),),
            ProfileCatCard(callback: _setDirection, text: directions[6], isPicked:  widget.list.contains(directions[6]),),
            ProfileCatCard(callback: _setDirection, text: directions[7], isPicked:  widget.list.contains(directions[7]),),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCatCard(callback: _setDirection, text: directions[8], isPicked:  widget.list.contains(directions[8]),),
            ProfileCatCard(callback: _setDirection, text: directions[9], isPicked:  widget.list.contains(directions[9]),),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ProfileCatCard(callback: _setDirection, text: directions[10], isPicked:  widget.list.contains(directions[10]),),
            ProfileCatCard(callback: _setDirection, text: directions[11], isPicked:  widget.list.contains(directions[11]),),
          ],
        ),
      ],
    );
  }
}
