import 'package:flutter/material.dart';
import 'package:halotax/models/userAPI_model.dart';
import 'package:halotax/services/users_api.dart';

class TestPage extends StatefulWidget {
  final UserApi userApi;
  const TestPage({super.key, required this.userApi});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Buat Test'),
      ),
      body: FutureBuilder(
        future: widget.userApi.fetchUser(),
        builder: (context, AsyncSnapshot snapshot) {
          final userData = snapshot.data;
          if (snapshot.hasData) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    userData![0].name,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final datum = Datum(
                      name: 'Test',
                      birthday: '2002-01-26',
                      email: 'Test',
                      telephone: 'Test',
                      gender: 'Test',
                      address: 'Test',
                      role: 'Test',
                      image: 'Test',
                      username: 'Test',
                      password: 'Test',
                    );
                    // var user = UserApiModel(
                    //     code: 200, message: 'Success', data: [datum]);
                    var response = await UserApi().createUser([datum]);
                    if (response == null) return;
                    debugPrint('Sukses');
                  },
                  child: const Text('Submit'),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
