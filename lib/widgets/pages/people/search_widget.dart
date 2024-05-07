import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchWidget({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 20,bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        // color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.blue[700]!,
          width: 1.7
        )
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
          const Icon(Icons.search),
        ],
      ),
    );
  }
}

// Использование:
// SearchWidget(
//   onChanged: (value) {
//     print('Search query: $value');
//     // Вызов вашего callback здесь
//   },
// ),
