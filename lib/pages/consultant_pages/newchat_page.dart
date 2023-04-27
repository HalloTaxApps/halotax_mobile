import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/pages/consultant_page.dart';
import 'package:halotax/pages/consultant_pages/ongoingchat_page.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

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
                          return user['role'] == 'Customer' &&
                                  msgStatus == 'new'
                              ? ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: CachedNetworkImage(
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
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      QuickAlert.show(
                                        context: context,
                                        barrierDismissible: true,
                                        type: QuickAlertType.warning,
                                        showCancelBtn: true,
                                        title: 'Accept this message?',
                                        confirmBtnText: 'Yes',
                                        cancelBtnText: 'No',
                                        confirmBtnColor: Colors.red,
                                        onConfirmBtnTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(widget.user.uid)
                                              .collection('messages')
                                              .doc(messageId)
                                              .collection('chats')
                                              .add({
                                            'senderId': senderId,
                                            'receiverId': widget.user.uid,
                                            'message': lastMsg,
                                            'date': DateTime.now(),
                                          }).then((value) => {
                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(widget.user.uid)
                                                        .collection('messages')
                                                        .doc(messageId)
                                                        .set({
                                                      'last_msg': lastMsg,
                                                      'senderId': senderId,
                                                      'status': 'on',
                                                      'type': msgType,
                                                      'receiverId':
                                                          widget.user.uid
                                                    })
                                                  });
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(senderId)
                                              .collection('messages')
                                              .doc(messageId)
                                              .collection('chats')
                                              .add({
                                            'senderId': senderId,
                                            'receiverId': widget.user.uid,
                                            'message': lastMsg,
                                            'date': DateTime.now(),
                                          }).then((value) => {
                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(senderId)
                                                        .collection('messages')
                                                        .doc(messageId)
                                                        .update({
                                                      'status': 'on',
                                                      'receiverId':
                                                          widget.user.uid,
                                                    })
                                                  });
                                          // ignore: use_build_context_synchronously
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ConsultantPage(
                                                  user: widget.user,
                                                  indexLuar: 1,
                                                ),
                                              ),
                                              (route) => false);
                                        },
                                      );
                                    },
                                  ),
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
