import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MainFilterWidget extends StatefulWidget {
  const MainFilterWidget({super.key, required this.dateCallback, required this.stageCallback, required this.languageCallback});

  final Function(String?) dateCallback;
  final Function(String?) stageCallback;
  final Function(String?) languageCallback;
  @override
  State<MainFilterWidget> createState() => _MainFilterWidgetState();
}

class _MainFilterWidgetState extends State<MainFilterWidget> {
  var now = DateTime(2024, 3, 8);
  String? selectedDate;
  String? selectedLanguage;
  String? selectedStage;

  @override
  //Text((selectedData == null) ? 'date' : selectedData!)
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            PopupMenuButton<String>(
              child: Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          text: (selectedDate == null)
                              ? 'Day 1'
                              : (selectedDate!.split(RegExp(" [FTWSM]")).first),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,

                          ),
                        ),
                        TextSpan(
                          text: (selectedDate == null)
                              ? ''
                              : (selectedDate!.split(RegExp("Day [0-9]"))[1]),
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    )),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
              onSelected: (String value) {
                setState(() {
                  selectedDate = value;
                });
                widget.dateCallback(selectedDate);
                print('Selected filter: $value');
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'Day 1 ${DateFormat("EEEE, MMM dd").format(now)}',
                  child:
                      Text('Day 1 ${DateFormat("EEEE, MMM dd").format(now)}'),
                ),
                PopupMenuItem<String>(
                  value:
                      'Day 2 ${DateFormat("EEEE, MMM dd").format(now.add(Duration(days: 1)))}',
                  child: Text(
                      'Day 2 ${DateFormat("EEEE, MMM dd").format(now.add(Duration(days: 1)))}'),
                ),
                PopupMenuItem<String>(
                  value:
                      'Day 3 ${DateFormat("EEEE, MMM dd").format(now.add(Duration(days: 2)))}',
                  child: Text(
                      'Day 3 ${DateFormat("EEEE, MMM dd").format(now.add(Duration(days: 2)))}'),
                ),
              ],
            ),
            PopupMenuButton<String>(
              child: Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Stage ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: (selectedStage == null)
                                  ? ''
                                  : selectedStage,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        )),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
              onSelected: (String value) {
                setState(() {
                  selectedStage = value;
                });
                if (selectedStage == ' ') {
                  widget.stageCallback(null);
                }
                else {
                  widget.stageCallback(selectedStage);
                }
                print('Selected filter: $value');
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Congress',
                  child:
                  Text('Congress'),
                ),
                const PopupMenuItem<String>(
                  value: 'Experience',
                  child:
                  Text('Experience'),
                ),
                const PopupMenuItem<String>(
                  value: 'Debate',
                  child:
                  Text('Experience'),
                ),
                const PopupMenuItem<String>(
                  value: ' ',
                  child:
                  Text('none'),
                ),
              ],
            ),
            PopupMenuButton<String>(
              child: Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Language ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: (selectedLanguage == null)
                                  ? ''
                                  : selectedLanguage,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        )),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
              onSelected: (String value) {
                setState(() {
                  selectedLanguage = value;
                });
                if (selectedLanguage == ' ') {
                  widget.languageCallback(null);
                }
                else {
                  widget.languageCallback(selectedLanguage);
                }
                print('Selected filter: $value');
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'EN',
                  child:
                  Text('English'),
                ),
                const PopupMenuItem<String>(
                  value: 'SP',
                  child:
                  Text('Spanish'),
                ),
                const PopupMenuItem<String>(
                  value: 'RU',
                  child:
                  Text('Russian'),
                ),
                const PopupMenuItem<String>(
                  value: ' ',
                  child:
                  Text('none'),
                ),
              ],
            ),
          ],
        ));
  }
}
