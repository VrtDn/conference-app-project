import 'package:conference_app/widgets/pages/filters/categories_filter_widget.dart';
import 'package:conference_app/widgets/pages/events/event_list.dart';
import 'package:conference_app/widgets/pages/filters/main_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsView extends StatefulWidget {
  const EventsView({super.key});

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  final List<Map<String, String>> dataList = [
    {
      'label': 'Conference 1',
      'dec':
          'Description for Conference 1. It is a very long description that provides details about the conference.',
      'stage': 'Debate',
      'language': 'EN',
      'startTime': '09:00',
      'endTime': '10:30',
      'category': 'Technologies',
    },
    {
      'label': 'Conference 2',
      'dec':
          'Description for Conference 2. Another long description for the second conference.',
      'stage': 'Congress',
      'language': 'SP',
      'startTime': '11:00',
      'endTime': '12:30',
      'category': 'Media',
    },
    {
      'label': 'Conference 3',
      'dec':
          'Description for Conference 3. This conference focuses on marketing strategies.',
      'stage': 'Experience',
      'language': 'RU',
      'startTime': '14:00',
      'endTime': '15:30',
      'category': 'Marketing',
    },
    {
      'label': 'Conference 4',
      'dec':
          'Description for Conference 4. Exploring various aspects of business in this conference.',
      'stage': 'Debate',
      'language': 'EN',
      'startTime': '16:00',
      'endTime': '17:30',
      'category': 'Business',
    },
  ];
  List<Map<String, String>> mainList = [
    {
      'label': 'Conference 1',
      'dec':
      'Description for Conference 1. It is a very long description that provides details about the conference.',
      'stage': 'Debate',
      'language': 'EN',
      'startTime': '09:00',
      'endTime': '10:30',
      'category': 'Technologies',
    },
    {
      'label': 'Conference 2',
      'dec':
      'Description for Conference 2. Another long description for the second conference.',
      'stage': 'Congress',
      'language': 'SP',
      'startTime': '11:00',
      'endTime': '12:30',
      'category': 'Media',
    },
    {
      'label': 'Conference 3',
      'dec':
      'Description for Conference 3. This conference focuses on marketing strategies.',
      'stage': 'Experience',
      'language': 'RU',
      'startTime': '14:00',
      'endTime': '15:30',
      'category': 'Marketing',
    },
    {
      'label': 'Conference 4',
      'dec':
      'Description for Conference 4. Exploring various aspects of business in this conference.',
      'stage': 'Debate',
      'language': 'EN',
      'startTime': '16:00',
      'endTime': '17:30',
      'category': 'Business',
    },
  ];
  String? category;
  String? date;
  String? language;
  String? stage;

  List<Map<String, String>> filterByCriteria() {
    return dataList.where((item) {

      if (category != null && item['category'] != category) {
        return false;
      }

      if (language != null && item['language'] != language) {
        return false;
      }

      if (stage != null && item['stage'] != stage) {
        return false;
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat('MMMM').format(DateTime.now()),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          MainFilterWidget(
            dateCallback: (String? d) {
              setState(() {
                date = d;
                var list = filterByCriteria();
                mainList.clear();
                mainList.addAll(list);
              });
            },
            stageCallback: (String? s) {
              setState(() {
                stage = s;
                var list = filterByCriteria();
                mainList.clear();
                mainList.addAll(list);
              });
            },
            languageCallback: (String? l) {
              setState(() {
                language = l;
                var list = filterByCriteria();
                mainList.clear();
                mainList.addAll(list);
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          CategoriesWidget(
            callback: (String? c) {
              setState(() {
                category = c;
                var list = filterByCriteria();
                mainList.clear();
                mainList.addAll(list);
              });
            },
          ),
          SizedBox(
            height: 30,
          ),
          EventListWidget(
            dataList: mainList,
          ),
        ],
      ),
    );
  }
}
