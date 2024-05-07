import 'package:conference_app/utils/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key, required this.callback});
  final Function(String?) callback;
  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  var selectedCategoryIndex = 0;
  String? _getCategory() {
    switch (selectedCategoryIndex) {
      case 1: return "Business";
      case 2: return "Marketing";
      case 3: return "Media";
      case 4: return "Technologies";
      default: return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              if (selectedCategoryIndex == 1){
                setState(() {
                  selectedCategoryIndex = 0;
                });
                widget.callback(null);
              }
              else {
                setState(() {
                  selectedCategoryIndex = 1;
                });
                widget.callback(_getCategory());
              }
            },
            child: AnimatedContainer(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  gradient: (selectedCategoryIndex == 1) ? const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: Consts.mainGradient,
                  ) : null,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              duration: const Duration(milliseconds: 100),
              child: Text(
                "Business",
                style: TextStyle(
                    color: (selectedCategoryIndex == 1)
                        ? Colors.white.withAlpha(450)
                        : Colors.blue[600],
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (selectedCategoryIndex == 2){
                setState(() {
                  selectedCategoryIndex = 0;
                });
                widget.callback(null);
              }
              else {
                setState(() {
                  selectedCategoryIndex = 2;
                });
                widget.callback(_getCategory());
              }
            },
            child: AnimatedContainer(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  gradient: (selectedCategoryIndex == 2) ? const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: Consts.mainGradient,
                  ) : null,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              duration: const Duration(milliseconds: 100),
              child: Text(
                "Marketing",
                style: TextStyle(
                    color: (selectedCategoryIndex == 2)
                        ? Colors.white.withAlpha(450)
                        : Colors.blue[600],
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (selectedCategoryIndex == 3){
                setState(() {
                  selectedCategoryIndex = 0;
                });
                widget.callback(null);
              }
              else {
                setState(() {
                  selectedCategoryIndex = 3;
                });
                widget.callback(_getCategory());
              }
            },
            child: AnimatedContainer(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  gradient: (selectedCategoryIndex == 3) ? const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: Consts.mainGradient,
                  ) : null,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              duration: const Duration(milliseconds: 100),
              child: Text(
                "Media",
                style: TextStyle(
                    color: (selectedCategoryIndex == 3)
                        ? Colors.white.withAlpha(450)
                        : Colors.blue[600],
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (selectedCategoryIndex == 4){
                setState(() {
                  selectedCategoryIndex = 0;
                });
                widget.callback(null);
              }
              else {
                setState(() {
                  selectedCategoryIndex = 4;
                });
                widget.callback(_getCategory());
              }
            },
            child: AnimatedContainer(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  gradient: (selectedCategoryIndex == 4) ? const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: Consts.mainGradient,
                  ) : null,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              duration: const Duration(milliseconds: 100),
              child: Text(
                "Technologies",
                style: TextStyle(
                    color: (selectedCategoryIndex == 4)
                        ? Colors.white.withAlpha(450)
                        : Colors.blue[600],
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
