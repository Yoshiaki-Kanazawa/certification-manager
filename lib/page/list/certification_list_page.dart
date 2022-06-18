import 'package:certification_manager/logic/certification_list_store.dart';
import 'package:certification_manager/model/certification_model.dart';
import 'package:certification_manager/page/list/certification_input_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

  // ソート要素の初期値
  String? _isSelectedItem = ApplicationConst().sortOrderEarliestExpirationDate;

  // ソート要素のリスト
  final _sortItems = <DropdownMenuItem<String>>[
    DropdownMenuItem(
      value: ApplicationConst().sortOrderEarliestExpirationDate,
      child: Text(ApplicationConst().sortOrderEarliestExpirationDate),
    ),
    DropdownMenuItem(
      value: ApplicationConst().sortOrderCertificationName,
      child: Text(ApplicationConst().sortOrderCertificationName),
    ),
    DropdownMenuItem(
      value: ApplicationConst().sortOrderEarliestObtainedDate,
      child: Text(ApplicationConst().sortOrderEarliestObtainedDate),
    ),
  ];

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
    setState(() {
      // 追加直後の資格情報はソートされていないので画面更新時にソートを行う
      _store.certificationList.sort((a, b) => a.outdateDate.compareTo(b.outdateDate));
    });
  }

  // Certificationリストをソートする
  void _sortCertificationListBySortOrder(String sortOrder) {
    if (sortOrder == ApplicationConst().sortOrderEarliestExpirationDate) {
      _store.certificationList.sort((a, b) => a.outdateDate.compareTo(b.outdateDate));
    } else if (sortOrder == ApplicationConst().sortOrderCertificationName) {
      _store.certificationList.sort((a, b) => a.name.compareTo(b.name));
    } else if (sortOrder == ApplicationConst().sortOrderEarliestObtainedDate) {
      _store.certificationList.sort((a, b) => a.obtainedDate.compareTo(b.obtainedDate));
    }
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
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 0,
                left: 10,
                right: 10,
              ),
              child: DropdownButton<String>(
                items: _sortItems,
                onChanged: (value) {
                  setState(() {
                    _isSelectedItem = value;
                    _sortCertificationListBySortOrder(_isSelectedItem!);
                  });
                },
                value: _isSelectedItem,
              )),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
                            Text('取得日  ${ApplicationConst().formatter.format(item.obtainedDate)}'),
                            const SizedBox(width: 20),
                            // 有効期限と現在日時の差によって表示方法変更
                            item.outdateDate.isBefore(DateTime.now())
                                ? Text(
                                    '有効期限  ${ApplicationConst().formatter.format(item.outdateDate)}',
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ),
                                  )
                                : item.outdateDate.difference(DateTime.now()).inDays <= 31
                                    ? Text(
                                        '有効期限  ${ApplicationConst().formatter.format(item.outdateDate)}',
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 242, 225, 71),
                                        ),
                                      )
                                    : Text('有効期限  ${ApplicationConst().formatter.format(item.outdateDate)}'),
                          ],
                        ),
                      )
                    ])),
              );
            },
          ),
        ]),
        // Todo追加画面に遷移するボタン
        floatingActionButton: FloatingActionButton(
          // Todo追加画面に遷移する
          onPressed: _pushCertificationInputPage,
          child: const Icon(Icons.add),
        ));
  }
}
