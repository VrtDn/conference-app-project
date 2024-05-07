import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DirectionRow extends StatelessWidget {
  const DirectionRow({super.key, required this.directions});

  final List<dynamic> directions;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: directions.map((dynamic str) =>
          AnimatedContainer(
            padding: const EdgeInsets.only(left: 6, right: 6, top: 4, bottom: 4),
            margin: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1.5,
                    color: Colors.grey),
                borderRadius: BorderRadius.circular(15)),
            duration: const Duration(milliseconds: 300),
            child: Text(
              str,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10
              ),
            ),
          )
      )
          .toList(),
    );
  }
}
