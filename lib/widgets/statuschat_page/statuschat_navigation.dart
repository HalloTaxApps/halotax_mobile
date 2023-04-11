import 'package:flutter/material.dart';

class NavigationStatuschat extends StatelessWidget {
  const NavigationStatuschat({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          child: const Text(
            'Berlangsung',
            style: TextStyle(color: Colors.black),
          ),
        ),
        GestureDetector(
          child: const Text(
            'Menunggu',
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
        GestureDetector(
          child: const Text('Selesai'),
        ),
      ],
    );
  }
}
