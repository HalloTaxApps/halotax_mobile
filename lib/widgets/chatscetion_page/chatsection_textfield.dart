import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';

class ChatsectionTexfield extends StatefulWidget {
  final UserModel user;
  final String currentId;
  final String friendId;
  const ChatsectionTexfield(
      {super.key,
      required this.user,
      required this.currentId,
      required this.friendId});

  @override
  State<ChatsectionTexfield> createState() => _ChatsectionTexfieldState();
}

class _ChatsectionTexfieldState extends State<ChatsectionTexfield> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(10),
              hintText: 'Type your message',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () async {
            String message = _controller.text;
            _controller.clear();
            await FirebaseFirestore.instance
                .collection('users')
                .doc(widget.currentId)
                .collection('messages')
                .doc(widget.friendId)
                .collection('chats')
                .add({
              'senderId': widget.currentId,
              'receiverId': widget.friendId,
              'message': message,
              'date': DateTime.now(),
            }).then((value) {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.currentId)
                  .collection('messages')
                  .doc(widget.friendId)
                  .set({
                'last_msg': message,
              });
            });

            await FirebaseFirestore.instance
                .collection('users')
                .doc(widget.friendId)
                .collection('messages')
                .doc(widget.currentId)
                .collection('chats')
                .add({
              'senderId': widget.currentId,
              'receiverId': widget.friendId,
              'message': message,
              'type': 'text',
              'date': DateTime.now(),
            }).then((value) {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.friendId)
                  .collection('messages')
                  .doc(widget.currentId)
                  .set({
                'last_msg': message,
              });
            });
          },
          icon: const Icon(
            Icons.send,
            color: Colors.white,
            size: 36,
          ),
        )
      ],
    );
  }
}
