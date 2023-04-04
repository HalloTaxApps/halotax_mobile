import 'package:flutter/material.dart';

class StatuschatAppbar extends StatefulWidget {
  const StatuschatAppbar({super.key});

  @override
  State<StatuschatAppbar> createState() => _StatuschatAppbarState();
}

class _StatuschatAppbarState extends State<StatuschatAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 67,
      backgroundColor: Colors.deepOrange,
      titleSpacing: 0,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Status Chat',
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
      actions: [
        Row(
          children: const [
            Text(
              'Premium',
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              width: 20,
            )
          ],
        )
      ],
    );
  }
}
