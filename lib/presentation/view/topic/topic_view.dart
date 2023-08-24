import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sem_feed/presentation/bloc/topic/topic_bloc.dart';
import 'package:sem_feed/presentation/bloc/topic/topic_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/topic/topic_bloc_state.dart';

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
    return Center(
      child: Column(
        children: [
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.fromLTRB(41, 0, 20, 0),
            child: Row(
              children: [
                Text(
                  "Topics",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          listTopicSection(),
        ],
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
                        //await viewModel.removeItemCart(index);
                      },
                      child: InkWell(
                        onTap: () {},
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
