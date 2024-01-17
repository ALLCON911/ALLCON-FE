import 'package:allcon/pages/home.dart';
import 'package:flutter/material.dart';
import '../pages/mypage.dart';
import '../pages/search.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyPage()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHome()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Search()),
            );
/*             break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyCommu()),
            );
            break;*/
          default:
            onTap(index);
        }
      },
      currentIndex: currentIndex,
      showUnselectedLabels: true,
      selectedItemColor: Colors.redAccent,
      unselectedItemColor: Colors.black38,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: '마이',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          label: '검색',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.speaker_notes),
          label: '커뮤니티',
        ),
      ],
    );
  }
}