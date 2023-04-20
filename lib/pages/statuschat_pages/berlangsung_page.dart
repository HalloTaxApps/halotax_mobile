import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:halotax/pages/chatsection_page.dart';

class BerlangsungPage extends StatefulWidget {
  final UserModel user;
  const BerlangsungPage({super.key, required this.user});

  @override
  State<BerlangsungPage> createState() => _BerlangsungPageState();
}

class _BerlangsungPageState extends State<BerlangsungPage> {
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
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var friendId = snapshot.data!.docs[index]['receiverId'];
              var lastMsg = snapshot.data!.docs[index]['last_msg'];
              var msgStatus = snapshot.data!.docs[index]['status'];
              var messageId = snapshot.data!.docs[index].id;
              return msgStatus == 'on'
                  ? FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(friendId)
                          .get(),
                      builder: (context, AsyncSnapshot asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          var friend = asyncSnapshot.data;
                          return friend['role'] == 'Consultant'
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
                                          msgId: messageId,
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
                    )
                  : const SizedBox();
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
