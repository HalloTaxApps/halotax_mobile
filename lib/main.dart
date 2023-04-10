import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:halotax/pages/chatsection_page.dart';
import 'package:halotax/pages/consultant_page.dart';
import 'package:halotax/pages/home_page.dart';
import 'package:halotax/pages/login_page.dart';
import 'package:halotax/pages/main_page.dart';
import 'package:halotax/pages/splash_screen.dart';

import 'models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> userSignIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    // FirebaseAuth.instance.signOut();
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      UserModel userModel = UserModel.fromJson(userData);
      return userModel.role == 'Customer'
          ? HomePage(
              user: userModel,
            )
          : ConsultantPage(
              user: userModel,
            );
    } else {
      return const LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: userSignIn(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return const LayarSplash();
          }
        },
      ),
      // const LayarSplash(),
      // const ChatSectionPage(),
      // const LoginPage(),
      // const SigninPage(),
    );
  }
}
