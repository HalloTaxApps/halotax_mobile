import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
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
        onPressed: () {},
        backgroundColor: Colors.deepOrange,
        child: const Icon(
          Icons.add,
          size: 36,
        ),
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: StatuschatAppbar(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SearchBoxStatuschat(),
              const SizedBox(
                height: 20,
              ),
              const NavigationStatuschat(),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.633,
                child: BerlangsungPage(
                  user: user,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
