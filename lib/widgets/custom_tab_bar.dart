import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final TabController controller;
  final List<Widget> tabs;
  final Color selectedColor;
  final Color unselectedColor;
  final Color borderColor;

  CustomTabBar({
    required this.controller,
    required this.tabs,
    required this.selectedColor,
    required this.unselectedColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the maximum width based on the largest tab
    double maxWidth = 0;
    for (var tab in tabs) {
      final textPainter = TextPainter(
        text: (tab as Text).data != null ? TextSpan(text: tab.data) : TextSpan(text: ''),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        maxLines: 1,
      )..layout(minWidth: 0, maxWidth: double.infinity);
      final width = textPainter.size.width;
      if (width > maxWidth) {
        maxWidth = width;
      }
    }

    // Add some padding to the calculated max width for better spacing
    maxWidth += 32.0; // 16dp padding on each side

    return Container(
      height: 50, // Fixed height for the TabBar
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          bool isSelected = controller.index == index;

          return GestureDetector(
            onTap: () {
              controller.animateTo(index); // Smooth animation when tapping a tab
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              width: maxWidth, // Set the width to the maximum calculated width
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? selectedColor : unselectedColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? selectedColor : borderColor,
                  width: 2.0,
                ),
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey, // White for active, gray for inactive
                ),
                child: tabs[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
