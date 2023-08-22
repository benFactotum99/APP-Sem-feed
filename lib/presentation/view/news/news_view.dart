import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sem_feed/presentation/bloc/news/news_bloc.dart';
import 'package:sem_feed/presentation/bloc/news/news_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/news/news_bloc_state.dart';

class NewsView extends StatefulWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(NewsBlocEventFetch());
  }

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 25),
          searchSection(),
          SizedBox(height: 20),
          listNewSection(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

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
                child: ListView.separated(
                  padding:
                      EdgeInsets.only(bottom: kBottomNavigationBarHeight + 40),
                  shrinkWrap: true,
                  itemCount: newses.length,
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
