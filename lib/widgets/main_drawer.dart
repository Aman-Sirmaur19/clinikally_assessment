import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
          height: 150,
          padding: const EdgeInsets.only(top: 20, left: 20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).colorScheme.primary,
          child: const Text(
            'Dashboard',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        buildListTile(
          'Profile',
          CupertinoIcons.person,
          () {},
        ),
        buildListTile(
          'Cart',
          CupertinoIcons.cart,
          () {},
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text('MADE WITH ❤️ IN 🇮🇳',
              style: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              )),
        ),
      ],
    ));
  }
}
