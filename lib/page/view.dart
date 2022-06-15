import 'package:certification_manager/page/home/home_page.dart';
import 'package:certification_manager/page/list/certification_list_page.dart';
import 'package:certification_manager/page/settings/settings_page.dart';
import 'package:flutter/material.dart';

class View extends StatefulWidget {
  final Stream<int> viewCtrl;

  View({Key? key, required this.viewCtrl}) : super(key: key);
  _View createState() => _View();
}

class _View extends State<View> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    listenPage();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [HomePage(), CertificationListPage(), SettingsPage()],
    );
  }

  listenPage() {
    widget.viewCtrl.listen((event) {
      _pageController.animateToPage(event, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }
}
