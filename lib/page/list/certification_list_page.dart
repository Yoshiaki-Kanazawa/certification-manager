import 'package:certification_manager/logic/certification_list_store.dart';
import 'package:certification_manager/model/certification_model.dart';
import 'package:certification_manager/page/common/header.dart';
import 'package:certification_manager/page/list/certification_input_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../util/application_const.dart';

// Certificationリスト画面のクラス
//
// 以下の責務を持つ
// ・Certificationリスト画面の状態を生成する
class CertificationListPage extends StatefulWidget {
  const CertificationListPage({Key? key}) : super(key: key);

  @override
  State<CertificationListPage> createState() => _CertificationListPage();
}

// Certificationリスト画面の状態クラス
//
// 以下の責務を持つ
// ・Certificationリストを表示する
// ・Certificationの追加/編集画面へ遷移する
// ・Certificationの削除を行う
class _CertificationListPage extends State<CertificationListPage> {
  // ストア
  final CertificationListStore _store = CertificationListStore();

  // Certificationリスト入力画面に遷移する
  void _pushCertificationInputPage([CertificationModel? certification]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CertificationInputPage(certification: certification);
        },
      ),
    );

    // Certificationの追加/更新を行う場合があるため、画面を更新する
    setState(() {});
  }

  /// 初期処理を行う
  @override
  void initState() {
    super.initState();

    Future(
      () async {
        // ストアからCertificationリストデータをロードし、画面を更新する
        setState(() => _store.load());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _store.count(),
        itemBuilder: (BuildContext context, int index) {
          var item = _store.findByIndex(index);
          return Slidable(
            // 右方向にリストアイテムをスライドした場合のアクション
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  onPressed: (context) {
                    // Certification編集画面に遷移する
                    _pushCertificationInputPage(item);
                  },
                  backgroundColor: Colors.blue,
                  icon: Icons.edit,
                  label: '編集',
                ),
              ],
            ),
            // 左方向にリストアイテムをスライドした場合のアクション
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  onPressed: (context) {
                    // Certificationを削除し、画面を更新する
                    setState(() => {_store.delete(item)});
                  },
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                  label: '削除',
                ),
              ],
            ),
            child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  ListTile(
                    title: Text(item.name,
                        style: const TextStyle(
                          fontSize: 20.0,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('取得  ${ApplicationConst().formatter.format(item.obtainedDate)}'),
                        const SizedBox(width: 20),
                        Text('期限  ${ApplicationConst().formatter.format(item.outdateDate)}'),
                      ],
                    ),
                  )
                ])),
          );
        },
      ),
      // Todo追加画面に遷移するボタン
      floatingActionButton: FloatingActionButton(
        // Todo追加画面に遷移する
        onPressed: _pushCertificationInputPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
