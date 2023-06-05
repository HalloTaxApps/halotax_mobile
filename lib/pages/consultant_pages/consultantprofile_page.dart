import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/services/news_api.dart';
import 'package:halotax/services/users_api.dart';

import '../../widgets/profile_page/profile_container.dart';
import '../../widgets/profile_page/profile_fitur.dart';

class ConsultantProfilePage extends StatelessWidget {
  final UserModel user;
  final NewsApi newsApi;
  final UserApi userApi;
  const ConsultantProfilePage(
      {super.key,
      required this.user,
      required this.newsApi,
      required this.userApi});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileContainer(
              user: user,
              newsApi: newsApi,
              userApi: userApi,
            ),
            const ProfileFitur(),
          ],
        )
      ],
    );
  }
}
