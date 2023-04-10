import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';

import '../../widgets/profile_page/profile_container.dart';
import '../../widgets/profile_page/profile_fitur.dart';

class ConsultantProfilePage extends StatelessWidget {
  final UserModel user;
  const ConsultantProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileContainer(
              user: user,
            ),
            const ProfileFitur(),
          ],
        )
      ],
    );
  }
}
