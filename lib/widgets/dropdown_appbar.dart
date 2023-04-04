import 'package:flutter/material.dart';

class DropdownAppbar extends StatefulWidget {
  const DropdownAppbar({super.key});

  @override
  State<DropdownAppbar> createState() => _DropdownAppbarState();
}

class _DropdownAppbarState extends State<DropdownAppbar> {
  final _itemList = ['A', 'B'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: _itemList.map(((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e),
        );
      })).toList(),
      onChanged: (value) {},
    );
  }
}
