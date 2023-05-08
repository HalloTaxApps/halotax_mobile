import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';

import '../chatsection_page.dart';
import '../consultant_page.dart';

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
      // FirebaseFirestore.instance.collectionGroup('messages').snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
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
                const Expanded(
                  child: Center(
                    child: Text('No chats available'),
                  ),
                ),
              ],
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
                    var senderId = snapshot.data!.docs[index]['senderId'];
                    var lastMsg = snapshot.data!.docs[index]['last_msg'];
                    var msgStatus = snapshot.data!.docs[index]['status'];
                    var msgType = snapshot.data!.docs[index]['type'];
                    var messageId = snapshot.data!.docs[index].id;
                    return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(senderId)
                          .get(),
                      builder: (context, AsyncSnapshot asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          var user = asyncSnapshot.data;
                          return user['role'] == 'Customer' && msgStatus == 'on'
                              ? ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: msgType == 'Anonymous'
                                          ? 'https://cdn-icons-png.flaticon.com/512/180/180691.png'
                                          : user['image'],
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      height: 50,
                                    ),
                                  ),
                                  title: Text(msgType),
                                  subtitle: Text(
                                    "$lastMsg",
                                    // '',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.stop_circle_outlined,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(senderId)
                                          .collection('messages')
                                          .doc(messageId)
                                          .update({
                                        'status': 'done',
                                      });
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(widget.user.uid)
                                          .collection('messages')
                                          .doc(messageId)
                                          .delete();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ConsultantPage(
                                              user: widget.user,
                                              indexLuar: 1,
                                            ),
                                          ));
                                    },
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChatSectionPage(
                                                  currentUser: widget.user,
                                                  friendId: senderId,
                                                  friendName: user['name'],
                                                  friendImage: user['image'],
                                                  msgId: messageId,
                                                  msgStatus: msgType,
                                                )));
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
