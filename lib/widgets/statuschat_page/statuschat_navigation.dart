import 'package:flutter/material.dart';

class NavigationStatuschat extends StatelessWidget {
  const NavigationStatuschat({super.key});

  @override
  Widget build(BuildContext context) {
    Color indexAktif = Colors.deepOrange;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          child: Text(
            'Berlangsung',
            style: TextStyle(color: indexAktif),
          ),
        ),
        GestureDetector(
          child: const Text('Menunggu'),
        ),
        GestureDetector(
          child: const Text('Selesai'),
        ),
      ],
    );
  }
}
