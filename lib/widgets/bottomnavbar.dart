import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/pages/education_page.dart';
import 'package:halotax/pages/news_page.dart';
import 'package:halotax/pages/statuschat_page.dart';

import '../pages/chat_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';

class BottomNavbar extends StatefulWidget {
  final UserModel user;
  const BottomNavbar({super.key, required this.user});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => pages[_selectedIndex]),
          (route) => false);
    });
  }

  late List<Widget> pages = [
    HomePage(
      user: widget.user,
    ),
    NewsPage(
      user: widget.user,
    ),
    StatusChatPage(
      user: widget.user,
    ),
    EducationPage(
      user: widget.user,
    ),
    ProfilePage(
      user: widget.user,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
            Icons.home_outlined,
            color: Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.newspaper_outlined,
            color: Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat_bubble_outline,
            color: Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.book_outlined,
            color: Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
            color: Colors.white,
          ),
          label: '',
        ),
      ],
    );
  }
}
