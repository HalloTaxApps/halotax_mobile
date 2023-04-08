import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/pages/chat_page.dart';
import 'package:halotax/pages/main_page.dart';

class AboutHome extends StatefulWidget {
  final UserModel user;
  const AboutHome({super.key, required this.user});

  @override
  State<AboutHome> createState() => _AboutHomeState();
}

class _AboutHomeState extends State<AboutHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'Hallo',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Tax',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Text(
                'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Omnis iste consectetur inventore dolorem hic illum illo sint odio tempore voluptatem.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          user: widget.user,
                        )));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
          ),
          child: const Text('Chat Sekarang'),
        )
      ],
    );
  }
}
