import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sem_feed/application/helpers/bottom_bar_menu_helper.dart';
import 'package:sem_feed/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:sem_feed/presentation/bloc/authentication/authentication_bloc_event.dart';
import 'package:sem_feed/presentation/view/account/login_view.dart';
import 'package:sem_feed/presentation/view/components/custom_button.dart';
import 'package:sem_feed/presentation/view/components/side_bar_logged.dart';
import 'package:sem_feed/presentation/view/news/news_view.dart';
import 'package:sem_feed/presentation/view/topic/topic_view.dart';
import 'package:sem_feed/presentation/view/user/user_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String route = '/home_view';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);
  BottomBarMenuHelper bottomBarMenuHelper = BottomBarMenuHelper.NEWS;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> bottomBarPages = [
    const NewsView(),
    const TopicView(),
    const UserView(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bottomBarMenuHelper == BottomBarMenuHelper.PROFILE
          ? appBarUserProfile()
          : null,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: Colors.white,
        showLabel: false,
        notchColor: Colors.white,
        removeMargins: false,
        bottomBarWidth: 500,
        durationInMilliSeconds: 300,
        bottomBarItems: [
          const BottomBarItem(
            inActiveItem: Icon(
              HeroIcons.newspaper,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              HeroIcons.newspaper,
              color: Colors.blueAccent,
            ),
            itemLabel: 'News',
          ),

          ///svg example
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.category,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.category,
              color: Colors.blueAccent,
            ),
            itemLabel: 'Topics',
          ),
          const BottomBarItem(
            inActiveItem: Icon(
              HeroIcons.user,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              HeroIcons.user,
              color: Colors.blueAccent,
            ),
            itemLabel: 'User',
          ),
        ],
        onTap: (index) {
          setState(() {
            switch (index) {
              case 0:
                bottomBarMenuHelper = BottomBarMenuHelper.NEWS;
                break;
              case 1:
                bottomBarMenuHelper = BottomBarMenuHelper.TOPICS;
                break;
              case 2:
                bottomBarMenuHelper = BottomBarMenuHelper.PROFILE;
                break;
            }
          });
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  List<String> items = [
    'Logout',
  ];

  appBarUserProfile() => AppBar(
        backgroundColor: Color.fromARGB(246, 250, 250, 250),
        elevation: 1,
        title: Text(
          "Profile",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          PopupMenuButton<String>(
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Icon(
                Icons.menu,
                color: Colors.blue,
              ),
            ),
            itemBuilder: (BuildContext context) {
              return items.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
            onSelected: (String item) {
              if (item == "Logout") {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  AuthenticationBlocEventLogout(),
                );

                Navigator.of(context, rootNavigator: true).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginView(),
                  ),
                );
              }
            },
          ),
        ],
      );
}
