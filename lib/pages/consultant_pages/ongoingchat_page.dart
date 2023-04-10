import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';

import '../chatsection_page.dart';

class OngoingChatPage extends StatefulWidget {
  final UserModel user;
  const OngoingChatPage({super.key, required this.user});

  @override
  State<OngoingChatPage> createState() => _OngoingChatPageState();
}

class _OngoingChatPageState extends State<OngoingChatPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.uid)
          .collection('messages')
          .snapshots(),
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
                  'On Going Chats',
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
                    var friendId = snapshot.data!.docs[index].id;
                    var lastMsg = snapshot.data!.docs[index]['last_msg'];
                    return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(friendId)
                          .get(),
                      builder: (context, AsyncSnapshot asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          var friend = asyncSnapshot.data;
                          return friend['role'] == 'Customer'
                              ? ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: CachedNetworkImage(
                                      imageUrl: friend['image'],
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      height: 50,
                                    ),
                                  ),
                                  title: Text(friend['name']),
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
                                          friendId: friendId,
                                          friendName: friend['name'],
                                          friendImage: friend['image'],
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
