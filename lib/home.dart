import 'package:flutter/material.dart';
import 'page/music_page.dart';
import 'page/picture_page.dart';
import 'page/text_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController = PageController();
  int navigationBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("只因宝盒"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationBarIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Image(
                image:
                    AssetImage("assets/image/navigation_bar/cock_crow32.png"),
              ),
              label: "坤鸣"),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage("assets/image/navigation_bar/ctrl.png"),
              ),
              label: "坤图"),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage("assets/image/navigation_bar/feet.png"),
              ),
              label: "坤文")
        ],
        onTap: ((index) {
          setState(() {
            navigationBarIndex = index;
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn);
          });
        }),
      ),
      body: PageView(
        controller: pageController,
        children: const [MusicPage(), PicturePage(), TextPage()],
        onPageChanged: (index) {
          setState(() {
            navigationBarIndex = index;
          });
        },
      ),
    );
  }
}
