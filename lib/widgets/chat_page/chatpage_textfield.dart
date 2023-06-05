import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halotax/pages/statuschat_page.dart';

import '../../models/user_model.dart';
import '../../services/news_api.dart';
import '../../services/users_api.dart';

class ChatpageTextfield extends StatefulWidget {
  final UserModel user;
  final String userType;
  final NewsApi newsApi;
  final UserApi userApi;
  const ChatpageTextfield({
    super.key,
    required this.user,
    required this.userType,
    required this.newsApi,
    required this.userApi,
  });

  @override
  State<ChatpageTextfield> createState() => _ChatpageTextfieldState();
}

class _ChatpageTextfieldState extends State<ChatpageTextfield> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.33,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.deepOrange),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () async {
                  String message = _controller.text;
                  _controller.clear();
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.user.uid)
                      .collection('messages')
                      .add({
                    'status': 'new',
                    'type': widget.userType,
                    'last_msg': message,
                    'senderId': widget.user.uid,
                    'receiverId': '',
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatusChatPage(
                        userApi: widget.userApi,
                        user: widget.user,
                        newsApi: widget.newsApi,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
                child: const Text('Kirim'),
              ),
            ),
          ],
        )
      ],
    );
  }
}
