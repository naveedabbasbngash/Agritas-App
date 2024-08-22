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
    return Container(
      height: 40, // Fixed height for the TabBar
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
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: isSelected ? selectedColor : unselectedColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? selectedColor : borderColor,
                  width: 2.0,
                ),
              ),
              alignment: Alignment.center,
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
