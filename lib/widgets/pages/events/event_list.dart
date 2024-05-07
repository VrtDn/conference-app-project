import 'dart:ui';

import 'package:conference_app/widgets/pages/events/event_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class EventListWidget extends StatefulWidget {
  const EventListWidget({super.key, required this.dataList});

  final List<Map<String, String>> dataList;

  @override
  State<EventListWidget> createState() => _EventListWidgetState();
}

class _EventListWidgetState extends State<EventListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.dataList.length,
        itemBuilder: (context, index) {
          return EventCard(
              label: widget.dataList[index]['label']!,
              dec: widget.dataList[index]['dec']!,
              stage: widget.dataList[index]['stage']!,
              language: widget.dataList[index]['language']!,
              startTime: widget.dataList[index]['startTime']!,
              endTime: widget.dataList[index]['endTime']!,
              category: widget.dataList[index]['category']!);
        },
      ),
    );
  }
}
