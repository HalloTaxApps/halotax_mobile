import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/pages/chat_page.dart';
import 'package:halotax/pages/statuschat_pages/berlangsung_page.dart';
import 'package:halotax/pages/statuschat_pages/menunggu_page.dart';
import 'package:halotax/pages/statuschat_pages/selesai_page.dart';
import 'package:halotax/services/users_api.dart';
import 'package:halotax/widgets/statuschat_page/statuschat_appbar.dart';
import 'package:halotax/widgets/statuschat_page/statuschat_navigation.dart';
import 'package:halotax/widgets/statuschat_page/statuschat_searchbox.dart';

import '../services/news_api.dart';
import '../widgets/bottomnavbar.dart';

class StatusChatPage extends StatefulWidget {
  final UserModel user;
  final int bodyIndex;
  final String searchKey;
  final NewsApi newsApi;
  final UserApi userApi;
  const StatusChatPage(
      {super.key,
      required this.user,
      this.bodyIndex = 0,
      this.searchKey = '',
      required this.newsApi,
      required this.userApi});

  @override
  State<StatusChatPage> createState() => _StatusChatPageState();
}

class _StatusChatPageState extends State<StatusChatPage> {
  late int _selectedIndex = widget.bodyIndex;

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late List<Widget> pages = [
    BerlangsungPage(
      user: widget.user,
      searchKey: widget.searchKey,
    ),
    MenungguPage(user: widget.user),
    SelesaiPage(user: widget.user),
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        userApi: widget.userApi,
        user: widget.user,
        newsApi: widget.newsApi,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        userApi: widget.userApi,
                        user: widget.user,
                        newsApi: widget.newsApi,
                      )));
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search_outlined,
                    color: Colors.deepOrange,
                    size: 32,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StatusChatPage(
                                  userApi: widget.userApi,
                                  user: widget.user,
                                  bodyIndex: _selectedIndex,
                                  searchKey: searchController.text,
                                  newsApi: widget.newsApi,
                                )));
                  },
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
            ),
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
