import 'package:flutter/material.dart';

// ホーム画面の非状態クラス
//
// 以下の責務を持つ
// ・ホーム画面を表示する
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 60,
          color: Colors.grey[200],
          child: Column(
            children: <Widget>[
              Text('first line'),
              Text('second line'),
            ],
          ),
        ),
      ],
    );
  }
}
