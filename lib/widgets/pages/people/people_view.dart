import 'package:conference_app/widgets/pages/filters/categories_filter_widget.dart';
import 'package:conference_app/widgets/pages/people/search_widget.dart';
import 'package:flutter/material.dart';

import 'people_list.dart';

class PeopleView extends StatefulWidget {
  const PeopleView({super.key, required this.callback});

  final Function(Map<String, dynamic>) callback;

  @override
  State<PeopleView> createState() => _PeopleViewState();
}

class _PeopleViewState extends State<PeopleView> {
  String? searchResults;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'People',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        toolbarHeight: 45,
      ),
      body: Column(
        children: [
          SearchWidget(
            onChanged: (String value) {
              print(value);
              setState(() {
                searchResults = value;
              });
            },
          ),
          PeopleList(
            callback: (Map<String, dynamic> data) {
              widget.callback(data);
            },
             searchResults: searchResults,
          )
        ],
      ),
    );
  }
}
