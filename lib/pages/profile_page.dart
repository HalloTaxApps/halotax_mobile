import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:halotax/widgets/profile_page/profile_appbar.dart';
import 'package:halotax/widgets/profile_page/profile_container.dart';
import 'package:halotax/widgets/profile_page/profile_fitur.dart';

import '../main.dart';
import '../models/user_model.dart';
import '../widgets/bottomnavbar.dart';

class ProfilePage extends StatelessWidget {
  final UserModel user;
  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        user: user,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrange,
        title: Row(
          children: [
            const Text(
              'Hi, ',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              user.name,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                icon: const Icon(
                  Icons.logout_outlined,
                  size: 20,
                ),
              )
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileContainer(
                user: user,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black87,
                      offset: Offset(0, 0.5),
                      blurRadius: 1.0,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Kelola Langganan Premium',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
