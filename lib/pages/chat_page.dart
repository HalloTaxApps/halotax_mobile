import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/pages/statuschat_page.dart';
import 'package:halotax/widgets/chat_page/chatpage_appbar.dart';
import 'package:halotax/widgets/chat_page/chatpage_textfield.dart';

import '../widgets/bottomnavbar.dart';

class ChatPage extends StatefulWidget {
  final UserModel user;
  const ChatPage({super.key, required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late List<String> _status = ['Anonymous', widget.user.name];
  late String _dropDownStatus = _status.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        user: widget.user,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: Colors.deepOrange,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(widget.user.image),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.user.name,
                  style: const TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StatusChatPage(
                            user: widget.user,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: const [
                  Text(
                    'Status Chat',
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.mail_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.67,
                child: const Text(
                  'Kirim Pesan Untuk Memulai Konsultasi',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fugit, expedita ipsa sint, quaerat magni quisquam nostrum aut ipsum aperiam fuga laborum accusantium inventore mollitia nobis sapiente at, veniam adipisci aliquam aliquid nulla vel! Repellendus nemo repellat, voluptas ratione optio necessitatibus.',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 150,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.deepOrange,
                    width: 1,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _dropDownStatus,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    items: _status
                        .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(
                                  width: 100,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _dropDownStatus = value.toString();
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const ChatpageTextfield(),
          ],
        ),
      ),
    );
  }
}
