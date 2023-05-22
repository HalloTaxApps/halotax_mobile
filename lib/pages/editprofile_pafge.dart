import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/services/news_api.dart';

import '../widgets/bottomnavbar.dart';

class EditProfile extends StatefulWidget {
  final UserModel user;
  final NewsApi newsApi;
  const EditProfile({super.key, required this.user, required this.newsApi});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        user: widget.user,
        newsApi: widget.newsApi,
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          'Profile ',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.user.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            var userSnapshot = snapshot.data;
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black87,
                          offset: Offset(0, 0.5),
                          blurRadius: 1.0,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 42,
                          backgroundColor: Colors.deepOrange,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(userSnapshot['image']),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.67,
                          child: Text(
                            userSnapshot['name'],
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Nama',
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            hintText: userSnapshot['name'],
                            hintStyle: const TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Email',
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            hintText: userSnapshot['email'],
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Role',
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            hintText: userSnapshot['role'],
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // const Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Text(
                        //     'Password',
                        //     style: TextStyle(color: Colors.deepOrange),
                        //   ),
                        // ),
                        // TextField(
                        //   obscureText: true,
                        //   controller: _passwordController,
                        //   decoration: InputDecoration(
                        //     contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        //     hintText: 'New Password',
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(5),
                        //       borderSide: const BorderSide(
                        //         color: Colors.deepOrange,
                        //         width: 2,
                        //       ),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(5),
                        //       borderSide: const BorderSide(
                        //         color: Colors.deepOrange,
                        //         width: 2,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // const Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Text(
                        //     'Re-type Password',
                        //     style: TextStyle(color: Colors.deepOrange),
                        //   ),
                        // ),
                        // TextField(
                        //   obscureText: true,
                        //   controller: _rePasswordController,
                        //   decoration: InputDecoration(
                        //     contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        //     hintText: 'Re-type Password',
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(5),
                        //       borderSide: const BorderSide(
                        //         color: Colors.deepOrange,
                        //         width: 2,
                        //       ),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(5),
                        //       borderSide: const BorderSide(
                        //         color: Colors.deepOrange,
                        //         width: 2,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.user.uid)
                                  .update({
                                'name': _nameController.text,
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                            ),
                            child: const Text('Update'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const LinearProgressIndicator();
            }
          }),
    );
  }
}
