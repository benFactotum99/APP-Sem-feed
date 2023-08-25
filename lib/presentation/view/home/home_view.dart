import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
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

  int maxCount = 3;
  int index = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const NewsView(),
    const TopicView(),
    const UserView(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
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
                  this.index = index;
                });
                _pageController.jumpToPage(index);
              },
            )
          : null,
    );
  }
}
