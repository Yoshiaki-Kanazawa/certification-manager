import 'package:flutter/material.dart';

class Header extends StatefulWidget with PreferredSizeWidget {
  final Sink<int> viewCtrl;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Header({Key? key, required this.viewCtrl}) : super(key: key);

  @override
  _Header createState() => _Header();
}

class _Header extends State<Header> {
  int pageIndex = 0;

  var titles = const ['ホーム', '資格リスト', '設定'];

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(titles.elementAt(pageIndex)));
  }
}
