import 'package:certification_manager/bloc/view_ctrl_bloc.dart';
import 'package:certification_manager/page/common/footer.dart';
import 'package:certification_manager/page/common/header.dart';
import 'package:certification_manager/page/view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  late ViewCtrlBloc viewCtrl;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: Header(viewCtrl: viewCtrl.viewSink),
          body: View(viewCtrl: viewCtrl.viewStream),
          bottomNavigationBar: Footer(viewCtrl: viewCtrl.viewSink),
        ));
  }

  @override
  void initState() {
    super.initState();
    viewCtrl = ViewCtrlBloc();
  }

  @override
  void dispose() {
    viewCtrl.dispose();
    super.dispose();
  }
}
