import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sem_feed/data/models/topic.dart';
import 'package:sem_feed/data/models/topic_req.dart';
import 'package:sem_feed/data/models/user_session.dart';
import 'package:sem_feed/application/arguments/topic_edit_arguments.dart';
import 'package:sem_feed/presentation/bloc/topic/topic_bloc.dart';
import 'package:sem_feed/presentation/bloc/topic/topic_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/topic/topic_bloc_state.dart';
import 'package:sem_feed/presentation/bloc/user/user_bloc.dart';
import 'package:sem_feed/presentation/view/components/custom_button.dart';
import 'package:sem_feed/presentation/view/components/custom_text_form.dart';

class TopicEditView extends StatefulWidget {
  static const String route = '/topic_edit_view';
  final TopicEditArguments topicEditArguments;
  const TopicEditView({required this.topicEditArguments});

  @override
  State<TopicEditView> createState() => _TopicEditViewState();
}

class _TopicEditViewState extends State<TopicEditView> {
  UserSession? userSession = null;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  void initAsync() async {
    userSession = await BlocProvider.of<UserBloc>(context).currentUser;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initAsync();
    if (widget.topicEditArguments.topic != null) {
      nameTextController.text = widget.topicEditArguments.topic!.name;
      descriptionTextController.text =
          widget.topicEditArguments.topic!.description;
    }
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
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                nameTextSection(),
                SizedBox(height: 20),
                descriptionTextSection(),
                SizedBox(height: 40),
                saveButtonSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  nameTextSection() => CustomTextForm(
        myLabelText: 'Nome',
        textController: nameTextController,
        onValidator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Il nome è obbligatorio';
          }
          return null;
        },
        onChanged: (String? value) {},
      );

  descriptionTextSection() => CustomTextForm(
        myLabelText: 'Descrizione',
        textController: descriptionTextController,
        onValidator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'La descrizione è obbligatoria';
          }
          var val = value.split(" ");
          if (val.length < 3 || val.contains("")) {
            return 'Inserire almeno tre parole valide';
          }
          return null;
        },
        onChanged: (String? value) {},
        maxLines: 5,
      );

  saveButtonSection() => BlocBuilder<TopicBloc, TopicBlocState>(
        builder: (context, state) {
          return CustomButton(
            text: 'Salva',
            colorButton: Colors.blue,
            colorText: Colors.white,
            heightButton: 50,
            widthButton: 500,
            isLoading: state is TopicBlocStateEditing,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (widget.topicEditArguments.topic != null) {
                  BlocProvider.of<TopicBloc>(context).add(
                    TopicBlocEventUpdate(
                      Topic(
                        id: widget.topicEditArguments.topic!.id,
                        user: userSession!.userId,
                        name: nameTextController.text,
                        description: descriptionTextController.text,
                        active: true,
                      ),
                    ),
                  );
                } else {
                  BlocProvider.of<TopicBloc>(context).add(
                    TopicBlocEventCreate(
                      TopicReq(
                        user: userSession!.userId,
                        name: nameTextController.text,
                        description: descriptionTextController.text,
                        active: true,
                      ),
                    ),
                  );
                }

                Navigator.of(context).pop();
              }
            },
          );
        },
      );
}
