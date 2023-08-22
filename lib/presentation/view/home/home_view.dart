import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sem_feed/presentation/view/account/login_view.dart';
import 'package:sem_feed/presentation/view/components/custom_button.dart';
import 'package:sem_feed/presentation/view/components/side_bar_logged.dart';
import 'package:sem_feed/presentation/view/news/news_view.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Color.fromARGB(246, 243, 243, 243),
        child: const Center(child: Text('Page 2')));
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Color.fromARGB(246, 243, 243, 243),
        child: const Center(child: Text('Page 3')));
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Color.fromARGB(246, 243, 243, 243),
        child: const Center(child: Text('Page 4')));
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String route = '/home_view';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const NewsView(),
    const Page2(),
    const Page3(),
    const Page4(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: false,
              notchColor: Colors.white,

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              durationInMilliSeconds: 300,
              bottomBarItems: [
                const BottomBarItem(
                  inActiveItem: Icon(
                    HeroIcons.home,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    HeroIcons.home,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'Page 1',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    HeroIcons.document_plus,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    HeroIcons.document_plus,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'Page 2',
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
                  itemLabel: 'Page 3',
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
                  itemLabel: 'Page 4',
                ),
              ],
              onTap: (index) {
                _pageController.jumpToPage(index);
              },
            )
          : null,
    );
  }
}
