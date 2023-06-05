import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/pages/news_view.dart';
import 'package:halotax/services/news_api.dart';
import 'package:halotax/widgets/bottomnavbar.dart';

import '../models/article_model.dart';
import '../services/users_api.dart';

class NewsPage extends StatefulWidget {
  final UserModel user;
  final NewsApi newsApi;
  final UserApi userApi;
  const NewsPage(
      {super.key,
      required this.user,
      required this.newsApi,
      required this.userApi});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavbar(
          userApi: widget.userApi,
          user: widget.user,
          newsApi: widget.newsApi,
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepOrange,
          title: const Text(
            'News',
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: FutureBuilder(
          future: widget.newsApi.fetchNews(),
          builder: (context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              final articles = snapshot.data;
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
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
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Berita Populer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NewsView(article: articles[0])));
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(articles![0].urlToImage),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black87,
                              offset: Offset(0, 1),
                              blurRadius: 1.0,
                            )
                          ],
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            articles[0].title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          articles[0].publishedAt,
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
                                        articles[0].description,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 2,
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  for (var index = 1; index < articles.length; index++)
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewsView(article: articles[index])));
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          articles[index].urlToImage),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      child: Text(
                                        articles[index].title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      articles[index].publishedAt,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        articles[index].description,
                                        maxLines: 3,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
