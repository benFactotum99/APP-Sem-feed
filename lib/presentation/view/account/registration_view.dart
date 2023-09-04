import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sem_feed/data/models/user_req.dart';
import 'package:sem_feed/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:sem_feed/presentation/bloc/authentication/authentication_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/authentication/authentication_bloc_state.dart';
import 'package:sem_feed/presentation/view/components/custom_button.dart';
import 'package:sem_feed/presentation/view/components/custom_text_form.dart';
import 'package:sem_feed/presentation/view/components/show_my_dialog.dart';
import 'package:sem_feed/presentation/view/home/home_view.dart';

class RegistrationView extends StatefulWidget {
  static String route = "registration_view";

  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController surnameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationBlocState>(
      listener: (context, state) {
        if (state is AuthenticationBlocStateSuccessSignup) {
          Navigator.of(context).pop();
          Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ),
          );
        } else if (state is AuthenticationBlocStateErrorSignup) {
          ShowMyDialog(context, "Errore", state.errorMessage);
        }
      },
      child: Scaffold(
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                appTextSection(),
                SizedBox(height: 20),
                titleSection("Hey, hello 👋"),
                SizedBox(height: 5),
                subTitleSection("Enter the information."),
                SizedBox(height: 20),
                txtEmailSection(),
                SizedBox(height: 20),
                txtNameSection(),
                SizedBox(height: 20),
                txtSurnameSection(),
                SizedBox(height: 20),
                txtPasswordSection(),
                SizedBox(height: 20),
                txtConfirmPasswordSection(),
                SizedBox(height: 20),
                buttonSignupSection(),
                SizedBox(height: 40),
                gotoSignUpSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  gotoSignUpSection() => InkWell(
        child: Text("Have an account? Login"),
        onTap: () {
          Navigator.of(context).pop();
        },
      );

  appTextSection() => Container(
        width: 300,
        child: Text(
          "Semfeed",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 50,
            //fontWeight: FontWeight.bold,
            fontFamily: 'Cookie',
          ),
          textAlign: TextAlign.left,
        ),
      );

  titleSection(String text) => Container(
        width: 300,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );

  subTitleSection(String text) => Container(
        width: 300,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10,
          ),
        ),
      );

  txtEmailSection() => Container(
        width: 310,
        child: CustomTextForm(
          textController: emailTextController,
          myLabelText: 'Email',
          onChanged: (String? value) {},
          onValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Il nome è obbligatorio';
            }
            return null;
          },
        ),
      );

  txtNameSection() => Container(
        width: 310,
        child: CustomTextForm(
          textController: nameTextController,
          myLabelText: 'Name',
          onChanged: (String? value) {},
          onValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Il nome è obbligatorio';
            }
            return null;
          },
        ),
      );

  txtSurnameSection() => Container(
        width: 310,
        child: CustomTextForm(
          textController: surnameTextController,
          myLabelText: 'Surname',
          onChanged: (String? value) {},
          onValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Il cognome è obbligatorio';
            }
            return null;
          },
        ),
      );

  txtPasswordSection() => Container(
        width: 310,
        child: CustomTextForm(
          obscureText: true,
          textController: passwordTextController,
          myLabelText: 'Password',
          onChanged: (String? value) {},
          onValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'La password è obbligatoria';
            }

            return null;
          },
        ),
      );

  txtConfirmPasswordSection() => Container(
        width: 310,
        child: CustomTextForm(
          obscureText: true,
          textController: confirmPasswordTextController,
          myLabelText: 'Confirm password',
          onChanged: (String? value) {},
          onValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'La conferma password è obbligatoria';
            }
            if (value != passwordTextController.text) {
              return 'Le password non corrispondono';
            }
            return null;
          },
        ),
      );

  buttonSignupSection() =>
      BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
        builder: (context, state) {
          return CustomButton(
            text: 'Sign up',
            colorButton: Colors.blue,
            colorText: Colors.white,
            heightButton: 50,
            widthButton: 310,
            isLoading: state is AuthenticationBlocStateLoadingSignup,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  AuthenticationBlocEventSignup(
                    UserReq(
                      email: emailTextController.text,
                      name: nameTextController.text,
                      password: passwordTextController.text,
                      surname: surnameTextController.text,
                    ),
                  ),
                );
              }
            },
          );
        },
      );
}
