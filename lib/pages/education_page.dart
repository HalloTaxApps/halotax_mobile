import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/pages/materi_page.dart';
import 'package:halotax/widgets/bottomnavbar.dart';

import '../services/news_api.dart';
import '../services/users_api.dart';

class EducationPage extends StatelessWidget {
  final UserModel user;
  final NewsApi newsApi;
  final UserApi userApi;
  const EducationPage(
      {super.key,
      required this.user,
      required this.newsApi,
      required this.userApi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        userApi: userApi,
        user: user,
        newsApi: newsApi,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrange,
        title: const Text(
          'Education',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari',
                suffixIcon: GestureDetector(
                  child: const Icon(
                    Icons.search_outlined,
                    color: Colors.deepOrange,
                    size: 32,
                  ),
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
          for (var i = 0; i < 5; i++)
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MateriPage(
                                  userApi: userApi,
                                  newsApi: newsApi,
                                  user: user,
                                )))
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: 200,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        border: Border.all(
                          color: Colors.deepOrange,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 90,
                                decoration: const BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Topik',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const CircleAvatar(
                                radius: 42,
                                backgroundColor: Colors.deepOrange,
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      AssetImage('assets/images/hijabWork.jpg'),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Judul Topik',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.46,
                                child: const Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime unde saepe natus vero nostrum iure ut labore! Deleniti, perferendis obcaecati?',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 4,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
