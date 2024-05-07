import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard(
      {super.key,
      required this.label,
      required this.dec,
      required this.stage,
      required this.language,
      required this.startTime,
      required this.endTime,
      required this.category});

  final String label;
  final String dec;
  final String stage;
  final String category;
  final String startTime;
  final String endTime;
  final String language;

  bool _isLabelTooLong() {
    if (label.length > 22) {
      return true;
    }
    return false;
  }

  Color _getColor() {
    switch (category) {
      case "Business":
        return Colors.purple;
      case "Marketing":
        return const Color(0xff6b00d7);
      case "Media":
        return Colors.blue;
      case "Technologies":
        return const Color(0xffd391fa);
      default:
        return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$startTime-",
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                Text(
                  endTime,
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                Text(
                  language,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: _getColor().withOpacity(0.2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          label,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 1, bottom: 1),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                            color: _getColor().withOpacity(0.5),
                            width: 2,
                          ),
                        ),
                        child: Text(category),
                      )
                    ],
                  ),
                  SizedBox(
                    width: _isLabelTooLong() ? 0 : 10,
                  ),
                  Text(
                    _isLabelTooLong() ? '' : dec,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: _isLabelTooLong() ? 0 : 10,
                  ),
                  Text(
                    "$stage stage",
                    style: TextStyle(color: Colors.blue[600]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
