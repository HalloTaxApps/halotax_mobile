import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/widgets/chatscetion_page/chatsection_appbar.dart';
import 'package:halotax/widgets/chatscetion_page/chatsection_chat.dart';
import 'package:halotax/widgets/chatscetion_page/chatsection_textfield.dart';

import '../widgets/chatscetion_page/single_message.dart';

class ChatSectionPage extends StatelessWidget {
  final UserModel currentUser;
  final String friendId;
  final String friendName;
  final String friendImage;
  const ChatSectionPage(
      {super.key,
      required this.currentUser,
      required this.friendId,
      required this.friendName,
      required this.friendImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  friendImage,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                friendName,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser.uid)
                    .collection('messages')
                    .doc(friendId)
                    .collection('chats')
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length < 1) {
                      return const Center(
                        child: Text('No Messages'),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        bool isMe = snapshot.data.docs[index]['senderId'] ==
                            currentUser.uid;
                        return SingleMessage(
                          message: snapshot.data.docs[index]['message'],
                          isMe: isMe,
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 75,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 157, 127, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ChatsectionTexfield(
                user: currentUser,
                currentId: currentUser.uid,
                friendId: friendId,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
