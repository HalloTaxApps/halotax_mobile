import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';

import '../widgets/bottomnavbar.dart';

class MateriPage extends StatefulWidget {
  final UserModel user;
  const MateriPage({super.key, required this.user});

  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(user: widget.user),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          'Nama Materi',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: ListView(
        children: [
          const Image(
            image: AssetImage("assets/images/illustrasi.jpg"),
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "TOPIK",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.remove_red_eye,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '1233',
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Judul Materi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Doloremque, quidem iusto vero molestiae atque officiis dolorum est labore harum fugit tempore quo amet nesciunt, officia dignissimos repellendus. Qui optio cumque eaque incidunt exercitationem aspernatur dolore, repudiandae ipsam odit voluptatibus asperiores, tempora quod quisquam ea nemo magni architecto nesciunt quos officia. Quo vel dolores mollitia? Sed veritatis aliquid veniam expedita magnam cupiditate qui aut? Debitis, fugiat sunt. Debitis, dolor dolore cum laborum voluptates deserunt eos veritatis officia harum fuga perferendis magni aperiam illo neque facilis enim consequuntur quisquam sapiente quaerat. Eligendi, beatae molestias, officia architecto vero excepturi deleniti veritatis laborum ratione ducimus culpa molestiae incidunt ea alias explicabo ad soluta consequatur. Cupiditate nobis fuga blanditiis provident consequatur quibusdam, asperiores minima. Itaque nemo labore quod, iure consequatur beatae velit quia ea? Sunt, modi. Quasi libero, eveniet nesciunt necessitatibus accusamus similique, reprehenderit ad quas dolore atque est natus adipisci in pariatur voluptatem. Non error, in illum voluptas rem excepturi voluptatem quod vero natus repudiandae libero quam molestiae, at dolore laborum dignissimos qui iste labore maxime consequatur placeat sunt ex cupiditate nostrum. Saepe perferendis, ex, libero maiores exercitationem illo nobis animi placeat officia repudiandae quo provident numquam adipisci. Sapiente nisi odio iste excepturi ipsam!',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
