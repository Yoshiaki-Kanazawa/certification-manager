import 'package:flutter/material.dart';

// Headerの非状態クラス
//
// 以下の責務を持つ
// ・Headerを表示する
class Header extends StatelessWidget with PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text('資格管理'));
  }
}
