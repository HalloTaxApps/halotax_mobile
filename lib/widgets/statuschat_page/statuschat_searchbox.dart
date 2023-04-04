import 'package:flutter/material.dart';

class SearchBoxStatuschat extends StatelessWidget {
  const SearchBoxStatuschat({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cari',
        suffixIcon: GestureDetector(
          child: const Icon(
            Icons.search_outlined,
            color: Colors.deepOrange,
            size: 32,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.deepOrange,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.orange,
            width: 2,
          ),
        ),
      ),
    );
  }
}
