import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/services/news_api.dart';

import '../../widgets/profile_page/profile_container.dart';
import '../../widgets/profile_page/profile_fitur.dart';

class ConsultantProfilePage extends StatelessWidget {
  final UserModel user;
  final NewsApi newsApi;
  const ConsultantProfilePage(
      {super.key, required this.user, required this.newsApi});

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
            ),
            const ProfileFitur(),
          ],
        )
      ],
    );
  }
}
