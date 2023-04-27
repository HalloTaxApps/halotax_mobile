import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/pages/chat_page.dart';
import 'package:halotax/pages/statuschat_pages/berlangsung_page.dart';
import 'package:halotax/pages/statuschat_pages/menunggu_page.dart';
import 'package:halotax/pages/statuschat_pages/selesai_page.dart';
import 'package:halotax/widgets/statuschat_page/statuschat_appbar.dart';
import 'package:halotax/widgets/statuschat_page/statuschat_navigation.dart';
import 'package:halotax/widgets/statuschat_page/statuschat_searchbox.dart';

import '../widgets/bottomnavbar.dart';

class StatusChatPage extends StatefulWidget {
  final UserModel user;
  const StatusChatPage({super.key, required this.user});

  @override
  State<StatusChatPage> createState() => _StatusChatPageState();
}

class _StatusChatPageState extends State<StatusChatPage> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late List<Widget> pages = [
    BerlangsungPage(user: widget.user),
    MenungguPage(user: widget.user),
    SelesaiPage(user: widget.user),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        user: widget.user,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(user: widget.user)));
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                child: Text(
                  'Berlangsung',
                  style: TextStyle(
                      color: _selectedIndex == 0
                          ? Colors.deepOrange
                          : Colors.black),
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              GestureDetector(
                child: Text(
                  'Menunggu',
                  style: TextStyle(
                      color: _selectedIndex == 1
                          ? Colors.deepOrange
                          : Colors.black),
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
              GestureDetector(
                child: Text(
                  'Selesai',
                  style: TextStyle(
                      color: _selectedIndex == 2
                          ? Colors.deepOrange
                          : Colors.black),
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(child: pages[_selectedIndex]),
        ],
      ),
    );
  }
}
