import 'package:flutter/material.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  List<String> items = [
    'Logout',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Color.fromARGB(246, 250, 250, 250),
            elevation: 1,
            title: Text(
              "Profile",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: false,
            actions: [
              PopupMenuButton<String>(
                icon: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Icon(
                    Icons.menu,
                    color: Colors.blue,
                  ),
                ),
                itemBuilder: (BuildContext context) {
                  return items.map((String item) {
                    return PopupMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList();
                },
                onSelected: (String item) {
                  print(item);
                  if (item == "Logout") {
                    /*BlocProvider.of<AuthenticationBloc>(context).add(
                      AuthenticationBlocEventLogout(),
                    );*/
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 25),
          CircleAvatar(
            radius: 80.0,
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            child: Transform.scale(
              scale: 4,
              child: Icon(Icons.account_box_rounded),
            ),
          ),
          SizedBox(height: 25),
          Center(
            child: Text(
              "Daniele Benfatto",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "danielebenfatto2@gmail.com",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
