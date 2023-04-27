import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class MenungguPage extends StatefulWidget {
  final UserModel user;
  const MenungguPage({super.key, required this.user});

  @override
  State<MenungguPage> createState() => _MenungguPageState();
}

class _MenungguPageState extends State<MenungguPage> {
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
              var messageId = snapshot.data!.docs[index].id;
              var lastMsg = snapshot.data!.docs[index]['last_msg'];
              return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.user.uid)
                    .collection('messages')
                    .doc(messageId)
                    .get(),
                builder: (context, AsyncSnapshot asyncSnapshot) {
                  if (asyncSnapshot.hasData) {
                    var messages = asyncSnapshot.data;
                    return messages['status'] == 'new'
                        ? ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: CachedNetworkImage(
                                imageUrl: messages['type'] == 'Anonymous'
                                    ? 'https://cdn-icons-png.flaticon.com/512/180/180691.png'
                                    : widget.user.image,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(messages['type']),
                            subtitle: Text(
                              "$lastMsg",
                              style: const TextStyle(
                                color: Colors.grey,
                                overflow: TextOverflow.ellipsis,
                              ),
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
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
