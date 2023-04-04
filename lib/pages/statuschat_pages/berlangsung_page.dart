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
  bool isSearch = false;

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
                    return ListTile(
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
                    );
                  }
                  return const LinearProgressIndicator();
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
    // return ListView(
    //   children: [
    //     Column(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(10),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               const CircleAvatar(
    //                 radius: 36,
    //                 backgroundColor: Colors.white,
    //                 child: CircleAvatar(
    //                   radius: 34,
    //                   backgroundImage:
    //                       NetworkImage('https://i.pravatar.cc/100?u=ryunosuke'),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 width: 20,
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 10),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     SizedBox(
    //                       width: MediaQuery.of(context).size.width * 0.55,
    //                       child: const Text(
    //                         'Drs. Ryunosuke Putra Alam',
    //                         style: TextStyle(
    //                           fontSize: 16,
    //                           fontWeight: FontWeight.bold,
    //                           overflow: TextOverflow.ellipsis,
    //                         ),
    //                       ),
    //                     ),
    //                     const SizedBox(
    //                       height: 10,
    //                     ),
    //                     SizedBox(
    //                       width: MediaQuery.of(context).size.width * 0.33,
    //                       child: const Text(
    //                         'Lorem ipsum dolor sit amet consectetur adipisicing elit. Magni excepturi omnis velit! Laborum voluptates dignissimos quis ipsum. Nisi, soluta hic.',
    //                         style: TextStyle(
    //                           color: Colors.grey,
    //                           overflow: TextOverflow.ellipsis,
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(10),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               const CircleAvatar(
    //                 radius: 36,
    //                 backgroundColor: Colors.white,
    //                 child: CircleAvatar(
    //                   radius: 34,
    //                   backgroundImage:
    //                       NetworkImage('https://i.pravatar.cc/100?u=ryunosuke'),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 width: 20,
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 10),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     SizedBox(
    //                       width: MediaQuery.of(context).size.width * 0.55,
    //                       child: const Text(
    //                         'Drs. Ryunosuke Putra Alam',
    //                         style: TextStyle(
    //                           fontSize: 16,
    //                           fontWeight: FontWeight.bold,
    //                           overflow: TextOverflow.ellipsis,
    //                         ),
    //                       ),
    //                     ),
    //                     const SizedBox(
    //                       height: 10,
    //                     ),
    //                     SizedBox(
    //                       width: MediaQuery.of(context).size.width * 0.33,
    //                       child: const Text(
    //                         'Lorem ipsum dolor sit amet consectetur adipisicing elit. Magni excepturi omnis velit! Laborum voluptates dignissimos quis ipsum. Nisi, soluta hic.',
    //                         style: TextStyle(
    //                           color: Colors.grey,
    //                           overflow: TextOverflow.ellipsis,
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
