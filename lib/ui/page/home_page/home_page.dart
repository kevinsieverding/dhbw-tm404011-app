import 'package:flutter/material.dart';
import 'package:times/ui/page/home_page/view/highscore_view.dart';
import 'package:times/ui/page/home_page/view/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selection = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: _getWidget(_selection),
            bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.people), label: 'Freunde'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Zuhause'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list), label: 'Punkte')
                ],
                currentIndex: _selection,
                onTap: (index) {
                  setState(() {
                    _selection = index;
                  });
                })));
  }

  Widget _getWidget(int index) {
    switch (index) {
      case 0:
      case 1:
        return const HomeView();
      case 2:
      default:
        return const HighscoreView();
    }
  }
}
