import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sem_feed/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:sem_feed/presentation/bloc/authentication/authentication_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/authentication/authentication_bloc_state.dart';
import 'package:sem_feed/presentation/bloc/user/user_bloc.dart';
import 'package:sem_feed/presentation/bloc/user/user_bloc_state.dart';
import 'package:sem_feed/presentation/view/account/login_view.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                      "Daniele",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Benfatto",
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
                  SizedBox(height: 25),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
