import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sem_feed/data/helpers/user_session_helper.dart';
import 'package:sem_feed/data/repository/api/news_repository.dart';
import 'package:sem_feed/data/repository/api/user_repository.dart';
import 'package:sem_feed/domain/helpers/custom_init_app_helper.dart';
import 'package:sem_feed/domain/helpers/strings_helper.dart';
import 'package:sem_feed/domain/services/news_service.dart';
import 'package:sem_feed/domain/services/user_service.dart';
import 'package:sem_feed/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:sem_feed/presentation/bloc/news/news_bloc.dart';
import 'package:sem_feed/presentation/view/account/login_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sem_feed/presentation/view/home/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var value = await CustomInitAppHelper.isLoggedIn();
  if (value == true) {
    value = await CustomInitAppHelper.isValidToken();
  }
  runApp(
    MyApp(
      flagUser: value,
      flutterSecureStorage: FlutterSecureStorage(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool flagUser;
  final FlutterSecureStorage flutterSecureStorage;
  const MyApp(
      {super.key, required this.flagUser, required this.flutterSecureStorage});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
            userService: UserService(
              UserRepository(
                baseUrl,
                UserSessionHelper(
                  flutterSecureStorage,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => NewsBloc(
            newsService: NewsService(
              NewsRepository(
                baseUrl,
                UserSessionHelper(
                  flutterSecureStorage,
                ),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: AnimatedSplashScreen(
          backgroundColor: Colors.white,
          splash: Text(
            "Semfeed",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 50,
              //fontWeight: FontWeight.bold,
              fontFamily: 'Cookie',
            ),
            textAlign: TextAlign.center,
          ),
          nextScreen: flagUser == true ? HomeView() : LoginView(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
        ),
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(246, 250, 250, 250),
          primarySwatch: Colors.blue,
          unselectedWidgetColor: Colors.grey,
        ),

        //initialRoute: LoginView.route,
        onGenerateRoute: (settings) {
          final routes = {
            HomeView.route: (context) => HomeView(),
            LoginView.route: (context) => LoginView()
          };
          return MaterialPageRoute(builder: routes[settings.name]!);
        },
      ),
    );
  }
}
