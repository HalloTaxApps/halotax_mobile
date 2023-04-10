import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/pages/chat_page.dart';
import 'package:halotax/pages/statuschat_pages/berlangsung_page.dart';
import 'package:halotax/widgets/statuschat_page/statuschat_appbar.dart';
import 'package:halotax/widgets/statuschat_page/statuschat_navigation.dart';
import 'package:halotax/widgets/statuschat_page/statuschat_searchbox.dart';

import '../widgets/bottomnavbar.dart';

class StatusChatPage extends StatelessWidget {
  final UserModel user;
  const StatusChatPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        user: user,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChatPage(user: user)));
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(
          Icons.add,
          size: 36,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrange,
        title: Row(
          children: const [
            Text(
              'Status Chat',
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        actions: [
          Row(
            children: const [
              Text(
                'Premium',
                // user.role,
              ),
              SizedBox(
                width: 20,
              )
            ],
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SearchBoxStatuschat(),
          ),
          const SizedBox(
            height: 20,
          ),
          const NavigationStatuschat(),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: BerlangsungPage(
              user: user,
            ),
          ),
        ],
      ),
    );
  }
}
