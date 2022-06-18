import 'package:flutter/material.dart';

// 設定画面の非状態クラス
//
// 以下の責務を持つ
// ・設定画面を表示する
class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Hello settings."));
  }
}
