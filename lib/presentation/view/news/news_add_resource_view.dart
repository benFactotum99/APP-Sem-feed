import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sem_feed/data/models/resource.dart';
import 'package:sem_feed/data/models/topic.dart';
import 'package:sem_feed/presentation/bloc/news/news_bloc.dart';
import 'package:sem_feed/presentation/bloc/news/news_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/resource/resource_bloc.dart';
import 'package:sem_feed/presentation/bloc/resource/resource_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/resource/resource_bloc_state.dart';
import 'package:sem_feed/presentation/bloc/topic/topic_bloc.dart';
import 'package:sem_feed/presentation/bloc/topic/topic_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/topic/topic_bloc_state.dart';
import 'package:sem_feed/presentation/view/account/login_view.dart';
import 'package:sem_feed/presentation/view/components/custom_button.dart';
import 'package:sem_feed/presentation/view/components/custom_text_form.dart';
import 'package:sem_feed/presentation/view/components/show_my_dialog.dart';

class NewsAddResourceView extends StatefulWidget {
  static const String route = '/news_add_resource_view';
  const NewsAddResourceView({super.key});

  @override
  State<NewsAddResourceView> createState() => _NewsAddResourceViewState();
}

class _NewsAddResourceViewState extends State<NewsAddResourceView> {
  final _linkController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Topic? dropdownValue = null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TopicBloc>(context).add(TopicBlocEventFetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResourceBloc, ResourceBlocState>(
      listener: (context, state) {
        if (state is ResourceBlocStateAdded) {
          BlocProvider.of<NewsBloc>(context)
              .add(NewsBlocEventFetch(isFirst: false));
          Navigator.of(context).pop();
        } else if (state is ResourceBlocStateFeedRssNotFound) {
          ShowMyDialog(
            context,
            "Errore",
            state.errorMessage,
          );
        } else if (state is ResourceBlocStateLogout) {
          Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginView(),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color.fromARGB(246, 250, 250, 250),
          centerTitle: false,
          title: Text(
            "New resource",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  linkTextSection(),
                  SizedBox(height: 20),
                  dropDownTopicSection(),
                  SizedBox(height: 40),
                  saveButtonSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  linkTextSection() => CustomTextForm(
        myLabelText: 'Link',
        textController: _linkController,
        onValidator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Il link è obbligatorio';
          }
          return null;
        },
        onChanged: (String? value) {},
      );

  saveButtonSection() => BlocBuilder<ResourceBloc, ResourceBlocState>(
        builder: (context, state) {
          return CustomButton(
            text: 'Salva',
            colorButton: Colors.blue,
            colorText: Colors.white,
            heightButton: 50,
            widthButton: 500,
            isLoading: state is ResourceBlocStateAdding,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (dropdownValue == null) {
                  ShowMyDialog(
                    context,
                    "Errore",
                    "Occorre prima selezionare un topic.",
                  );
                  return;
                }

                BlocProvider.of<ResourceBloc>(context).add(
                  ResourceBlocEventAdd(_linkController.text, dropdownValue!),
                );
              }
            },
          );
        },
      );

  dropDownTopicSection() => BlocBuilder<TopicBloc, TopicBlocState>(
        builder: (context, state) {
          if (state is TopicBlocStateLoaded) {
            var topics = state.topics;
            return SizedBox(
              height: 50,
              child: DropdownButton<Topic>(
                isExpanded: true,
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.blue),
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
                onChanged: (Topic? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: topics.map<DropdownMenuItem<Topic>>((Topic value) {
                  return DropdownMenuItem<Topic>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
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
