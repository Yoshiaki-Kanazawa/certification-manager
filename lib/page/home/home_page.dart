import 'package:certification_manager/logic/certification_list_store.dart';
import 'package:certification_manager/util/application_const.dart';
import 'package:flutter/material.dart';

// ホーム画面の非状態クラス
//
// 以下の責務を持つ
// ・ホーム画面を表示する
class HomePage extends StatelessWidget {
  // ストア
  final CertificationListStore _store = CertificationListStore();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future(
      () async {
        _store.load();
      },
    );
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 0,
          left: 10,
          right: 10,
        ),
        child: Text(
          '有効期限が1ヶ月以内の資格',
          style: TextStyle(fontSize: 15),
        ),
      ),
      const Divider(
        color: Colors.grey,
        thickness: 3,
        height: 15,
        indent: 0,
        endIndent: 0,
      ),
      ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _store.findByTermUntilExpiration(1).length,
          itemBuilder: (BuildContext context, int index) {
            var item = _store.findByTermUntilExpiration(1).elementAt(index);
            return Container(
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
                ]));
          })
    ]);
  }
}
