import 'package:flutter/material.dart';

// footerの状態クラス
//
// 以下の責務を持つ
// ・洗濯中の画面に合わせてfooterを表示する
class Footer extends StatefulWidget {
  final Sink<int> viewCtrl;

  Footer({Key? key, required this.viewCtrl}) : super(key: key);

  @override
  _Footer createState() => _Footer();
}

class _Footer extends State<Footer> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _pageIndex,
      onTap: (pageIndex) {
        setState(() {
          _pageIndex = pageIndex;
        });
        widget.viewCtrl.add(_pageIndex);
      },
      selectedItemColor: Colors.blue,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
