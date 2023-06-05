import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/pages/education_page.dart';
import 'package:halotax/pages/news_page.dart';
import 'package:halotax/pages/statuschat_page.dart';
import 'package:halotax/services/news_api.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../services/users_api.dart';

class BottomNavbar extends StatefulWidget {
  final UserModel user;
  final NewsApi newsApi;
  final UserApi userApi;
  const BottomNavbar(
      {super.key,
      required this.user,
      required this.newsApi,
      required this.userApi});

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
      userApi: widget.userApi,
      user: widget.user,
      newsApi: widget.newsApi,
    ),
    NewsPage(
      userApi: widget.userApi,
      newsApi: widget.newsApi,
      user: widget.user,
    ),
    StatusChatPage(
      userApi: widget.userApi,
      user: widget.user,
      newsApi: widget.newsApi,
    ),
    EducationPage(
      userApi: widget.userApi,
      user: widget.user,
      newsApi: widget.newsApi,
    ),
    ProfilePage(
      userApi: widget.userApi,
      user: widget.user,
      newsApi: widget.newsApi,
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
