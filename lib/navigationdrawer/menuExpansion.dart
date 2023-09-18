import 'package:flutter/material.dart';

Widget buildMenuExpansion({
  required String text,
  required IconData icon,
  required List<MenuItem> items,

}) {
  const color = Colors.black;
  const hoverColor = Colors.greenAccent;

  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      return ExpansionTile(
        title: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            const SizedBox(width: 32),
            Text(
              text,
              style: const TextStyle(color: color),
            ),
          ],
        ),

        childrenPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
        children: items.map((item) => buildMenuItem(item, hoverColor)).toList(),
      );
    },
  );
}


Widget buildMenuItem(MenuItem item, Color hoverColor) {
  const color = Colors.black;

  return ListTile(
    hoverColor: hoverColor,
    subtitle: GestureDetector(
      onTap: item.onClicked,
      child: Text(
        item.text,
        style: const TextStyle(color: color),
      ),
    ),
  );
}

class MenuItem {
  final String text;
  final VoidCallback onClicked;

  MenuItem({
    required this.text,
    required this.onClicked,
  });
}
