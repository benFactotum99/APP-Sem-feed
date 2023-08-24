import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sem_feed/domain/arguments/news_detail_arguments.dart';
import 'package:sem_feed/presentation/bloc/news/news_bloc.dart';
import 'package:sem_feed/presentation/bloc/news/news_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/news/news_bloc_state.dart';
import 'package:sem_feed/presentation/view/account/login_view.dart';
import 'package:sem_feed/presentation/view/news/news_detail_view.dart';

class NewsView extends StatefulWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(NewsBlocEventFetch(isFirst: true));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<NewsBloc, NewsBlocState>(
      listener: (context, state) {
        if (state is NewsBlocStateLogout) {
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
              //backgroundColor: Colors.white,
              elevation: 1,
              title: Text(
                "News",
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
                      HeroIcons.document_plus,
                      color: Colors.blue,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            searchSection(),
            SizedBox(height: 20),
            listNewSection(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  searchSection() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            txtSearchSection(),
          ],
        ),
      ),
    );
  }

  listNewSection() {
    return BlocBuilder<NewsBloc, NewsBlocState>(
      builder: (context, state) {
        if (state is NewsBlocStateLoaded) {
          var newses = state.newses;
          return Expanded(
            child: Container(
              //height: 400,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  strokeWidth: 3,
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  onRefresh: () async {
                    await Future.delayed(Duration(milliseconds: 1500));
                    setState(() {
                      BlocProvider.of<NewsBloc>(context)
                          .add(NewsBlocEventFetch(isFirst: false));
                    });
                  },
                  child: ListView.separated(
                    padding: EdgeInsets.only(
                        bottom: kBottomNavigationBarHeight + 40),
                    shrinkWrap: true,
                    itemCount: newses.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 20,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            NewsDetailView.route,
                            arguments: NewsDetailArguments(newses[index]),
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
                                      newses[index].title.trim(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      newses[index].pubDate.trim(),
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(newses[index].content.trim()),
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
            ),
          );
        } else if (state is NewsBlocStateError) {
          return Center(child: Text(state.errorMessage));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  txtSearchSection() => Expanded(
        child: Container(
          height: 50,
          child: TextFormField(
            //controller: emailTextController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              /*if (value == null || value.isEmpty) {
                return 'Il nome è obbligatoria';
              }
              return null;*/
            },
            cursorColor: Colors.blue,
            decoration: const InputDecoration(
              labelText: "Search",
              labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              //prefixIcon: Icon(Icons.account_circle, size: 30),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.5, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.red,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.blue,
                ),
              ),
            ),
            onChanged: (text) {},
          ),
        ),
      );

  Widget buttonLoginSection() => SizedBox(
        height: 50,
        width: 70, //MediaQuery.of(context).size.width,
        //width: MediaQuery.of(context).size.width,
        child: MaterialButton(
          onPressed: () {},
          color: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Icon(
            Icons.search,
            size: 30,
          ),
          textColor: Colors.white,
        ),
      );
}
