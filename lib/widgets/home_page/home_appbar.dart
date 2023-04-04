import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 67,
      backgroundColor: Colors.deepOrange,
      title: Row(
        children: const [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage('https://i.pravatar.cc/100?u=lala'),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Muhammad Nur Faiz',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
      actions: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  'Jl. Ngagel Jaya Barat, Surabaya',
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.location_on,
                color: Colors.white,
              )
            ],
          ),
        )
      ],
    );
  }
}
