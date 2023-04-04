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
        toolbarHeight: 70,
        backgroundColor: Colors.deepOrange,
        title: Row(
          children: [
            const Text('Hi, '),
            Text(
              user.name,
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
                icon: const Icon(Icons.logout_outlined),
              )
            ],
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileContainer(
                  user: user,
                ),
                const ProfileFitur(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
