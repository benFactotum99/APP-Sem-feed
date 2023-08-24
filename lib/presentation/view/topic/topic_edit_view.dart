import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sem_feed/data/models/user_session.dart';
import 'package:sem_feed/presentation/bloc/user/user_bloc.dart';

class TopicEditView extends StatefulWidget {
  static const String route = '/topic_edit_view';
  const TopicEditView({super.key});

  @override
  State<TopicEditView> createState() => _TopicEditViewState();
}

class _TopicEditViewState extends State<TopicEditView> {
  UserSession? userSession = null;

  void initAsync() async {
    userSession = await BlocProvider.of<UserBloc>(context).currentUser;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color.fromARGB(246, 250, 250, 250),
        centerTitle: false,
        title: Text(
          "New topic",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
