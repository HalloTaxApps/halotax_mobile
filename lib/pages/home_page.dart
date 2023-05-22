import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:halotax/models/user_model.dart';
import 'package:halotax/widgets/bottomnavbar.dart';
import 'package:halotax/widgets/home_page/about_home.dart';
import 'package:halotax/widgets/home_page/other_home.dart';
import 'package:halotax/widgets/home_page/promo_home.dart';

import '../services/news_api.dart';

class HomePage extends StatelessWidget {
  final UserModel user;
  final NewsApi newsApi;
  const HomePage({super.key, required this.user, required this.newsApi});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          var userSnapshot = snapshot.data;
          if (snapshot.hasData) {
            return Scaffold(
              bottomNavigationBar: BottomNavbar(
                user: user,
                newsApi: newsApi,
              ),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.deepOrange,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(userSnapshot['image']),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            const Text(
                              'Welcome, ',
                              style: TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                userSnapshot['name'],
                                style: const TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              body: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: AboutHome(
                          user: user,
                          newsApi: newsApi,
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(bottom: 20, left: 20),
                                child: const Text(
                                  'Berita Menarik',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: const PromoHome(),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(bottom: 20, left: 20),
                                child: const Text(
                                  'Cari Tahu Tentang',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: OtherHome(
                              newsApi: newsApi,
                              user: user,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
