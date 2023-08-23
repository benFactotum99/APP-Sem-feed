import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sem_feed/data/models/news.dart';
import 'package:sem_feed/data/models/topic.dart';
import 'package:sem_feed/data/models/topic_wrap.dart';
import 'package:sem_feed/data/models/user_session.dart';
import 'package:sem_feed/domain/arguments/news_detail_arguments.dart';
import 'package:sem_feed/domain/helpers/generic_helper.dart';
import 'package:sem_feed/domain/helpers/strings_helper.dart';
import 'package:sem_feed/presentation/bloc/user/user_bloc.dart';

class NewsDetailView extends StatefulWidget {
  static const String route = '/news_detail_view';
  final NewsDetailArguments newsDetailArguments;
  const NewsDetailView({required this.newsDetailArguments});

  @override
  State<NewsDetailView> createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> {
  List<TopicWrap> topics = List.empty(growable: true);
  UserSession? userSession = null;

  void initAsync() async {
    userSession = await BlocProvider.of<UserBloc>(context).currentUser;
    topics = widget.newsDetailArguments.news.topics
        .where((element) =>
            element.topic.user == userSession!.userId &&
            element.topic.active == true &&
            element.ranking > RANKING)
        .toList();
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Semfeed",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 35,
            //fontWeight: FontWeight.bold,
            fontFamily: 'Cookie',
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 25),
            detailNewsSection(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(41, 0, 20, 0),
              child: Row(
                children: [
                  Icon(
                    Icons.category,
                    color: Colors.blue,
                  ),
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
            topicsSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.public),
        onPressed: () {
          GenericHelper.launchInWebViewOrVC(
              Uri.parse(widget.newsDetailArguments.news.link));
        },
      ),
    );
  }

  detailNewsSection() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      widget.newsDetailArguments.news.title.trim(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.newsDetailArguments.news.pubDate.trim(),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(widget.newsDetailArguments.news.content.trim()),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
      );

  topicsSection() => Expanded(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ListView.separated(
              padding: EdgeInsets.only(bottom: 20),
              shrinkWrap: true,
              itemCount: topics.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 20,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
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
                                topics[index].topic.name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(topics[index].topic.description.trim()),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
}
