import 'package:carousel_slider/carousel_slider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sem_feed/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:sem_feed/presentation/bloc/authentication/authentication_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/authentication/authentication_bloc_state.dart';
import 'package:sem_feed/presentation/view/components/custom_button.dart';
import 'package:sem_feed/presentation/view/components/show_my_dialog.dart';
import 'package:sem_feed/presentation/view/home/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const String route = "/";

  @override
  State<LoginView> createState() => _LoginViewState();
}

Widget cardCarousel(Icon icon, Text text) => Container(
      width: 400,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Color.fromARGB(255, 28, 126, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: text,
            ),
          ],
        ),
      ),
    );

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationBlocState>(
      listener: (context, state) async {
        if (state is AuthenticationBlocStateSuccessAuth) {
          Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ),
          );
        } else if (state is AuthenticationBlocStateErrorAuth) {
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
                subTitleSection(
                    "Enter the information you entered while registration."),
                SizedBox(height: 30),
                txtEmailSection(),
                SizedBox(height: 30),
                txtPasswordSection(),
                SizedBox(height: 20),
                buttonLoginSection(),
                SizedBox(height: 40),
                gotoSignUpSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  txtNameSection() => Container(
        width: 310,
        child: TextFormField(
          //controller: emailTextController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Il nome è obbligatoria';
            }
            return null;
          },
          cursorColor: Colors.blue,
          decoration: const InputDecoration(
            labelText: "Name",
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
      );

  txtSurnameSection() => Container(
        width: 310,
        child: TextFormField(
          //controller: emailTextController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Il cognome è obbligatorio';
            }
            return null;
          },
          cursorColor: Colors.blue,
          decoration: const InputDecoration(
            labelText: "Surname",
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
      );

  txtEmailSection() => Container(
        width: 310,
        child: TextFormField(
          controller: emailTextController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'L\'email è obbligatoria';
            } else if (!EmailValidator.validate(value)) {
              return 'Inserire un\'email valida';
            }
            return null;
          },
          cursorColor: Colors.blue,
          decoration: const InputDecoration(
            labelText: "Email",
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
      );

  txtPasswordSection() => Container(
        width: 310,
        child: TextFormField(
          controller: passwordTextController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'La password è obbligatoria';
            }
            return null;
          },
          cursorColor: Colors.blue,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            //prefixIcon: Icon(Icons.key, size: 30),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.blue,
              ),
            ),
          ),
          onChanged: (text) {},
        ),
      );

  txtConfirmPasswordSection() => Container(
        width: 310,
        child: TextFormField(
          //controller: passwordTextController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'La password è obbligatoria';
            }
            return null;
          },
          cursorColor: Colors.blue,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(
            labelText: "Confirm password",
            labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            //prefixIcon: Icon(Icons.key, size: 30),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.blue,
              ),
            ),
          ),
          onChanged: (text) {},
        ),
      );

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      //MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.blue;
  }

  Widget buttonLoginSection() =>
      BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
        builder: (context, state) {
          return CustomButton(
            text: 'Login',
            colorButton: Colors.blue,
            colorText: Colors.white,
            heightButton: 50,
            widthButton: 310,
            isLoading: state is AuthenticationBlocStateLoadingAuth,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  AuthenticationBlocEventLogin(
                    emailTextController.text,
                    passwordTextController.text,
                  ),
                );
              }
            },
          );
        },
      );

  Widget buttonSignupSection() => CustomButton(
        text: 'Sign up',
        colorButton: Colors.blue,
        colorText: Colors.white,
        heightButton: 50,
        widthButton: 310,
        isLoading: false,
        onPressed: () {
          if (formKey.currentState!.validate()) {}
        },
      );

  gotoSignUpSection() => InkWell(
        child: Text("Don't have an account? Sign up"),
        onTap: () {},
      );

  gotoLoginSection() => InkWell(
        child: Text("Have an account? Login"),
        onTap: () {},
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
}
