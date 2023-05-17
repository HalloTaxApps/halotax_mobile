import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/services/news_api.dart';

import '../../pages/materi_page.dart';

class OtherHome extends StatelessWidget {
  final UserModel user;
  final NewsApi newsApi;
  const OtherHome({super.key, required this.user, required this.newsApi});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MateriPage(
                              newsApi: newsApi,
                              user: user,
                            )))
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://source.unsplash.com/600x400?study'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                'Judul Materi',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
