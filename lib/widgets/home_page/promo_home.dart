import 'package:flutter/material.dart';
import 'package:halotax/services/news_api.dart';

import '../../pages/news_view.dart';

class PromoHome extends StatefulWidget {
  const PromoHome({super.key});

  @override
  State<PromoHome> createState() => _PromoHomeState();
}

class _PromoHomeState extends State<PromoHome> {
  @override
  Widget build(BuildContext context) {
    NewsApi newsApi = NewsApi();

    return FutureBuilder(
      future: newsApi.fetchNews(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final articles = snapshot.data;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NewsView(article: articles[index])));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: 340,
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 1),
                            blurRadius: 1.5,
                          ),
                        ],
                        image: DecorationImage(
                          onError: (exception, stackTrace) {},
                          image: NetworkImage(
                            articles![index].urlToImage,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              height: 75,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          articles[index].title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        articles[index].publishedAt,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    child: Text(
                                      articles[index].description,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
