import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sem_feed/domain/arguments/topic_edit_arguments.dart';
import 'package:sem_feed/presentation/bloc/topic/topic_bloc.dart';
import 'package:sem_feed/presentation/bloc/topic/topic_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/topic/topic_bloc_state.dart';
import 'package:sem_feed/presentation/view/account/login_view.dart';
import 'package:sem_feed/presentation/view/topic/topic_edit_view.dart';

class TopicView extends StatefulWidget {
  const TopicView({super.key});

  @override
  State<TopicView> createState() => _TopicViewState();
}

class _TopicViewState extends State<TopicView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TopicBloc>(context).add(TopicBlocEventFetch());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<TopicBloc, TopicBlocState>(
      listener: (context, state) {
        if (state is TopicBlocStateLogout) {
          Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginView(),
            ),
          );
        }
      },
      child: Center(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Color.fromARGB(246, 250, 250, 250),
              elevation: 1,
              title: Text(
                "Topics",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
              actions: [
                SizedBox(
                  width: 60,
                  height: 45,
                  child: IconButton(
                    iconSize: 28,
                    icon: Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        TopicEditView.route,
                        arguments: TopicEditArguments(null),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            listTopicSection(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  listTopicSection() {
    return BlocBuilder<TopicBloc, TopicBlocState>(
      builder: (context, state) {
        if (state is TopicBlocStateLoaded) {
          var topics = state.topics;
          return Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 20),
                  itemCount: topics.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(topics[index].id.toString()),
                      onDismissed: (direction) async {
                        BlocProvider.of<TopicBloc>(context)
                            .add(TopicBlocEventDelete(topics[index].id));
                      },
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            TopicEditView.route,
                            arguments: TopicEditArguments(topics[index]),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            children: [
                              //SizedBox(width: 20),
                              //Icon(Icons.newspaper, size: 100),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20),
                                    Text(
                                      topics[index].name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    Text(topics[index].description.trim()),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        } else if (state is TopicBlocStateError) {
          return Center(child: Text(state.errorMessage));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
