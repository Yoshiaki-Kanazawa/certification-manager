import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  final Sink<int> viewCtrl;

  Footer({Key? key, required this.viewCtrl}) : super(key: key);

  @override
  _Footer createState() => _Footer();
}

class _Footer extends State<Footer> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: pageIndex,
      onTap: (_pageIndex) {
        pageIndex = _pageIndex;
        widget.viewCtrl.add(_pageIndex);
      },
      selectedItemColor: Colors.blue,
      items: const [
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
