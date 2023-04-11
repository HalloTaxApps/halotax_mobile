import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/pages/consultant_pages/consultantprofile_page.dart';
import 'package:halotax/pages/consultant_pages/newchat_page.dart';
import 'package:halotax/pages/consultant_pages/ongoingchat_page.dart';
import 'package:halotax/pages/profile_page.dart';

import '../main.dart';

class ConsultantPage extends StatefulWidget {
  final UserModel user;
  const ConsultantPage({super.key, required this.user});

  @override
  State<ConsultantPage> createState() => _ConsultantPageState();
}

class _ConsultantPageState extends State<ConsultantPage> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late List<Widget> pages = [
    NewChatPage(user: widget.user),
    OngoingChatPage(user: widget.user),
    ConsultantProfilePage(user: widget.user),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  widget.user.image,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                widget.user.name,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                  (route) => false);
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepOrange[400],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onTap,
        iconSize: 24,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.new_label_outlined,
              color: Colors.white,
            ),
            label: 'Available Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_outline,
              color: Colors.white,
            ),
            label: 'On Going Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}