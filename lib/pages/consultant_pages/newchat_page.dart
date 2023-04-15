import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';

import '../chatsection_page.dart';

class NewChatPage extends StatefulWidget {
  final UserModel user;
  const NewChatPage({super.key, required this.user});

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collectionGroup('messages').snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No chats available'),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'New Available Chats',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var userId = snapshot.data!.docs[index]['senderId'];
                    var lastMsg = snapshot.data!.docs[index]['last_msg'];
                    return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .get(),
                      builder: (context, AsyncSnapshot asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          var user = asyncSnapshot.data;
                          return user['role'] == 'Customer'
                              ? ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: CachedNetworkImage(
                                      imageUrl: user['image'],
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      height: 50,
                                    ),
                                  ),
                                  title: Text(user['name']),
                                  subtitle: Text(
                                    "$lastMsg",
                                    // '',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatSectionPage(
                                          currentUser: widget.user,
                                          friendId: userId,
                                          friendName: user['name'],
                                          friendImage: user['image'],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const SizedBox();
                        }
                        return const LinearProgressIndicator(
                          color: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          minHeight: 1,
                        );
                      },
                    );
                  },
                ),
              )
            ],
          );
        }
        return const LinearProgressIndicator();
      },
    );
  }
}
