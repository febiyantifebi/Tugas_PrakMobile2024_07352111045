import 'package:flutter/material.dart';

Widget SectionHeader(String sectionName) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        color: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          sectionName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          // Add your navigation or action here
        },
        child: Text(
          'View All',
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
