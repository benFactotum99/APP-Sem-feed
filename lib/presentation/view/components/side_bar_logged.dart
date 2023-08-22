import 'package:flutter/material.dart';

class SideBarLogged extends StatefulWidget {
  const SideBarLogged({super.key});

  @override
  State<SideBarLogged> createState() => _SideBarLoggedState();
}

class _SideBarLoggedState extends State<SideBarLogged> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home_view');
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Topics'),
            onTap: () {
              Navigator.pushNamed(context, '/waiters_view');
            },
          ),
        ],
      ),
    );
  }
}
