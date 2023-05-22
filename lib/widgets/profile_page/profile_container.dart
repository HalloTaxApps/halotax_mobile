import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/pages/editprofile_pafge.dart';
import 'package:halotax/services/news_api.dart';

class ProfileContainer extends StatelessWidget {
  final UserModel user;
  final NewsApi newsApi;
  const ProfileContainer(
      {super.key, required this.user, required this.newsApi});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          var userSnapshot = snapshot.data;
          if (snapshot.hasData) {
            return Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(5),
              height: 150,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(user.image),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  userSnapshot!['name'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const Text(
                                '+6281223344556',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: const [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '21 years',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: const [
                          Icon(
                            Icons.pin_drop_outlined,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Surabaya',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                        user: user, newsApi: newsApi)));
                          },
                          child: Column(
                            children: const [
                              Icon(
                                Icons.settings_outlined,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Settings',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
